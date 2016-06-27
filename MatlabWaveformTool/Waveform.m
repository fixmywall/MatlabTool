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
        
    end
    
    methods  
        function w = Waveform(pulse_axes, waveform_axes)
            w.PulseAxes = pulse_axes;
            w.WaveformAxes = waveform_axes;
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
        
        function AddPhases(obj, phases)           %adds phase to SelectedPulse
            obj.SelectedPulse.AddPhases(phases);
        end
        
        function SelectPulse(obj,i)             %select the pulse indexed in Pulses by i
            if (i>obj.NumPulses || i<1)
                return;
            end
            obj.SelectedPulse=obj.Pulses(i);
            obj.PlotSelectedPulse();
        end
        
        function RefreshPulse(obj, num)       %refreshes the pulse, generating n pulses with stochastic/ramping features
            currentPulse=obj.SelectedPulse;
            for i = 1:num
                newPulse=Pulse();       %new pulse that represents refreshed state
                for j=1:currentPulse.NumPhases
                    refPhase=currentPulse.Phases(j);        %represents the prev phase
                    newPulse.AddPhase(refPhase.RefreshPhase());     %create a REFRESH of the prev phase 
                end
                currentPulse = newPulse;
                obj.AddPulse(newPulse);
            end
        end

        function PlotSelectedPulse(obj)
            cla(obj.PulseAxes, 'reset');
            obj.SelectedPulse.PlotPulse(obj.PulseAxes, 0, 100);
        end
        
        function PlotWaveform(obj, yScale)              %plots overall waveform and selected pulse
            cla(obj.WaveformAxes, 'reset');
            time = 0;
            for i=1:obj.NumPulses
                hold on;
                obj.Pulses(i).PlotPulse(obj.WaveformAxes,time, yScale);
                time = time + obj.Pulses(i).Period;
            end
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
    end
end