classdef Program < handle
%class that interfaces directly with the GUI figure
%wrapper for Channels objects
    
properties
    Channels = cell(1,Constants.DEFAULT_CHANNEL_NUM);
    SelectedChannelIndex = 1;
    Mode = [];
end

methods
    function obj = Program(handles, mode)
        obj.Mode = handles.mode;
        obj.NewChannels(handles);
    end

    function NewChannels(obj, handles)
        C = cell(1, Constants.DEFAULT_CHANNEL_NUM);
        switch obj.Mode
            case Constants.MODE_FALCON
                for i=1:length(C)
                    C{i} = FalconChannel.DefaultChannel(handles);
                end
            case Constants.MODE_SANDBOX
                for i=1:length(C)
                    C{i} = Waveform(handles, obj.Mode);
                end
        end
        obj.Channels = C;
    end

    function c = SelectedChannel(obj)
        c = obj.Channels{obj.SelectedChannelIndex};
    end
    
    function c = NumChannels(obj)
        c = length(obj.Channels);
    end
    
    %takes in array of handles to edit boxes
    function UpdateElectrodes(obj, hEdits)
        for i=1:obj.SelectedChannel().MaxElectrodes()
            obj.SelectedChannel().Electrodes(i) = str2double(hEdits(i).String);
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
    
    function PlotElectrodeOutput(obj)
        figure;
        n = 4;   %number of columns
        m = ceil(obj.SelectedChannel().NumActiveElectrodes / n);
        
        Y = obj.SelectedChannel().GetAxesData(0);
        pos = 1;
        for i=1:obj.SelectedChannel().MaxElectrodes()
            if obj.SelectedChannel().Electrodes(i) ~= 0
                
                scale = obj.SelectedChannel().Electrodes(i) / 100;

                subplot(m,n,pos);
                plot(Y{1}, scale * Y{2});
                title(strcat('Electrode ', num2str(i)));        
                pos=pos+1;
            end
        end
    end
end
end