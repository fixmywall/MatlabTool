function varargout = SandboxRuleSettings(varargin)
% SANDBOXRULESETTINGS MATLAB code for SandboxRuleSettings.fig
%      SANDBOXRULESETTINGS, by itself, creates a new SANDBOXRULESETTINGS or raises the existing
%      singleton*.
%
%      H = SANDBOXRULESETTINGS returns the handle to a new SANDBOXRULESETTINGS or the handle to
%      the existing singleton*.
%
%      SANDBOXRULESETTINGS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SANDBOXRULESETTINGS.M with the given input arguments.
%
%      SANDBOXRULESETTINGS('Property','Value',...) creates a new SANDBOXRULESETTINGS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SandboxRuleSettings_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SandboxRuleSettings_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SandboxRuleSettings

% Last Modified by GUIDE v2.5 24-Jul-2016 19:54:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SandboxRuleSettings_OpeningFcn, ...
                   'gui_OutputFcn',  @SandboxRuleSettings_OutputFcn, ...
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


%initializes the GUI objects based on the current programming rules
%(handles.rules)
%i is selected channel index
function InitializeObjects(handles)
channel = handles.program.SelectedChannel();
rules   = channel.Pulse.Constraints;

%initialize edit boxes
handles.EB_delay.String             = num2str(rules.TimeDelay);
handles.EB_warmup.String            = num2str(rules.TimeWarmup);
handles.EB_prePulse.String          = num2str(rules.TimePrePulse);
handles.EB_interPhase.String        = num2str(rules.TimeInterPhase);
handles.EB_passiveRecovery.String   = num2str(rules.TimePassiveRecovery);


% --- Executes just before SandboxRuleSettings is made visible.
function SandboxRuleSettings_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SandboxRuleSettings (see VARARGIN)

% Choose default command line output for SandboxRuleSettings
handles.output = hObject;
handles.program = varargin{1};
handles.POP_channel.Value = handles.program.SelectedChannelIndex;

%initializes UI components based on selected channel
InitializeObjects(handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SandboxRuleSettings wait for user response (see UIRESUME)
% uiwait(handles.SandboxRuleSettings);


% --- Outputs from this function are returned to the command line.
function varargout = SandboxRuleSettings_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function EB_passiveRecovery_Callback(hObject, eventdata, handles)
% hObject    handle to EB_passiveRecovery (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_passiveRecovery as text
%        str2double(get(hObject,'String')) returns contents of EB_passiveRecovery as a double


% --- Executes during object creation, after setting all properties.
function EB_passiveRecovery_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_passiveRecovery (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


%saves the state of GUI elements into the constraints (rules) object
%returns true if there is no issue, otherwise false
function SaveSettings(handles)
%update the channel rules
rules = handles.program.SelectedChannel().Pulse.Constraints;
rules.TimeDelay = str2double(handles.EB_delay.String);
rules.TimeWarmup = str2double(handles.EB_warmup.String);
rules.TimePrePulse = str2double(handles.EB_prePulse.String);
rules.TimeInterPhase = str2double(handles.EB_interPhase.String);
rules.TimePassiveRecovery = str2double(handles.EB_passiveRecovery.String);


%makes edit box editable/uneditable based on state of checkbox
function ToggleEditBox(hCheckbox, hEdits)
for hEdit = hEdits
    if hCheckbox.Value
        hEdit.Enable = 'on';
    else
        hEdit.String = '0';
        hEdit.Enable = 'off';
    end
end


% --- Executes on button press in PB_ok.
function PB_ok_Callback(hObject, eventdata, handles)
% hObject    handle to PB_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SaveSettings(handles);
close(handles.SandboxRuleSettings);


% --- Executes on button press in EB_cancel.
function EB_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to EB_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.SandboxRuleSettings);


% --- Executes on button press in CB_passiveRecovery.
function CB_passiveRecovery_Callback(hObject, eventdata, handles)
% hObject    handle to CB_passiveRecovery (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CB_passiveRecovery
ToggleEditBox(hObject, handles.EB_passiveRecovery);


% --- Executes during object creation, after setting all properties.
function CB_passiveRecovery_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CB_passiveRecovery (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


function EB_holdOffTime_Callback(hObject, eventdata, handles)
% hObject    handle to EB_holdOffTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_holdOffTime as text
%        str2double(get(hObject,'String')) returns contents of EB_holdOffTime as a double


% --- Executes during object creation, after setting all properties.
function EB_holdOffTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_holdOffTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_warmup_Callback(hObject, eventdata, handles)
% hObject    handle to EB_warmup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_warmup as text
%        str2double(get(hObject,'String')) returns contents of EB_warmup as a double


% --- Executes during object creation, after setting all properties.
function EB_warmup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_warmup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CB_warmup.
function CB_warmup_Callback(hObject, eventdata, handles)
% hObject    handle to CB_warmup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CB_warmup
ToggleEditBox(handles.CB_warmup, handles.EB_warmup);



function EB_delay_Callback(hObject, eventdata, handles)
% hObject    handle to EB_delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_delay as text
%        str2double(get(hObject,'String')) returns contents of EB_delay as a double


% --- Executes during object creation, after setting all properties.
function EB_delay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CB_delay.
function CB_delay_Callback(hObject, eventdata, handles)
% hObject    handle to CB_delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CB_delay
ToggleEditBox(handles.CB_delay, handles.EB_delay);


function EB_prePulse_Callback(hObject, eventdata, handles)
% hObject    handle to EB_prePulse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_prePulse as text
%        str2double(get(hObject,'String')) returns contents of EB_prePulse as a double


% --- Executes during object creation, after setting all properties.
function EB_prePulse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_prePulse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CB_prePulse.
function CB_prePulse_Callback(hObject, eventdata, handles)
% hObject    handle to CB_prePulse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CB_prePulse
ToggleEditBox(handles.CB_prePulse, handles.EB_prePulse);


function EB_interPhase_Callback(hObject, eventdata, handles)
% hObject    handle to EB_interPhase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_interPhase as text
%        str2double(get(hObject,'String')) returns contents of EB_interPhase as a double


% --- Executes during object creation, after setting all properties.
function EB_interPhase_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_interPhase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CB_interPhase.
function CB_interPhase_Callback(hObject, eventdata, handles)
% hObject    handle to CB_interPhase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CB_interPhase
ToggleEditBox(handles.CB_interPhase, handles.EB_interPhase);

% --- Executes on button press in CB_holdOffTime.
function CB_holdOffTime_Callback(hObject, eventdata, handles)
% hObject    handle to CB_holdOffTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CB_holdOffTime



function EB_interPulse_Callback(hObject, eventdata, handles)
% hObject    handle to EB_interPulse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_interPulse as text
%        str2double(get(hObject,'String')) returns contents of EB_interPulse as a double


% --- Executes during object creation, after setting all properties.
function EB_interPulse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_interPulse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CB_interPulse.
function CB_interPulse_Callback(hObject, eventdata, handles)
% hObject    handle to CB_interPulse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CB_interPulse


% --- Executes on selection change in POP_channel.
function POP_channel_Callback(hObject, eventdata, handles)
% hObject    handle to POP_channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns POP_channel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from POP_channel
handles.program.SelectedChannelIndex = hObject.Value;
InitializeObjects(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function POP_channel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to POP_channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CB_enableChannel.
function CB_enableChannel_Callback(hObject, eventdata, handles)
% hObject    handle to CB_enableChannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CB_enableChannel



function EB_minAmp_Callback(hObject, eventdata, handles)
% hObject    handle to EB_minAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_minAmp as text
%        str2double(get(hObject,'String')) returns contents of EB_minAmp as a double


% --- Executes during object creation, after setting all properties.
function EB_minAmp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_minAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_maxAmp_Callback(hObject, eventdata, handles)
% hObject    handle to EB_maxAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_maxAmp as text
%        str2double(get(hObject,'String')) returns contents of EB_maxAmp as a double


% --- Executes during object creation, after setting all properties.
function EB_maxAmp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_maxAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox14.
function checkbox14_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox14



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit24 as text
%        str2double(get(hObject,'String')) returns contents of edit24 as a double


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit25_Callback(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit25 as text
%        str2double(get(hObject,'String')) returns contents of edit25 as a double


% --- Executes during object creation, after setting all properties.
function edit25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit26_Callback(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit26 as text
%        str2double(get(hObject,'String')) returns contents of edit26 as a double


% --- Executes during object creation, after setting all properties.
function edit26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit27_Callback(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit27 as text
%        str2double(get(hObject,'String')) returns contents of edit27 as a double


% --- Executes during object creation, after setting all properties.
function edit27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_prePulseActive_Callback(hObject, eventdata, handles)
% hObject    handle to EB_prePulseActive (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_prePulseActive as text
%        str2double(get(hObject,'String')) returns contents of EB_prePulseActive as a double


% --- Executes during object creation, after setting all properties.
function EB_prePulseActive_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_prePulseActive (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit30_Callback(hObject, eventdata, handles)
% hObject    handle to edit30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit30 as text
%        str2double(get(hObject,'String')) returns contents of edit30 as a double


% --- Executes during object creation, after setting all properties.
function edit30_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_passiveRecoveryActive_Callback(hObject, eventdata, handles)
% hObject    handle to EB_passiveRecoveryActive (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_passiveRecoveryActive as text
%        str2double(get(hObject,'String')) returns contents of EB_passiveRecoveryActive as a double


% --- Executes during object creation, after setting all properties.
function EB_passiveRecoveryActive_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_passiveRecoveryActive (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit32_Callback(hObject, eventdata, handles)
% hObject    handle to edit32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit32 as text
%        str2double(get(hObject,'String')) returns contents of edit32 as a double


% --- Executes during object creation, after setting all properties.
function edit32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
