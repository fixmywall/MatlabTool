classdef Phase  
    properties
        %amplitude units are mA
        Amplitude = struct( 'min', [], ... 
                            'max', [], ...
                            'value', [], ...
                            'stepSize', []);
                        
        %width units are us (microseconds)
        Width = struct('min', [], ...
                        'max', [], ...
                        'value', [], ...
                        'stepSize', []);
        AmpType = [];
        WidthType = [];
        Type = [];             %can be configurable, static, or passive recovery
    end
    methods
        
        function p = Phase(type, ampVal, minAmp, maxAmp, ampStep, wVal, minW, maxW, wStep, aType, wType)
            p.Type = type;  
            p.Amplitude.min = minAmp;
            p.Amplitude.max = maxAmp;
            p.Amplitude.value = ampVal;                
            p.Amplitude.stepSize = ampStep;
            p.Width.min = minW;
            p.Width.max = maxW;
            p.Width.value = wVal;
            p.Width.stepSize = wStep;           
            p.AmpType = aType;
            p.WidthType = wType;
        end
       
        
        function r = GenerateStochasticAmp(obj)         %generate random integer amplitude using min and max
             r = randi([obj.Amplitude.min,obj.Amplitude.max],1,1);
        end
        
        function r = GenerateStochasticWidth(obj)       %generate random integer width using min and max
            r = randi([obj.Width.min,obj.Width.max],1,1);
        end
        
        %generates a 'refreshed' phase array for the next pulse, takes into
        %account stochastic/ramping properties. 
        function y = GenerateArrays(obj)
            if obj.Type == PhaseTypes.PassiveRecovery
                y = [obj.Amplitude.value, 0];   %placeholder, eventually we need exp function
            else
                y = [obj.Amplitude.value, obj.Amplitude.value];
            end
        end
        
        function t = GenerateDomain(obj, start)
            t = [start, start+obj.Width.value];
        end
        
        function p = RefreshPhase(obj)
            switch obj.Type
                case PhaseTypes.RectConfigurable
                    switch obj.AmpType
                        case PhaseTypes.Fixed
                            newAmp=obj.Amplitude.value;
                        case PhaseTypes.Stochastic
                            newAmp=obj.GenerateStochasticAmp();
                        case PhaseTypes.Ramped
                            %get the slope-adjusted step size
                            if obj.Amplitude.max >= obj.Amplitude.min
                                effStepSize = obj.Amplitude.stepSize;
                            else
                                effStepSize = -obj.Amplitude.stepSize;
                            end

                            newAmp=obj.Amplitude.value + effStepSize;
                            if effStepSize > 0
                                if newAmp>obj.Amplitude.max
                                    %TODO: account for all three types of
                                    %ramping. Currently the default behavior is
                                    %looping
                                    newAmp=obj.Amplitude.min;   %loops back
                                end
                            elseif effStepSize < 0
                                if newAmp<obj.Amplitude.max
                                    %TODO: account for all three types of
                                    %ramping. Currently the default behavior is
                                    %looping
                                    newAmp=obj.Amplitude.max;
                                end
                            end  
                    end
                                                  
                    switch obj.WidthType
                        case PhaseTypes.Fixed
                            newWidth=obj.Width.value;
                        case PhaseTypes.Stochastic
                            newWidth=obj.GenerateStochasticWidth();
                        case PhaseTypes.Ramped
                            newWidth=obj.Width.value + obj.Width.stepSize;
                            if newWidth>obj.Width.max
                                %TODO: account for all three types of
                                %ramping. Currently the default behavior is
                                %looping
                                newWidth=obj.Width.min;
                            end
                    end 
                    
                    %create new configurable phase
                    p=Phase(PhaseTypes.RectConfigurable, newAmp,obj.Amplitude.min,obj.Amplitude.max,obj.Amplitude.stepSize,...
                    newWidth,obj.Width.min,obj.Width.max,obj.Width.stepSize,obj.AmpType,obj.WidthType);
                    
                %otherwise, p is a handle to whatever obj points to (identical)
                case PhaseTypes.RectStatic
                case PhaseTypes.PassiveRecovery
                    p = obj;
            end
        end

    end
end

