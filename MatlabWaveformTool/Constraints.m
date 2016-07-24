classdef Constraints < handle
    %CONSTRAINTS List of constraints determined by the current mode
    %all units are in us and mA unless otherwise noted
    properties
        Mode = [];
        MaxChannels = 4;
        MaxUserPhasesPerPulse = [];
        MaxElectrodes = [];
        MaxAmplitude = [];
        TimeHoldOff = [];
        
        MaxRate = [];       %Hz
        MinRate = [];       %Hz

        TimeDelay = [];
        TimeWarmup = [];
        TimePrePulse = [];
        AmplitudePrePulse = [];        
        TimeInterPhase = [];
        TimePassiveRecovery = [];
       
        ChannelEnabled = [true false false false];
    end
    
    methods
        function c = Constraints(mode)
            Update(c, mode);
        end
        
        function Update(obj, mode)      %update programming rules for mode
            obj.Mode = mode;
            switch mode
                %need to know all of the programming rules before adding to
                %this section
                case Constants.MODE_SANDBOX
                    obj.MaxUserPhasesPerPulse = 10000;
                    obj.MaxElectrodes = 32;
                    obj.MaxAmplitude = 500;
                    obj.MaxChannels = 4;
                    obj.TimeDelay = 0;
                    obj.TimeWarmup = 0;
                    obj.TimePrePulse = 0;
                    obj.AmplitudePrePulse = 0;
                    obj.TimeInterPhase = 0;       
                    obj.TimePassiveRecovery = 0;
                    obj.TimeHoldOff = 0;
                case Constants.MODE_FALCON
                    obj.MaxUserPhasesPerPulse = 2;
                    obj.MaxElectrodes = 32;
                    obj.MaxAmplitude = 25.5;
                    obj.MaxChannels = 4;
                    obj.TimeDelay = 0;
                    obj.TimeWarmup = 550;
                    obj.TimePrePulse = 0;
                    obj.AmplitudePrePulse = 0;
                    obj.TimeInterPhase = 100;       
                    obj.TimePassiveRecovery = 6000;
                    obj.TimeHoldOff = 2450;
            end
        end
    end
end

