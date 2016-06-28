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
        
        function Y = GetAxesData(obj, startTime)
            t=cell(1,obj.NumPhases);   
            y=cell(1,obj.NumPhases);
            start = startTime;
            for i=1:obj.NumPhases
                t{i} = obj.Phases(i).GenerateDomain(start);
                y{i} = obj.Phases(i).GenerateArrays();
                start = start+obj.Phases(i).Width.value;
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
        
        function ChangePhaseAmplitude(obj, i, newAmp)       %changes the amplitude of the phase indexed by i
            if (i<1) || (i>obj.NumPhases)
                return;
            end
            obj.Phases(i).Amplitude.value = newAmp;
        end
        
        function ChangePhaseWidth(obj, i, newWidth)         %changes the width of the phase indexed by i
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
        
        %mode: string that describes mode (located in Constants obj)
        function UpdateConstraints(obj, constraints)   
            obj.MaxPhases = constraints.MaxUserPhasesPerPulse;
        end
    end
end

