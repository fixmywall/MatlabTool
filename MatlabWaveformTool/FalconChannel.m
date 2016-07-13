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
        obj.Pulse.GenerateFalconPhases(obj.GlobalAmp, obj.GlobalWidth, obj.Active);
        obj.PlotWaveform();
    end
end

methods(Static)
    function obj = DefaultChannel(handles)
        obj = FalconChannel(handles, Constants.FALCON_DEFAULT_AMP, Constants.FALCON_DEFAULT_WIDTH);
        obj.Pulse.Frequency = Constants.FALCON_DEFAULT_RATE;
    end
end

end