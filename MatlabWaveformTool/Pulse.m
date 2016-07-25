classdef Pulse < handle
    %PULSE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Phases          = Phase.empty;       %only contains user-generated phases
        Frequency       = 0;
        Rules           = [];
        RandomPR        = [];          %random passive recovery multiplier, between 0 and 0.1
        Active          = false;
        
        %phase properties
        PrePulseWidth               = 0;
        DelayWidth                  = 0;
        WarmUpWidth                 = 0;
        ReloadWidth                 = 0;
        ArbitrationWidth            = 0;
        InterPhaseWidth             = 0;
        PassiveRecoveryWidth        = 0;
        HoldoffTime                 = 0;
    end
    
    methods
        function p=Pulse(constraints)
            p.Constraints=constraints;
            p.RandomPR = 0.1 * rand();
        end
        
        function n = NumUserPhases(obj)
            n = length(obj.Phases);
        end
        
        function AddPhase(obj, p)
            obj.Phases(end+1)=p;
        end     
        
        function AddPhases(obj, phases)
            obj.Phases = [obj.Phases, phases];
        end
        
        %generates user-configurable phases based on user input into the GUI
        function GeneratePhases(obj, ampType, widthType, minAmp, maxAmp, ampStep, minWidth, maxWidth, widthStep, num)
            newPhases = repmat(Phase([],[],[],[],[],[],[],PhaseTypes.Fixed, PhaseTypes.Fixed), 1,num);
                        
            for i=1:num       
                newPhases(i) = Phase(  PhaseTypes.RectConfigurable, minAmp, maxAmp, ampStep, ...
                                       minWidth, maxWidth, widthStep, ampType, widthType, 0);
            end
            
            obj.AddPhases(newPhases);
        end
        
        function P = GetAllPhases(obj)
            delayPhase = Phase.StaticPhase(0, obj.Constraints.TimeDelay);
            warmupPhase = Phase.StaticPhase(0, obj.Constraints.TimeWarmup);
            prePulsePhase = Phase.StaticPhase(obj.Constraints.AmplitudePrePulse, obj.Constraints.TimePrePulse);
            
            %add the interphase delay between each user-set phase
            if obj.NumUserPhases() == 0
                userPhases = [];
            else
                userPhases = repmat(Phase([],[],[],[],[],[],[],PhaseTypes.Fixed, PhaseTypes.Fixed), 1,obj.NumUserPhases()*2-1);
                for i = 1:obj.NumUserPhases()
                    if i == obj.NumUserPhases()
                        userPhases(end) = obj.Phases(obj.NumUserPhases());
                    else
                        userPhases(2*i - 1) = obj.Phases(i);
                        userPhases(2*i) = Phase.StaticPhase(0,obj.Constraints.TimeInterPhase);
                    end
                end
            end
            P = [delayPhase, warmupPhase, prePulsePhase, userPhases];
            
            %compute total area to calculate the passiverecovery starting value
            %from the area and width of PR, calculate its starting
            %point 
            recoveryPhase = Phase.PassiveRecovery(P, obj.Constraints.TimePassiveRecovery);
            P = [P, recoveryPhase];
            
            %interpulse phase width is determined by the period of the
            %pulse
            interPulseTime = 0;
            for i=1:length(P)
                interPulseTime = interPulseTime + P(i).Width.value;
            end
            interPulsePhase = Phase.StaticPhase(0, obj.GetInterPulseWidth(interPulseTime));
            
            P = [P,interPulsePhase] ;
        end
        
        %takes in the rate (Hz)of the pulse and sets the period (us)
        function p = Period(obj)       
            p = round(1e6/obj.Frequency);
        end
        
        function t = GetInterPulseWidth(obj, startTime)
            t = obj.Period() - startTime;
            if t<0
                t = 0;
            end
        end
        
        %Y{1} is cell array of time data
        %Y{2} is cell array of amplitude data
        function Y = GetAxesData(obj)
            allPhases = obj.GetAllPhases();
            t=cell(1,length(allPhases));   
            y=cell(1,length(allPhases));
            start = 0;
            for i=1:length(allPhases)
                phaseAxes = allPhases(i).GenerateArrays(start);
                t{i} = phaseAxes{1};
                y{i} = phaseAxes{2};
                start = start+allPhases(i).Width.value;
            end
            Y.time = cell2mat(t);
            Y.signal = cell2mat(y);
        end
        
        %refresh num is the pulse after it is refreshed num times
        function p = RefreshPulse(obj, refreshNum)
            p = Pulse(obj.Constraints);
            refreshedPhases = repmat(Phase([],[],[],[],[],[],[],PhaseTypes.Fixed, PhaseTypes.Fixed, []), 1,obj.NumUserPhases());
            for i=1:obj.NumUserPhases()
                refreshedPhases(i)= obj.Phases(i).RefreshPhase(refreshNum);
            end
            p.AddPhases(refreshedPhases);
        end
        
        function Tabulate(obj, hTable)              %tabulates the attributes of each phase carried by the pulse
            for i=1:obj.NumUserPhases()
                currentPhase=obj.Phases(i);
                row{1}=currentPhase.Amplitude.value;
                row{2}=currentPhase.Width.value;
                switch currentPhase.AmpType
                    case PhaseTypes.Fixed
                        row{3}='Fixed';
                    case PhaseTypes.Stochastic
                        row{3}='Stochastic';
                    case PhaseTypes.Ramped
                        row{3}='Ramping'; 
                end
                switch currentPhase.WidthType
                    case PhaseTypes.Fixed
                        row{4}='Fixed';
                    case PhaseTypes.Stochastic
                        row{4}='Stochastic';
                    case PhaseTypes.Ramped
                        row{4}='Ramping'; 
                end
                hTable.Data = [hTable.Data;row];
            end
        end
        
        
        function SetPhaseAmplitude(obj, i, newAmp)       %changes the amplitude of the phase indexed by i
            if (i<1) || (i>obj.NumUserPhases())
                return;
            end
            obj.Phases(i).Amplitude.value = newAmp;
        end
        
        function SetPhaseWidth(obj, i, newWidth)         %changes the width of the phase indexed by i
            if (i<1) || (i>obj.NumUserPhases())
                return;
            end
            obj.Phases(i).Width.value = newWidth;
        end
        
        %scale is number from 0 to 1, indicating scalar multiplication of
        %the y-axis
        function Plot(obj, axesHandle, startTime, num, scale)
            if num < 1
                num = 1;
            end
            Y = obj.GetAxesData();
            
            cla(axesHandle, 'reset');
            axes(axesHandle);
            time = startTime;
            I = cell(1, num);
            T = cell(1, num);
            for i=1:num
                T{i} = Y.time + time;
                I{i} = Y.signal;
                time = time + obj.Period();
            end
            t = cell2mat(T);
            i = scale * cell2mat(I);
            plot(t, i);
            xlabel('Time (\mus)');
            ylabel('Current (mA)');
            grid on;
        end
        
        %generates a real-time plot, similar to oscilloscope
        function MovingPlot(obj, axesHandle, scale, num)
            
            dT = 100;
            cla(axesHandle, 'reset');
            axes(axesHandle);
            
            Data = obj.GetAxesData();
            T = Data.time;
            Y = scale * Data.signal;
            
            n=0;
            h = plot(T,Y);
            set(gcf, 'renderer', 'painters');
            while n<num && ishandle(h)
                h.XData = T + dT;
                firstVal = h.YData(1:dT);
                h.YData(1:end-dT) = h.YData(1+dT:end);
                h.YData((end-dT + 1):end) = firstVal;
                
                
                drawnow;       
                n=n+1;
            end
        end
            
        function n = MaxElectrodes(obj)
            n = obj.Constraints.MaxElectrodes;
        end
        
        %IMPLEMENT IN FUTURE, ALL CHILD CLASSES NEED TO IMPLEMENT THIS
        function e = Energy(obj)
            e = 0;
        end
        
        %***********************Falcon Functions***************************
        
    end
end