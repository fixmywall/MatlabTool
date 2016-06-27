function varargout = PhaseEditor(varargin)
% PHASEEDITOR MATLAB code for PhaseEditor.fig
%      PHASEEDITOR, by itself, creates a new PHASEEDITOR or raises the existing
%      singleton*.
%
%      H = PHASEEDITOR returns the handle to a new PHASEEDITOR or the handle to
%      the existing singleton*.
%
%      PHASEEDITOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PHASEEDITOR.M with the given input arguments.
%
%      PHASEEDITOR('Property','Value',...) creates a new PHASEEDITOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PhaseEditor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PhaseEditor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PhaseEditor

% Last Modified by GUIDE v2.5 20-Jun-2016 17:02:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PhaseEditor_OpeningFcn, ...
                   'gui_OutputFcn',  @PhaseEditor_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before PhaseEditor is made visible.
function PhaseEditor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PhaseEditor (see VARARGIN)

% Choose default command line output for PhaseEditor
handles.phaseTable.Data = {};      %clear the data in table
handles.output = hObject;
handles.pulse = varargin{1};
handles.waveform = varargin{2};
handles.pulse.Tabulate(handles.phaseTable);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PhaseEditor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PhaseEditor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function phaseTable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to phaseTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%column names stored in struct called cNames
handles.cNames = struct('ampValue', 'Amplitude (mA)', 'widthValue', 'Width', 'ampType', 'Amplitude Type', 'widthType', 'Width Type');
hObject.ColumnName = {handles.cNames.ampValue, handles.cNames.widthValue, handles.cNames.ampType, handles.cNames.widthType};
guidata(hObject, handles);


% --- Executes when entered data in editable cell(s) in phaseTable.
function phaseTable_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to phaseTable (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)

%return if user doesnt enter a number
if isnan(eventdata.EditData)
    warningPopUpMenu(Constants.INT_REQUIRED_ERROR);
    return;
end

column = hObject.ColumnName{eventdata.Indices(1,2)};
rowNum = eventdata.Indices(1,1);

switch column          
    case handles.cNames.ampValue                    %if user edits the amplitude value
        if isnan(eventdata.NewData)
            warningPopUpMenu(Constants.INT_REQUIRED_ERROR);
            return;
        end
        newAmp = round(eventdata.NewData,-1);          %round to the nearest tens
        
        handles.pulse.ChangePhaseAmplitude(rowNum, newAmp);
        handles.waveform.PlotWaveform(100);                %re-draw waveform

    case handles.cNames.widthValue
        if isnan(eventdata.NewData) || eventdata.NewData < 1
            warningPopUpMenu(Constants.INVALID_NUMBER_ERROR);
            return;
        end
        newWidth = round(eventdata.NewData);
        handles.pulse.ChangePhaseWidth(rowNum, newWidth);
        handles.waveform.PlotWaveform(100);
end
