classdef Waveform < handle
    %WAVEFORM represents a single timing channel
    %   
    
    properties
        Phases = Phase.empty;
        PulseAxes = [];
        WaveformAxes = [];
        Scale = 100;        %represents percent from -100 to 100   
        Period=0;                %The total time spanned by the phases
        
        Constraints = [];
        
        %each channel has its own min/max amplitude
        Active = false;          %channel can be active or passive
        Enabled = true;
        MaxAmp = [];
    end
    
    methods  
        function w = Waveform(handles, mode)
            w.Constraints = Constraints(mode);
            w.PulseAxes = handles.axes_Pulse;
            w.WaveformAxes = handles.axes_Waveform;
            w.MaxAmp = w.Constraints.MaxAmplitude;
        end    
        
        function GeneratePhases(obj, ampType, widthType, minAmp, maxAmp, ampStep, minWidth, maxWidth, widthStep, num)          
            %if number of phases in the selected pulse exceeds limit,
            %display error and return
            if num + obj.NumUserPhases() > obj.Constraints.MaxUserPhasesPerPulse
                warningPopUpMenu(Constants.ERROR_TOO_MANY_PHASES);
                return;
            end
            
            newPhases = repmat(Phase([],[],[],[],[],[],[],PhaseTypes.Fixed, PhaseTypes.Fixed), 1,num);
                        
            for i=1:num       
                newPhases(i) = Phase(  PhaseTypes.RectConfigurable, minAmp, maxAmp, ampStep, ...
                                       minWidth, maxWidth, widthStep, ampType, widthType, 0);
            end
            
            obj.AddPhases(newPhases); 
            obj.PlotWaveform();
        end
        
        function pulses = RefreshPulse(obj, num)       %refreshes the pulse, generating n pulses with stochastic/ramping features
            pulses = repmat(Pulse(obj.Constraints),1,num);
            for i = 1:num
                pulses(i) = obj.Pulse.refreshPulse(i);
            end
        end
        
        function PlotWaveform(obj)              %plots overall waveform and selected pulse
            cla(obj.WaveformAxes, 'reset');
            
            %get the axes data, and then plot the data onto waveformAxes
            Y = obj.GetAxesData(0);
            axes(obj.PulseAxes);
            plot(Y{1}, obj.Scale/100* Y{2});
        end
        
        function Reset(obj)
            obj.Phases = Phase.empty;
        end
        
        function TabulatePulses(obj, hTable)                %tabulates each pulse onto table pointed to be hTable
            hTable.Data = {};
            row{1}=obj.NumUserPhases();
            row{2}='NA';
            row{3}='NA';
            hTable.Data = [hTable.Data;row];
        end
        
        function n = NumUserPhases(obj)
            n = length(obj.Phases);
        end
        
        function AddPhase(obj, p)
            obj.Phases(end+1)=p;
            %add to the Period the width of the phase
            obj.Period=obj.Period+p.Width.value;
        end     
        
        function SetPeriod(obj, rate)       %rate is in Hz
            obj.Period = round(1e6/rate);
        end
        
        function AddPhases(obj, phases)
            obj.Phases = [obj.Phases, phases];
            %add to the Period the width of the phases
            for i=1:length(phases)
                obj.Period=obj.Period+ phases(i).Width.value;
            end
        end
        
        function n = NumTotalPhases(obj)
            if obj.NumUserPhases() == 0
                numIP = 0;          %number of interphase delays
            else
                numIP = obj.NumUserPhases() - 1;
            end
            n = 5 + numIP + obj.NumUserPhases();
        end
        
        %returns array of ALL phases, including the static ones
        function P = GetAllPhases(obj)
            delayPhase = Phase.StaticPhase(0, obj.Constraints.DelayEnabled * obj.Constraints.TimeDelay);
            warmupPhase = Phase.StaticPhase(0, obj.Constraints.WarmupEnabled * obj.Constraints.TimeWarmup);
            prePulsePhase = Phase.StaticPhase(obj.Constraints.PrePulseEnabled * obj.Constraints.AmplitudePrePulse, obj.Constraints.PrePulseEnabled * obj.Constraints.TimePrePulse);
            
            %add the interphase delay between each user-set phase
            if obj.NumUserPhases() == 0
                userPhases = [];
            else
                if obj.Constraints.InterPhaseEnabled
                    userPhases = repmat(Phase([],[],[],[],[],[],[],PhaseTypes.Fixed, PhaseTypes.Fixed), 1,obj.NumUserPhases()*2-1);
                    for i = 1:obj.NumUserPhases()
                        if i == obj.NumUserPhases()
                            userPhases(end) = obj.Phases(obj.NumUserPhases());
                        else
                            userPhases(2*i - 1) = obj.Phases(i);
                            userPhases(2*i) = Phase.StaticPhase(0,obj.Constraints.TimeInterPhase);
                        end
                    end
                else
                    userPhases = obj.Phases;
                end
            end
            P = [delayPhase, warmupPhase, prePulsePhase, userPhases];
            
            %compute total area to calculate the passiverecovery starting value
            area=0;
            for i=1:length(P)
                area = area + P(i).Area();
            end
            %from the area and width of PR, calculate its starting
            %point 
            startPoint = obj.Constraints.PassiveRecoveryEnabled * obj.ComputePassiveRecoveryHeight(area);
            recoveryPhase = Phase.PassiveRecovery(startPoint, obj.Constraints.PassiveRecoveryEnabled * obj.Constraints.TimePassiveRecovery);
            P = [P, recoveryPhase];
            
            %interpulse phase width is determined by the period of the
            %pulse
            if obj.Constraints.InterPulseEnabled
                time = 0;
                for i=1:length(P)
                    time = time + P(i).Width.value;
                end
                interPulsePhase = Phase.StaticPhase(0, obj.GetInterPulseWidth(time));
            else
                interPulsePhase = Phase.StaticPhase(0, 0);
            end
            
            P = [P,interPulsePhase] ;
        end   
        
        
        function t = GetInterPulseWidth(obj, startTime)
            t = obj.Period - startTime;
            if t<0
                t = 0;
            end
        end
        
        function Y = GetAxesData(obj, startTime)
            allPhases = obj.GetAllPhases();
            t=cell(1,length(allPhases));   
            y=cell(1,length(allPhases));
            start = startTime;
            for i=1:length(allPhases)
                phaseAxes = allPhases(i).GenerateArrays(start);
                t{i} = phaseAxes{1};
                y{i} = phaseAxes{2};
                start = start+allPhases(i).Width.value;
            end
            Y{1}=cell2mat(t);
            Y{2}=cell2mat(y);
        end
        
        function PlotPulse(obj, axesHandle, startTime, yScale)
            %T is a cell that holds the time domain vector for each phase
            Y = obj.GetAxesData(startTime);
            
            %scale the range by yScale
            Y{2}= yScale/100 *Y{2};
            %plot the pulse
            axes(axesHandle);
            plot(Y{1},Y{2});
        end
        
        %refresh num is the pulse after it is refreshed num times
        function p = refreshPulse(obj, refreshNum)
            p = Pulse(obj.Constraints);
            refreshedPhases = repmat(Phase([],[],[],[],[],[],[],PhaseTypes.Fixed, PhaseTypes.Fixed, []), 1,obj.NumUserPhases());
            for i=1:obj.NumUserPhases()
                refreshedPhases(i)= obj.Phases(i).RefreshPhase(refreshNum);
            end
            p.AddPhases(refreshedPhases);
        end
        
        function SetPhaseAmplitude(obj, i, newAmp)       %changes the amplitude of the phase indexed by i
            if (i<1) || (i>obj.NumUserPhases())
                return;
            end
            obj.Phases(i).Amplitude.value = newAmp;
        end
        
        function SetPhaseWidth(obj, i, newWidth)         %changes the width of the phase indexed by i
            if (i<1) || (i>obj.NumUserPhases())
                return;
            end
            obj.Phases(i).Width.value = newWidth;
        end
        
        function Tabulate(obj, hTable)              %tabulates the attributes of each phase carried by the pulse
            for i=1:obj.NumUserPhases()
                currentPhase=obj.Phases(i);
                row{1}=currentPhase.Amplitude.value;
                row{2}=currentPhase.Width.value;
                switch currentPhase.AmpType
                    case PhaseTypes.Fixed
                        row{3}='Fixed';
                    case PhaseTypes.Stochastic
                        row{3}='Stochastic';
                    case PhaseTypes.Ramped
                        row{3}='Ramping'; 
                end
                switch currentPhase.WidthType
                    case PhaseTypes.Fixed
                        row{4}='Fixed';
                    case PhaseTypes.Stochastic
                        row{4}='Stochastic';
                    case PhaseTypes.Ramped
                        row{4}='Ramping'; 
                end
                hTable.Data = [hTable.Data;row];
            end
        end
    
   
        %in future: account for exponential passive recovery
        function h = ComputePassiveRecoveryHeight(obj, area)
            h=0;
            width = obj.Constraints.TimePassiveRecovery;
            if area ~= 0
                h = -2*area / width;
            else
                switch obj.Constraints.Mode
                    case Constants.MODE_FALCON
                        h = 0.1 * rand() * obj.Phases(1).Amplitude.value;
                end
            end

        end
    end
end