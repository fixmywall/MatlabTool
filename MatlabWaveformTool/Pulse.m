classdef Pulse < handle
    %PULSE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Phases = Phase.empty;
        NumPhases = 0;         
        Period=0;                %The total time spanned by the phases
        
        Constraints = [];
    end
    
    methods
        function p=Pulse(constraints)
            p.Constraints=constraints;
        end
        
        function AddPhase(obj, p)
            obj.NumPhases = obj.NumPhases+1;
            obj.Phases(obj.NumPhases)=p;
            %add to the Period the width of the phase
            obj.Period=obj.Period+p.Width.value;
        end     
        
        function AddPhases(obj, phases)
            obj.NumPhases = obj.NumPhases+length(phases);
            obj.Phases = [obj.Phases, phases];
            %add to the Period the width of the phases
            for i=1:length(phases)
                obj.Period=obj.Period+ phases(i).Width.value;
            end
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
        
        %returns array of ALL phases, including the static ones
        function P = GetAllPhases(obj)
            prePhases = [];
            if obj.Constraints.DelayEnabled
                prePhases = [prePhases, Phase.StaticPhase(0, obj.Constraints.TimeDelay)];
            end
            if obj.Constraints.WarmupEnabled
                prePhases = [prePhases, Phase.StaticPhase(0, obj.Constraints.TimeWarmup)];
            end
            if obj.Constraints.PrePulseEnabled
                prePhases = [prePhases, Phase.StaticPhase(obj.Constraints.AmplitudePrePulse, obj.Constraints.TimePrePulse)];
            end
            
            %add the interphase delay between each user-set phase
            if obj.NumPhases == 0
                userPhases = [];
            else
                if obj.Constraints.InterPhaseEnabled
                    userPhases = repmat(Phase([],[],[],[],[],[],[],PhaseTypes.Fixed, PhaseTypes.Fixed), 1,obj.NumPhases*2-1);
                    for i = 1:obj.NumPhases
                        if i == obj.NumPhases
                            userPhases(end) = obj.Phases(obj.NumPhases);
                        else
                            userPhases(2*i - 1) = obj.Phases(i);
                            userPhases(2*i) = Phase.StaticPhase(0,obj.Constraints.TimeInterPhase);
                        end
                    end
                else
                    userPhases = obj.Phases;
                end
            end
            
            postPhases = [];
            
            %compute total area to calculate the passiverecovery starting value
            if obj.Constraints.PassiveRecoveryEnabled
                area=0;
                for i=1:length(prePhases)
                    area = area + prePhases(i).Area();
                end
                for i=1:length(userPhases)
                    area = area + userPhases(i).Area();
                end
                %from the area and width of PR, calculate its starting
                %point
                startPoint = Pulse.ComputePassiveRecoveryHeight(area, obj.Constraints.TimePassiveRecovery);
                postPhases = [postPhases, Phase.PassiveRecovery(startPoint, obj.Constraints.TimePassiveRecovery)];
            end
            
            if obj.Constraints.InterPulseEnabled
                postPhases = [postPhases, Phase.StaticPhase(0, obj.GetInterPulseWidth())];
            end
            
            P = [prePhases, userPhases, postPhases];
        end  
        
        
        
        function t = GetInterPulseWidth(obj)
            t = 2000;
        end
        
        function Y = GetAxesData(obj, startTime)
            allPhases = obj.GetAllPhases();
            t=cell(1,length(allPhases));   
            y=cell(1,length(allPhases));
            start = startTime;
            for i=1:length(allPhases)
                t{i} = allPhases(i).GenerateDomain(start);
                y{i} = allPhases(i).GenerateArrays();
                start = start+allPhases(i).Width.value;
            end
            Y{1}=cell2mat(t);
            Y{2}=cell2mat(y);
        end
        
        function PlotPulse(obj, axesHandle, startTime, yScale)
            %T is a cell that holds the time domain vector for each phase
            Y = obj.GetAxesData(startTime);
            
            %scale the range by yScale
            Y{2}= yScale/100 *Y{2};
            %plot the pulse
            axes(axesHandle);    
            plot(Y{1},Y{2});
        end
        
        %refresh num is the pulse after it is refreshed num times
        function p = refreshPulse(obj, refreshNum)
            p = Pulse(obj.Constraints);
            refreshedPhases = repmat(Phase([],[],[],[],[],[],[],PhaseTypes.Fixed, PhaseTypes.Fixed, []), 1,obj.NumPhases);
            for i=1:obj.NumPhases
                refreshedPhases(i)= obj.Phases(i).RefreshPhase(refreshNum);
            end
            p.AddPhases(refreshedPhases);
        end
        
        function SetPhaseAmplitude(obj, i, newAmp)       %changes the amplitude of the phase indexed by i
            if (i<1) || (i>obj.NumPhases)
                return;
            end
            obj.Phases(i).Amplitude.value = newAmp;
        end
        
        function SetPhaseWidth(obj, i, newWidth)         %changes the width of the phase indexed by i
            if (i<1) || (i>obj.NumPhases)
                return;
            end
            diff = newWidth - obj.Phases(i).Width.value;
            obj.Period = obj.Period + diff;                 %change the pulse period based on the difference
            obj.Phases(i).Width.value = newWidth;
        end
        
        function Tabulate(obj, hTable)              %tabulates the attributes of each phase carried by the pulse
            for i=1:obj.NumPhases
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
    end
    methods(Static)
        %in future: account for exponential passive recovery
        function h = ComputePassiveRecoveryHeight(area, width)
            h = -2*area / width;
        end
    end
end

