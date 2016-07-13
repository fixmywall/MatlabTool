classdef Pulse < handle
    %PULSE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Phases = Phase.empty;  
        Period=0;                %The total time spanned by the phases
        Constraints = [];
    end
    
    methods
        function p=Pulse(mode)
            p.Constraints=Constraints(mode);
        end
        
        
end

