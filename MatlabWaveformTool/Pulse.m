classdef Pulse < handle
    %PULSE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Phases = Phase.empty;
        NumPhases = 0;         
        Period=0;                %The total time spanned by the phases
    end
    
    methods 
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
        
        function PlotPulse(obj, axesHandle, startTime, yScale)
            %T is a cell that holds the time domain vector for each phase
            T=cell(1,obj.NumPhases);   
            Y=cell(1,obj.NumPhases);
            start = startTime;
            for i=1:obj.NumPhases
                T{i} = obj.Phases(i).GenerateDomain(start);
                Y{i} = obj.Phases(i).GenerateArrays();
                start = start+obj.Phases(i).Width.value;
            end
            T = cell2mat(T);
            Y = yScale/100 * cell2mat(Y);
            %plot the pulse
            axes(axesHandle);    
            plot(T,Y);
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
    end
end

