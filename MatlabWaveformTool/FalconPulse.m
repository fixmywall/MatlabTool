classdef FalconPulse < Pulse
%Pulse operating in the Falcon mode
    
properties
    GlobalAmp = [];
    GlobalWidth = [];
end

methods
    function obj = FalconPulse()
        obj = obj@Pulse(Constraints(Constants.MODE_FALCON));
        obj.GlobalAmp = Constants.FALCON_DEFAULT_AMP;
        obj.GlobalWidth = Constants.FALCON_DEFAULT_WIDTH;
        obj.Frequency = Constants.FALCON_DEFAULT_RATE;
        obj.GeneratePhases();
    end

    %generates falcon-compliant phases
    function GeneratePhases(obj)
        amp = obj.GlobalAmp;
        width = obj.GlobalWidth;
        
        if obj.Active
            p1 = Phase(PhaseTypes.RectConfigurable, -amp, -amp, 0, width, width, 0, PhaseTypes.Fixed, PhaseTypes.Fixed, 0);
            p2 = Phase(PhaseTypes.RectConfigurable, amp, amp, 0, width, width, 0, PhaseTypes.Fixed, PhaseTypes.Fixed, 0);
        else
            p1 = Phase(PhaseTypes.RectConfigurable, amp, amp, 0, width, width, 0, PhaseTypes.Fixed, PhaseTypes.Fixed, 0);
            p2 = Phase(PhaseTypes.RectConfigurable, 0, 0, 0, 0, 0, 0, PhaseTypes.Fixed, PhaseTypes.Fixed, 0);
        end
        obj.Phases = [p1, p2];
    end
    
    function e = Energy(obj)
        if obj.Enabled
            k = 1+obj.Active;
            e = k*obj.GlobalAmp * obj.GlobalWidth / obj.Period();
        else
            e = 0;
        end
    end
end
end