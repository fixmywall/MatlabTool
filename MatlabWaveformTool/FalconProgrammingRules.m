classdef FalconProgrammingRules
%units are in mA and us
properties
    MinimumCathodes;
    MinimumAnodes;
    MaximumEnergy;
    MaxAreas_Active;
    MaxAreas_Passive;
    ArbitrationEnabled_Passive;
    ArbitrationEnabled_Active;
    MinRate_Active;
    MinRate_Passive;
    MaxRate_Active;
    MaxRate_Passive;
    
    PrePulseWidth_Active;
    PrePulseWidth_Passive;
    DelayTime_Active;
    DelayTime_Passive;
    WarmUpTime_Active;
    WarmUpTime_Passive;
    ReloadTime_Active;
    ReloadTime_Passive;
    ArbitrationTime_Active;
    ArbitrationTime_Passive;
    
    PhaseOneMinWidth_Active;
    PhaseOneMinWidth_Passive;
    PhaseOneMaxWidth_Active;
    PhaseOneMaxWidth_Passive;
    PhaseTwoWidth_Active;
    PhaseTwoWidthMultiplier_Passive;            %multiplier to PH1 width
    PhaseTwoAmpMultiplier_Active;
    PhaseTwoAmpMultiplier_Passive;
    PhaseThreeWidth_Active;
    PhaseThreeWidthMultiplier_Passive;          %multiplier to PH1 width
    
    HoldoffTime_Passive;
    HoldoffTimeMultiplier_Passive;              % multiplier * PH1 + IP
    
    MaxAverageCurrent_Active;
    MaxAverageCurrent_Passive;
    
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

