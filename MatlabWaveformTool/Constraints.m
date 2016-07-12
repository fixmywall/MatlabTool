classdef Constraints < handle
    %CONSTRAINTS List of constraints determined by the current mode
    %all units are in us and mA unless otherwise noted
    properties
        Mode = [];
        MaxChannels = 4;
        MaxUserPhasesPerPulse = [];
        MaxElectrodes = [];
        MaxAmplitude = [];
        
        MaxRate = [];       %Hz
        MinRate = [];       %Hz
        
        %delay
        DelayEnabled = false;
        TimeDelay = [];
        
        %warmup
        WarmupEnabled = false;
        TimeWarmup = [];
        
        %prepulse
        PrePulseEnabled = false;
        TimePrePulse = [];
        AmplitudePrePulse = [];        
        
        %interphase
        InterPhaseEnabled = false;
        TimeInterPhase = [];
        
        %passive recovery
        PassiveRecoveryEnabled = true;
        TimePassiveRecovery = [];
              
        %timing channels
        ChannelEnabled = [true false false false];
        TimeHoldOff = [];
        
        %Interpulse
        InterPulseEnabled = false;
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
                    obj.DelayEnabled = false;
                    obj.TimeDelay = 0;
                    obj.WarmupEnabled = false;
                    obj.TimeWarmup = 0;
                    obj.PrePulseEnabled = false;
                    obj.TimePrePulse = 0;
                    obj.AmplitudePrePulse = 0;
                    obj.InterPhaseEnabled = false;
                    obj.TimeInterPhase = 0;       
                    obj.PassiveRecoveryEnabled = false;
                    obj.TimePassiveRecovery = 0;
                    obj.InterPulseEnabled = false;  
                case Constants.MODE_FALCON
                    obj.MaxUserPhasesPerPulse = 2;
                    obj.MaxElectrodes = 32;
                    obj.MaxAmplitude = 25.5;
                    obj.MaxChannels = 4;
                    obj.DelayEnabled = true;
                    obj.TimeDelay = 0;
                    obj.WarmupEnabled = true;
                    obj.TimeWarmup = 550;
                    obj.PrePulseEnabled = true;
                    obj.TimePrePulse = 0;
                    obj.AmplitudePrePulse = 0;
                    obj.InterPhaseEnabled = true;
                    obj.TimeInterPhase = 100;       
                    obj.PassiveRecoveryEnabled = true;
                    obj.TimePassiveRecovery = 6000;
                    obj.InterPulseEnabled = true;  
            end
        end
    end
end

