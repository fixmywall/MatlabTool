classdef Waveform < handle
    %WAVEFORM represents a single timing channel
    %   
    
    properties
        Pulse = Pulse.empty;
        PulseAxes = [];
        WaveformAxes = [];
        Scale = 100;        %represents percent from -100 to 100   
        
        Constraints = [];
        
        %each channel has its own min/max amplitude
        Active = false;          %channel can be active or passive
        Enabled = true;
        MaxAmp = [];
        Electrodes = [];    %stores the percentage of current from each electrode
    end
    
    methods  
        function w = Waveform(handles, mode)
            constraints = Constraints(mode);
            w.Pulse = Pulse(constraints);
            w.Constraints = constraints;
            w.Electrodes = zeros(1,constraints.MaxElectrodes);
            w.PulseAxes = handles.axes_Pulse;
            w.WaveformAxes = handles.axes_Waveform;
            w.MaxAmp = w.Constraints.MaxAmplitude;
        end    
        
        
        function GeneratePhases(obj, ampType, widthType, minAmp, maxAmp, ampStep, minWidth, maxWidth, widthStep, num)          
            %if number of phases in the selected pulse exceeds limit,
            %display error and return
            if num + obj.NumUserPhases() > obj.Constraints.MaxUserPhasesPerPulse
                warningPopUpMenu(Constants.ERROR_TOO_MANY_PHASES);
                return;
            end
            
            obj.Pulse.GeneratePhases(ampType, widthType, minAmp, maxAmp, ampStep, minWidth, maxWidth, widthStep, num);
            obj.PlotWaveform();
        end
        
        function pulses = RefreshPulse(obj, num)       %refreshes the pulse, generating n pulses with stochastic/ramping features
            pulses = repmat(Pulse(obj.Constraints),1,num);
            for i = 1:num
                pulses(i) = obj.Pulse.refreshPulse(i);
            end
        end
        
        function PlotWaveform(obj)              %plots overall waveform and selected pulse
            cla(obj.WaveformAxes, 'reset');
            
            %get the axes data, and then plot the data onto waveformAxes
            Y = obj.GetAxesData(0);
            axes(obj.PulseAxes);
            plot(Y{1}, obj.Scale/100* Y{2});
        end
        
        function Reset(obj)
            obj.Pulse = Phase.empty;
        end
        
        function n = NumActiveElectrodes(obj)
            n=0;
            for i=1:obj.MaxElectrodes()
                if obj.Electrodes(i) > 0
                    n=n+1;
                end
            end
        end
        
        function TabulatePulses(obj, hTable)                %tabulates each pulse onto table pointed to be hTable
            hTable.Data = {};
            row{1}=obj.NumUserPhases();
            row{2}='NA';
            row{3}='NA';
            hTable.Data = [hTable.Data;row];
        end
        
        function n = NumUserPhases(obj)
            n = obj.Pulse.NumUserPhases();
        end
        
        function AddPhase(obj, p)
            obj.Pulse.AddPhase(p);
        end     
        
        function AddPhases(obj, phases)
            obj.Pulse.AddPhases(phases);
        end
        
        %returns array of ALL phases, including the static ones
        function P = GetAllPhases(obj)
            P = obj.Pulse.GetAllPhases();
        end   
        
        function SetPeriod(obj, rate)
            obj.Pulse.SetPeriod(rate);
        end
        
        function Y = GetAxesData(obj, startTime)
            Y = obj.Pulse.GetAxesData(startTime);
        end
        
        function SetPhaseAmplitude(obj, i, newAmp)       %changes the amplitude of the phase indexed by i
            obj.Pulse.SetPhaseAmplitude(i, newAmp);
        end
        
        function SetPhaseWidth(obj, i, newWidth)         %changes the width of the phase indexed by i
            obj.Pulse.SetPhaseWidth(i, newWidth);
        end
        
        function n = MaxElectrodes(obj)
            n = obj.Constraints.MaxElectrodes;
        end
    end
    
    
end