classdef Phase < handle
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
        
        %refreshNum: if the phase is a 'refresh' of another phase,
        %refreshNum represents the phase after Num refreshes
        function p = Phase(type, minAmp, maxAmp, ampStep, minW, maxW, wStep, aType, wType, refreshNum)
            p.Type = type;  
            p.Amplitude.min = minAmp;
            p.Amplitude.max = maxAmp;           
            p.Amplitude.stepSize = ampStep;
            p.Width.min = minW;
            p.Width.max = maxW;
            p.Width.stepSize = wStep;           
            p.AmpType = aType;
            p.WidthType = wType;
            
            %calculate the values of amplitude and width based on their
            %types
            switch aType
                case PhaseTypes.Fixed
                    p.Amplitude.value = minAmp;
                case PhaseTypes.Ramped   %include ramping properties
                    p.Amplitude.value = minAmp + refreshNum*ampStep;
                    if p.Amplitude.value > maxAmp
                        p.Amplitude.value = minAmp;
                    end
                    
                case PhaseTypes.Stochastic
                    p.Amplitude.value = randi([minAmp,maxAmp],1,1);
            end
            switch wType
                case PhaseTypes.Fixed
                    p.Width.value = minW;
                case PhaseTypes.Ramped
                    p.Width.value = mod(minW + refreshNum*wStep, maxW);
                case PhaseTypes.Stochastic
                    p.Width.value = randi([minW,maxW],1,1);
            end
        end
       
        
        function r = GenerateStochasticAmp(obj)         %generate random integer amplitude using min and max
            r = randi([obj.Amplitude.min,obj.Amplitude.max],1,1);
        end
        
        function r = GenerateStochasticWidth(obj)       %generate random integer width using min and max
            r = randi([obj.Width.min,obj.Width.max],1,1);
        end
        
        %generates a 'refreshed' phase array for the next pulse, takes into
        %account stochastic/ramping properties. 
        function Y = GenerateArrays(obj, startTime)
            if obj.Type == PhaseTypes.PassiveRecovery
                Y{1} = linspace(startTime, startTime + obj.Width.value, 100);
                
                newT = Y{1}-startTime;
                Y{2} = obj.Amplitude.value * exp(-(Y{1}-startTime)* 7 / obj.Width.value);
                
            else
                Y{1} = [startTime, startTime+obj.Width.value];
                Y{2} = [obj.Amplitude.value, obj.Amplitude.value];
            end
        end
        
        function t = GenerateDomain(obj, start)
            t = [start, start+obj.Width.value];
        end
        
        function p = RefreshPhase(obj, refreshNum)
            p = Phase(  obj.Type, obj.Amplitude.min, obj.Amplitude.max, obj.Amplitude.stepSize, obj.Width.min, obj.Width.max,...
                        obj.Width.stepSize, obj.AmpType, obj.WidthType, refreshNum);
        end
        
        function a = Area(obj)   %returns area in [us * mA]
            if obj.Type == PhaseTypes.PassiveRecovery
                a = 0.5 * obj.Amplitude.value * obj.Width.value;
            else
                a = obj.Amplitude.value * obj.Width.value;
            end
        end

    end
    methods(Static)
        %create a static phase with given amplitude and width
        function p = StaticPhase(amp, width)
            p = Phase(PhaseTypes.RectStatic, amp, amp, 0, width, width, 0, PhaseTypes.Fixed, PhaseTypes.Fixed, 0);
        end
        
        function p = PassiveRecovery(start, width)
            p = Phase(PhaseTypes.PassiveRecovery, start, start, 0, width, width, 0, PhaseTypes.Fixed, PhaseTypes.Fixed, 0);
        end
    end
end

