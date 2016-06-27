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
        
        %generates phases based on user input into the GUI
        %handles: contains all handles within the main GUI
        function GeneratePhases(obj, handles)
            iterations = str2double(handles.EB_numPhases.String);
            if isnan(iterations)
                return;
            end                 
            
            if iterations + obj.NumPhases > obj.Constraints.MaxUserPhasesPerPulse
                warningPopUpMenu(Constants.ERROR_TOO_MANY_PHASES);
                return;
            end
            
            newPhases = repmat(Phase([],[],[],[],[],[],[],[],[],[],[]), 1,iterations);
    
            for i=1:iterations
                %Set the amplitude based on which radio button is selected in the phase
                %amplitude
                switch (handles.BG_PhaseAmp.SelectedObject.Tag)
                    case 'RB_FixedAmp'
                        if isnan(str2double(handles.EB_FixedAmp.String))
                            minAmp=0; maxAmp=0;
                        else
                            minAmp=round(str2double(handles.EB_FixedAmp.String)); 
                            maxAmp=minAmp;
                        end
                        ampStep=0;
                        ampType=PhaseTypes.Fixed;
                        ampVal=minAmp;

                    case 'RB_StochasticAmp'
                        if isnan(str2double(handles.EB_MinStochAmp.String))
                            minAmp=0;
                        else
                            minAmp=round(str2double(handles.EB_MinStochAmp.String));
                        end
                        if isnan(str2double(handles.EB_MaxStochAmp.String))
                            maxAmp=0;
                        else
                            maxAmp=round(str2double(handles.EB_MaxStochAmp.String));
                        end
                        ampStep=0;
                        ampType=PhaseTypes.Stochastic;
                        %determine the current state by generating a random integer
                        ampVal=randi([minAmp,maxAmp],1,1);
                    case 'RB_RampAmp'
                        if isnan(str2double(handles.EB_StartRampAmp.String))
                            minAmp=0;
                        else
                            minAmp=round(str2double(handles.EB_StartRampAmp.String));
                        end
                        if isnan(str2double(handles.EB_RampAmpStep.String))
                            ampStep=0;
                        else
                            ampStep=str2double(handles.EB_RampAmpStep.String);
                        end
                        if isnan(str2double(handles.EB_MaxRampAmp.String))
                            maxAmp=0;
                        else
                            maxAmp=str2double(handles.EB_MaxRampAmp.String);
                        end
                        ampType=PhaseTypes.Ramped;
                        ampVal=minAmp;
                end
                switch handles.BG_PhaseWidth.SelectedObject.Tag
                    case 'RB_FixedWidth'
                        if isnan(str2double(handles.EB_FixedWidth.String))
                            minWidth=0;
                            maxWidth=0;
                        else
                            minWidth=round(str2double(handles.EB_FixedWidth.String));
                            maxWidth=minWidth;
                        end
                        widthStep=0;
                        widthType=PhaseTypes.Fixed;
                        widthVal=minWidth;
                    case 'RB_StochWidth'
                        if isnan(str2double(handles.EB_MinStochWidth.String))
                            minWidth=0;
                        else
                            minWidth=round(str2double(handles.EB_MinStochWidth.String));
                        end
                        if isnan(str2double(handles.EB_MaxStochWidth.String))
                            maxWidth=0;
                        else
                            maxWidth=round(str2double(handles.EB_MaxStochWidth.String));
                        end
                        widthStep=0;
                        widthType=PhaseTypes.Stochastic;
                        widthVal=randi([minWidth,maxWidth],1,1);
                    case 'RB_RampWidth'
                        if isnan(str2double(handles.EB_RampWidthStart.String))
                            minWidth=0;
                        else
                            minWidth=str2double(handles.EB_RampWidthStart.String);
                        end
                        if isnan(str2double(handles.EB_RampWidthMax.String))
                            maxWidth=0;
                        else
                            maxWidth=str2double(handles.EB_RampWidthMax.String);
                        end
                        if isnan(str2double(handles.EB_RampWidthStep.String))
                            widthStep=0;
                        else
                            widthStep=round(str2double(handles.EB_RampWidthStep.String));
                        end
                        widthType=PhaseTypes.Ramped;
                        widthVal=minWidth;
                end
                 %create a Phase object with the above parameters, adding it to the
                 %pulse object 

                newPhases(i) = (Phase(  PhaseTypes.RectConfigurable, ampVal, minAmp, maxAmp, ampStep, ...
                                        widthVal, minWidth, maxWidth, widthStep, ampType, widthType));
                %if ramped type amplitude, add an additional phase
                %if (ampType==PhaseTypes.Ramped)
                    %handles.waveform.AddPhase(Phase(-ampVal, minAmp, maxAmp, ampStep, widthVal, minWidth, maxWidth, widthStep, ampType, widthType));
                %end
                
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

