classdef Waveform < handle
    %WAVEFORM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Pulses = Pulse.empty;
        NumPulses = 0;
        NumPhases = 0;
        SelectedPulse = [];
        PulseAxes = [];
        WaveformAxes = [];
        Scale = 100;        %represents percent from -100 to 100
        
        Constraints = [];
    end
    
    methods  
        function w = Waveform(handles)
            w.PulseAxes = handles.axes_Pulse;
            w.WaveformAxes = handles.axes_Waveform;
            w.Constraints = handles.constraints;
        end    
        
        %creates a new empty pulse, adds to Pulses and sets selectedpulse
        %to it
        function NewPulse(obj)
            newPulse = Pulse(obj.Constraints);
            obj.AddPulse(newPulse);
            obj.SelectedPulse = newPulse;
        end
        
        function GeneratePhases(obj, ampType, widthType, minAmp, maxAmp, ampStep, minWidth, maxWidth, widthStep, num)
            %if waveform is empty, add a new pulse
            if (obj.NumPulses == 0)
                obj.NewPulse();
            end
            
            %if number of phases in the selected pulse exceeds limit,
            %display error and return
            if num + obj.SelectedPulse.NumPhases > obj.Constraints.MaxUserPhasesPerPulse
                warningPopUpMenu(Constants.ERROR_TOO_MANY_PHASES);
                return;
            end
            obj.NumPhases = obj.NumPhases + num;
            obj.SelectedPulse.GeneratePhases(ampType, widthType, minAmp, maxAmp, ampStep, minWidth, maxWidth, widthStep, num); 
            
            %plot the resulting waveform
            obj.PlotWaveform();
        end
        
        function AddPulse(obj, pulse)
            obj.NumPhases=obj.NumPhases+pulse.NumPhases;
            obj.NumPulses=obj.NumPulses+1;
            obj.Pulses(obj.NumPulses)=pulse;
        end
        
        function AddPulses(obj, pulses)         %pulses is an array of pulse handles
            for i=1:length(pulses)
                obj.NumPhases=obj.NumPhases+pulses(i).NumPhases;
            end
            obj.NumPulses=obj.NumPulses+length(pulses);
            obj.Pulses= [obj.Pulses,pulses];
        end       
        
        function SelectPulse(obj,i)             %select the pulse indexed in Pulses by i
            if (i>obj.NumPulses || i<1)
                return;
            end
            obj.SelectedPulse=obj.Pulses(i);
            obj.PlotSelectedPulse();
        end
        
        function RefreshPulse(obj, num)       %refreshes the pulse, generating n pulses with stochastic/ramping features
            refreshedPulses = repmat(Pulse(obj.Constraints),1,num);
            for i = 1:num
                refreshedPulses(i) = obj.SelectedPulse.refreshPulse(i);
            end
            obj.AddPulses(refreshedPulses);
        end

        function PlotSelectedPulse(obj)
            cla(obj.PulseAxes, 'reset');
            obj.SelectedPulse.PlotPulse(obj.PulseAxes, 0, 100);
        end
        
        function Y = GetAxesData(obj)
            y = cell(1,obj.NumPulses);
            t = cell(1,obj.NumPulses);
            startTime = 0;
            for i = 1:obj.NumPulses
                Y_pulse = obj.Pulses(i).GetAxesData(startTime);
                y{i} = Y_pulse{1};
                t{i} = Y_pulse{2};
                startTime = startTime + obj.Pulses(i).Period;
            end
            
            Y{1,:} = cell2mat(y);
            Y{2,:} = cell2mat(t);
        end
        
        function PlotWaveform(obj)              %plots overall waveform and selected pulse
            cla(obj.WaveformAxes, 'reset');
            
            %get the axes data, and then plot the data onto waveformAxes
            Y = obj.GetAxesData();
            axes(obj.WaveformAxes);
            plot(Y{1}, Y{2});
            obj.PlotSelectedPulse();
        end
        
        function TabulatePulses(obj, hTable)                %tabulates each pulse onto table pointed to be hTable
            hTable.Data = {};
            for i=1:obj.NumPulses                           %for each pulse
                currentPulse = obj.Pulses(i);
                row{1}=currentPulse.NumPhases;
                row{2}='NA';
                row{3}='NA';
                hTable.Data = [hTable.Data;row];
            end
        end
        
        %wrapper for Pulse.SetPhaseWidth
        function SetPhaseWidth(obj, i, width)
            obj.SelectedPulse.SetPhaseWidth(i, width);
        end
        
        %wrapper for Pulse.SetPhaseAmplitude
        function SetPhaseAmplitude(obj, i, amp)
            obj.SelectedPulse.SetPhaseAmplitude(i, amp);
        end
    end
end