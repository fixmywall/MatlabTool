classdef Constraints < handle
    %CONSTRAINTS List of constraints determined by the current mode
    %all units are in us and mA unless otherwise noted
    properties    
        MaxUserPhasesPerPulse = [];
        MaxElectrodes = [];
        TimeWarmup = [];
        TimePrePulse = [];
        AmpPrePulse = [];   
        TimeInterPulse = [];
        TimePassiveRecovery = [];
        TimeInterPhase = [];                 %delay between pulses
        MaxRate = [];       %Hz
        MinRate = [];       %Hz       
    end
    
    methods
        function c = Constraints(mode)
            Update(c, mode);
        end
        
        function Update(obj, mode)
            switch mode
                %need to know all of the programming rules before updating
                case Constants.MODE_SANDBOX
                    obj.MaxUserPhasesPerPulse = 10000;
                    obj.MaxElectrodes = 32;
                case Constants.MODE_FALCON
                    obj.MaxUserPhasesPerPulse = 2;
                    obj.MaxElectrodes = 32;
            end
        end
    end
end

