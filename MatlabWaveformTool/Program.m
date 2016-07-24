classdef Program < handle
%class that interfaces directly with the GUI figure
%wrapper for Channels objects
    
properties
    Channels;
    SelectedChannelIndex = 1;
    Mode = [];
    
    PulseAxes = [];
    WaveformAxes = [];
    
    %each element in this cell contains an array of each channel occupying
    %the electrode
    ElectrodeOccupation = [];
    HWConstraints = [];
end

methods
    function obj = Program(handles, mode)
        rules = Constraints(mode);
        obj.HWConstraints = HardwareConstraints(mode);
        obj.Mode = mode;
        obj.DefaultChannels();
        obj.PulseAxes = handles.axes_Pulse;
        obj.WaveformAxes = handles.axes_Waveform;
        obj.ElectrodeOccupation = cell(1,rules.MaxElectrodes);
    end

    function DefaultChannels(obj)
        obj.Channels = cell(1, Constants.DEFAULT_CHANNEL_NUM);
        for i=1:length(obj.Channels)
            obj.Channels{i} = Waveform(obj.Mode);
        end
    end

    function c = SelectedChannel(obj)
        c = obj.Channels{obj.SelectedChannelIndex};
    end
    
    function C = EnabledChannels(obj)
        for i=1:obj.Channels
            if obj.Channels(i).Enabled
                C(i) = obj.Channels(i);
            end
        end
    end
    
    function c = NumChannels(obj)
        c = length(obj.Channels);
    end
    
    %takes in array of handles to edit boxes
    function UpdateElectrodes(obj, hEdits, plotEnabled)
        for i=1:obj.SelectedChannel().MaxElectrodes()
            percent = str2double(hEdits(i).String);
            if percent ~= 0
                obj.SelectedChannel().Electrodes(i) = percent;
             
                %update electrode occupation matrix
                if ~ismember(obj.SelectedChannelIndex, obj.ElectrodeOccupation{i})
                    obj.ElectrodeOccupation{i} = [obj.ElectrodeOccupation{i}, obj.SelectedChannelIndex];
                    sort(obj.ElectrodeOccupation{i});
                end
                
                plotEnabled(i).Enable = 'on';                
                plotEnabled(i).Value = 1;
                
            else   %if percent is zero
                if isempty(obj.ElectrodeOccupation{i})
                    plotEnabled(i).Value = 0;
                    plotEnabled(i).Enable = 'off';
                end
            end
            
        end
    end
    
    function UpdateChannelPopUpMenu(obj, hPop)
        hPop.String = {};
        for i=1:obj.NumChannels()
            hPop.String{i} = num2str(i);
        end
    end 
    
    %gets the axes data from the electrode indexed by elecIndex in the
    %selected channel
    function Y = ElectrodeWaveformAxes(obj, elecIndex)
        if elecIndex < 1 || elecIndex > obj.SelectedChannel().MaxElectrodes();
            return;
        end
        scale = obj.SelectedChannel().Electrodes(elecIndex) / 100;
        Y = obj.SelectedChannel().GetAxesData(0);
        Y{2} = scale * Y{2};
    end
    
   
    
    %spawns a new figure that plots the waveform from each electrode that
    %has its checkbox checked
    function PlotElectrodeOutput(obj, eb_handles)
        figure;
        activeElectrodes = Program.NumElectrodePlots(eb_handles);
        
        %divide the figure properly to accomodate the plots
        n = ceil(sqrt(activeElectrodes/2));
        m = 2*n;
        
        Y = cell(1, length(obj.Channels));
        for i=1:length(obj.Channels)
            Y{i} = obj.Channels{i}.GetAxesData(0);
        end

        pos = 1;
        for i=1:length(obj.ElectrodeOccupation)
            occupyingChannels = obj.ElectrodeOccupation{i}; 
            if ~isempty(occupyingChannels) && eb_handles(i).Value
                channelID = occupyingChannels(1);
                currentChannel = obj.Channels{channelID};
                if currentChannel.Enabled
                    scale = currentChannel.Electrodes(i) / 100;
                else
                    scale = 0;
                end
                h = subplot(m,n,pos);
                startTime = obj.GetChannelStartTime(channelID);
                currentChannel.Pulse.Plot(h, startTime, 5, scale);
                
                title(horzcat(['Electrode', ' ', num2str(i), ' (Channel ', num2str(channelID), ')']));        
                pos=pos+1;
            end
        end
    end
    
    function PlotPulseGraphics(obj, handles)
        obj.SelectedChannel().Pulse.Plot(obj.PulseAxes, 0, 1, 1);
        num = str2double(handles.EB_falconNumPulses.String);
        obj.SelectedChannel().Pulse.MovingPlot(obj.WaveformAxes, 1, 4);
    end
    
    function UpdateFalconPhase(obj, handles)
        channel = obj.SelectedChannel();
        obj.UpdateElectrodes(handles.PANEL_electrodesPolarity.UserData, handles.PANEL_electrodePlot.UserData);        
        
        channel.Pulse.GlobalAmp = str2double(handles.EB_falconPhaseOneAmp.String);
        channel.Pulse.GlobalWidth = str2double(handles.EB_falconPhaseOneWidth.String);
        channel.Pulse.Frequency = str2double(handles.EB_pulseRate.String);
        channel.Enabled = handles.CB_channelEnabled.Value;
        channel.Pulse.GeneratePhases();
    end
    
    %loads electrode percentages into the UI for current channel
    %pb_handle is handle to the 'toggle all' button
    function LoadElectrodeUI(obj, eb_handles, cb_handles)
        for i=1:obj.SelectedChannel().MaxElectrodes()
            percent = obj.SelectedChannel.Electrodes(i);
            eb_handles(i).String = num2str(percent);
            
            if ~isempty(obj.ElectrodeOccupation{i})
                cb_handles(i).Value = 1;
                cb_handles(i).Enable = 'on';
            else
                cb_handles(i).Enable = 'off';
            end
        end
    end       
    
    %get the starting time of the channel, taking into account holdoff
    function t = GetChannelStartTime(obj, ID)
        t=0;
        for i=1:length(obj.Channels)
            if i<ID
                if obj.Channels{i}.Enabled
                    t=t+obj.Channels{i}.Pulse.Constraints.TimeHoldOff;
                end
            end
        end
    end
    
    function InitializeFalconGUI(obj, handles)
        handles.PANEL_phaseSetup.Visible = 'off';
        handles.PANEL_falconPulseSetup.Visible = 'on';
        handles.EB_falconPhaseOneAmp.String = num2str(Constants.FALCON_DEFAULT_AMP);
        handles.EB_falconPhaseOneWidth.String = num2str(Constants.FALCON_DEFAULT_WIDTH);
        
        %drop-down menus
        i=1;
        for amp=0:obj.HWConstraints.CurrentResolution:obj.HWConstraints.MaxCurrent
            handles.POP_falconAmplitude.String{i} = num2str(amp);
            i=i+1;
        end
    end
    
    %returns energy sum of all channels in mJ
    function e = Energy(obj)
        e = 0;
        for channel = obj.Channels
            e = e + channel.Pulse.Energy();
        end
    end
end

methods(Static)
    function n = NumElectrodePlots(eb_handles)
        n = 0;
        for eb=eb_handles
            if eb.Value == 1
                n = n+1;
            end
        end
    end
end
end
