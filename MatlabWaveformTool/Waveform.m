classdef Waveform < handle
    %WAVEFORM represents a single timing channel
    %   
    
    properties
        Pulse = Pulse.empty;
        
        %each channel has its own min/max amplitude
        Enabled = true;
        MaxAmp = [];
        Electrodes = [];    %stores the percentage of current from each electrode
    end
    
    methods  
        function obj = Waveform(mode)
            switch mode
                case Constants.MODE_FALCON
                    obj.Pulse = FalconPulse();
                otherwise
                    obj.Pulse = Pulse(Constraints(Constants.MODE_SANDBOX));
            end
            
            obj.Electrodes = zeros(1,obj.Pulse.Constraints.MaxElectrodes);
            obj.MaxAmp = obj.Pulse.Constraints.MaxAmplitude;
        end    
        
        function pulses = RefreshPulse(obj, num)       %refreshes the pulse, generating n pulses with stochastic/ramping features
            pulses = repmat(Pulse(obj.Constraints),1,num);
            for i = 1:num
                pulses(i) = obj.Pulse.refreshPulse(i);
            end
        end
        
        
        function Reset(obj)
            obj.Pulse = Phase.empty;
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
        
        function Y = GetAxesData(obj, startTime)
            Y = obj.Pulse.GetAxesData();
            Y.time = startTime + Y.time;
        end
        
        function SetPhaseAmplitude(obj, i, newAmp)       %changes the amplitude of the phase indexed by i
            obj.Pulse.SetPhaseAmplitude(i, newAmp);
        end
        
        function SetPhaseWidth(obj, i, newWidth)         %changes the width of the phase indexed by i
            obj.Pulse.SetPhaseWidth(i, newWidth);
        end
        
        function n = MaxElectrodes(obj)
            n = obj.Pulse.Constraints.MaxElectrodes;
        end
        
        function n = NumCathodes(obj)
            n = sum(obj.Electrodes < 0);
        end
        
        function n = NumAnodes(obj)
            n = sum(obj.Electrodes > 0);
        end
        
    end    
end