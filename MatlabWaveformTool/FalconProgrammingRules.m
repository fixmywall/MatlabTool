classdef FalconProgrammingRules
%units are in mA and us
properties
    MinimumCathodes = 1;
    MinimumAnodes = 1;
    MaximumEnergy                   = 2;
    MaxAreas_Active                 = 1;
    MaxAreas_Passive                = 4;
    ArbitrationEnabled_Passive = false;
    ArbitrationEnabled_Active = false;
    MinRate_Active = 150;
    MinRate_Passive = 20;
    MaxRate_Active = 1200;
    MaxRate_Passive = 130;
    
    PrePulseWidth_Active = 0;
    PrePulseWidth_Passive = 0;
    DelayWidth_Active = 0;
    DelayWidth_Passive = 0;
    WarmUpTime_Active = 100;
    WarmUpTime_Passive = 550;
    ReloadTime_Active = 20;
    ReloadTime_Passive = 20;
    ArbitrationTime_Active = 20;
    ArbitrationTime_Passive = 20;
    PhaseOneMinWidth_Active = 20;
    PhaseOneMinWidth_Passive = 20;
    PhaseOneMaxWidth_Active = 1000;
    PhaseOneMaxWidth_Passive = 1000;
    PhaseTwoWidthMultiplier_Active = 1;
    PhaseTwoWidthMultiplier_Passive = 0;            %multiplier to PH1 width
    PhaseTwoAmpMultiplier_Active = 1;
    PhaseTwoAmpMultiplier_Passive = 1;
    PhaseThreeWidthMultiplier_Active = 2;
    PhaseThreeWidth_Passive = 6000;          %multiplier * PH1 width
    
    HoldoffTime_Passive = 2450;
    HoldoffTimeMultiplier_Active = 2;              % multiplier * PH1Width + IP
    
    MaxAverageCurrent_Active = 2;
    MaxAverageCurrent_Passive = 2;
    
end


methods

function out = RateCheck(obj, program)
    out.passed = true;
    
    for i=1:length(program.Channels)
        if program.Channels(i).Enabled
            out.passed = out.passed && ((pulse.Active && pulse.Period <= obj.MaxRate_Active && pulse.Period >= obj.MinRate_Active) ...
                                        || (~pulse.Active && pulse.Period <= obj.MaxRate_Passive && pulse.Period >= obj.MinRate_Passive));
        end
    end
    out.requiredValue.MaxRate_Active = obj.MaxRate_Active;
end

function out = ElectrodeCheck(obj, program)
    out.passed = true;
    for i=1:length(program.Channel)
        passed = (program.Channel(i).NumAnodes() >= obj.MinimumAnodes) && (program.Channel(i).NumCathodes() >= obj.MinimumCathodes);
        out.passed = out.passed && passed;
    end
    out.requiredValue.MinimumAnodes = obj.MinimumAnodes;
    out.requiredValue.MinimumCathodes = obj.MinimumCathodes;
end

function out = EnergyCheck(obj, program)
    out.passed = program.Energy() <= obj.MaximumEnergy;
    out.requiredValue = obj.MaximumEnergy;
end

function out = BandWidthCheck(obj, program)
end

end
end

