classdef Pulse < handle
    %PULSE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Phases = Phase.empty;  
        Frequency = 0;
        Constraints = [];
        RandomPR = [];          %random passive recovery multiplier, between 0 and 0.1
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
            delayPhase = Phase.StaticPhase(0, obj.Constraints.DelayEnabled * obj.Constraints.TimeDelay);
            warmupPhase = Phase.StaticPhase(0, obj.Constraints.WarmupEnabled * obj.Constraints.TimeWarmup);
            prePulsePhase = Phase.StaticPhase(obj.Constraints.PrePulseEnabled * obj.Constraints.AmplitudePrePulse, obj.Constraints.PrePulseEnabled * obj.Constraints.TimePrePulse);
            
            %add the interphase delay between each user-set phase
            if obj.NumUserPhases() == 0
                userPhases = [];
            else
                if obj.Constraints.InterPhaseEnabled
                    userPhases = repmat(Phase([],[],[],[],[],[],[],PhaseTypes.Fixed, PhaseTypes.Fixed), 1,obj.NumUserPhases()*2-1);
                    for i = 1:obj.NumUserPhases()
                        if i == obj.NumUserPhases()
                            userPhases(end) = obj.Phases(obj.NumUserPhases());
                        else
                            userPhases(2*i - 1) = obj.Phases(i);
                            userPhases(2*i) = Phase.StaticPhase(0,obj.Constraints.TimeInterPhase);
                        end
                    end
                else
                    userPhases = obj.Phases;
                end
            end
            P = [delayPhase, warmupPhase, prePulsePhase, userPhases];
            
            %compute total area to calculate the passiverecovery starting value
            area=0;
            for i=1:length(P)
                area = area + P(i).Area();
            end
            %from the area and width of PR, calculate its starting
            %point 
            startPoint = obj.Constraints.PassiveRecoveryEnabled * obj.ComputePassiveRecoveryHeight(area);
            recoveryPhase = Phase.PassiveRecovery(startPoint, obj.Constraints.PassiveRecoveryEnabled * obj.Constraints.TimePassiveRecovery);
            P = [P, recoveryPhase];
            
            %interpulse phase width is determined by the period of the
            %pulse
            if obj.Constraints.InterPulseEnabled
                time = 0;
                for i=1:length(P)
                    time = time + P(i).Width.value;
                end
                interPulsePhase = Phase.StaticPhase(0, obj.GetInterPulseWidth(time));
            else
                interPulsePhase = Phase.StaticPhase(0, 0);
            end
            
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
        
        function Y = GetAxesData(obj, startTime)
            allPhases = obj.GetAllPhases();
            t=cell(1,length(allPhases));   
            y=cell(1,length(allPhases));
            start = startTime;
            for i=1:length(allPhases)
                phaseAxes = allPhases(i).GenerateArrays(start);
                t{i} = phaseAxes{1};
                y{i} = phaseAxes{2};
                start = start+allPhases(i).Width.value;
            end
            Y{1}=cell2mat(t);
            Y{2}=cell2mat(y);
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
        
        %in future: account for exponential passive recovery
        function h = ComputePassiveRecoveryHeight(obj, area)
            h=0;
            width = obj.Constraints.TimePassiveRecovery;
            if area ~= 0
                h = -2*area / width;
            else
                switch obj.Constraints.Mode
                    case Constants.MODE_FALCON
                        h = obj.RandomPR * obj.Phases(1).Amplitude.value;
                end
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
        
        %***********************Falcon Functions***************************
        function GenerateFalconPhases(obj, globalAmp, globalWidth, isActive)
            if isActive
                p1 = Phase(PhaseTypes.RectConfigurable, -globalAmp, -globalAmp, 0, globalWidth, globalWidth, 0, PhaseTypes.Fixed, PhaseTypes.Fixed, 0);
                p2 = Phase(PhaseTypes.RectConfigurable, globalAmp, globalAmp, 0, globalWidth, globalWidth, 0, PhaseTypes.Fixed, PhaseTypes.Fixed, 0);
            else
                p1 = Phase(PhaseTypes.RectConfigurable, globalAmp, globalAmp, 0, globalWidth, globalWidth, 0, PhaseTypes.Fixed, PhaseTypes.Fixed, 0);
                p2 = Phase(PhaseTypes.RectConfigurable, 0, 0, 0, 0, 0, 0, PhaseTypes.Fixed, PhaseTypes.Fixed, 0);
            end
            obj.Phases = [p1, p2];
        end
    end
end