classdef HardwareConstraints < handle
%all units are by default in uA and mA
properties
    TimeResolution = 0.1;     %minimum time step
    CurrentResolution = 0.1;
    MaxCurrent = 200;
end

methods
    function obj = HardwareConstraints(mode)
        switch mode
            case Constants.MODE_FALCON
                obj.TimeResolution = 10;
                obj.CurrentResolution = 0.5;
                obj.MaxCurrent = 25.5;
        end
    end
end

end