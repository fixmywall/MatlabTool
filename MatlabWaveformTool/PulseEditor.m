function varargout = PulseEditor(varargin)
% PulseEditor MATLAB code for PulseEditor.fig
%      PulseEditor, by itself, creates a new PulseEditor or raises the existing
%      singleton*.
%
%      H = PulseEditor returns the handle to a new PulseEditor or the handle to
%      the existing singleton*.
%
%      PulseEditor('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PulseEditor.M with the given input arguments.
%
%      PulseEditor('Property','Value',...) creates a new PulseEditor or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PulseEditor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PulseEditor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PulseEditor

% Last Modified by GUIDE v2.5 20-Jun-2016 15:40:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PulseEditor_OpeningFcn, ...
                   'gui_OutputFcn',  @PulseEditor_OutputFcn, ...
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


% --- Executes just before PulseEditor is made visible.
function PulseEditor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PulseEditor (see VARARGIN)

% Choose default command line output for PulseEditor
handles.phaseTable.Data = {};       %clear data in table
handles.output = hObject;
handles.waveform = varargin{1};
handles.selectedRow = 1;                  %array that holds all selected rows on the table
handles.waveform.TabulatePulses(handles.phaseTable);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PulseEditor wait for user response (see UIRESUME)
% uiwait(handles.FIG_PulseEditor);


% --- Outputs from this function are returned to the command line.
function varargout = PulseEditor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when selected cell(s) is changed in phaseTable.
function phaseTable_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to phaseTable (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)

if isempty(eventdata.Indices)
    handles.selectedRow=1;
else
    handles.selectedRow=eventdata.Indices(1,1);            %store selected rows as a column vector
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function phaseTable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to phaseTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in PB_selectPulse.
function PB_selectPulse_Callback(hObject, eventdata, handles)
% hObject    handle to PB_selectPulse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.waveform.SelectPulse(handles.selectedRow);


% --- Executes on button press in PB_inspectPulse.
function PB_inspectPulse_Callback(hObject, eventdata, handles)
% hObject    handle to PB_inspectPulse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%opens a new MATLAB figure, PhaseEditor.fig and inspects the selected pulse
%passes the selected pulse and the waveform handle as args to PhaseEditor
PhaseEditor(handles.waveform.Pulses(handles.selectedRow), handles.waveform);    
