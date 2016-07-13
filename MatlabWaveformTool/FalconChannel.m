%represents a timing channel that is operating in the Falcon mode

classdef FalconChannel < Waveform

properties
    GlobalAmp = [];
    GlobalWidth = [];
end

methods
    function obj = FalconChannel(handles, globalAmp, globalWidth)
        obj = obj@Waveform(handles, Constants.MODE_FALCON);
        obj.GlobalAmp = globalAmp;
        obj.GlobalWidth = globalWidth;
        obj.GeneratePhases();
    end
    
    function GeneratePhases(obj)
        p1 = Phase(PhaseTypes.RectConfigurable, -obj.GlobalAmp, -obj.GlobalAmp, 0, obj.GlobalWidth, obj.GlobalWidth, 0, PhaseTypes.Fixed, PhaseTypes.Fixed, 0);
        
        if obj.Active
            p2 = Phase(PhaseTypes.RectConfigurable, obj.GlobalAmp, obj.GlobalAmp, 0, obj.GlobalWidth, obj.GlobalWidth, 0, PhaseTypes.Fixed, PhaseTypes.Fixed, 0);
        else
            p2 = Phase(PhaseTypes.RectConfigurable, 0, 0, 0, 0, 0, 0, PhaseTypes.Fixed, PhaseTypes.Fixed, 0);
        end
        obj.Phases = [p1, p2];
        obj.PlotWaveform();
    end
end

end