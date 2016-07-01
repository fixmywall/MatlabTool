function varargout = guiv6_1(varargin)
% GUIV6_1 MATLAB code for guiv6_1.fig
%      GUIV6_1, by itself, creates a new GUIV6_1 or raises the existing
%      singleton*.
%
%      H = GUIV6_1 returns the handle to a new GUIV6_1 or the handle to
%      the existing singleton*.
%
%      GUIV6_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIV6_1.M with the given input arguments.
%
%      GUIV6_1('Property','Value',...) creates a new GUIV6_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guiv6_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guiv6_1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guiv6_1

% Last Modified by GUIDE v2.5 30-Jun-2016 16:07:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guiv6_1_OpeningFcn, ...
                   'gui_OutputFcn',  @guiv6_1_OutputFcn, ...
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


% --- Executes just before guiv6_1 is made visible.
function guiv6_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guiv6_1 (see VARARGIN)

% Choose default command line output for guiv6_1
handles.output = hObject;
defaultMode = handles.POP_modeSelect.String{handles.POP_modeSelect.Value};
handles.constraints = Constraints(defaultMode);
UpdateMode(handles, defaultMode);
handles.waveform = Waveform(handles);      %represents a collection of pulse objects

%update the electrode group box with array of all electrode edit boxes
handles.PANEL_electrodesPolarity.UserData = ...
    [   handles.EB_electrode_1, handles.EB_electrode_2, handles.EB_electrode_3, handles.EB_electrode_4, ...
        handles.EB_electrode_5, handles.EB_electrode_6, handles.EB_electrode_7, handles.EB_electrode_8, ...
        handles.EB_electrode_9, handles.EB_electrode_10, handles.EB_electrode_11, handles.EB_electrode_12, ...
        handles.EB_electrode_13, handles.EB_electrode_14, handles.EB_electrode_15, handles.EB_electrode_16, ...
        handles.EB_electrode_17, handles.EB_electrode_18, handles.EB_electrode_19, handles.EB_electrode_20, ...
        handles.EB_electrode_21, handles.EB_electrode_22, handles.EB_electrode_23, handles.EB_electrode_24, ...
        handles.EB_electrode_25, handles.EB_electrode_26, handles.EB_electrode_27, handles.EB_electrode_28, ...
        handles.EB_electrode_29, handles.EB_electrode_30, handles.EB_electrode_31, handles.EB_electrode_32];
    
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guiv6_1 wait for user response (see UIRESUME)
% uiwait(handles.mainFig);


% --- Outputs from this function are returned to the command line.
function varargout = guiv6_1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in checkbox9.
function checkbox9_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox9


% --- Executes on button press in checkbox10.
function checkbox10_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox10


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox11.
function checkbox11_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox11


% --- Executes on button press in checkbox12.
function checkbox12_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox12


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7


% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8



function edit47_Callback(hObject, eventdata, handles)
% hObject    handle to edit47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit47 as text
%        str2double(get(hObject,'String')) returns contents of edit47 as a double


% --- Executes during object creation, after setting all properties.
function edit47_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%called by the electrode slider createfcns
function SLIDE_electrode_initialization(hSlide)
    hSlide.Max = Constants.MAX_ELECTRODE_PERCENT;
    hSlide.Min = Constants.MIN_ELECTRODE_PERCENT;
    hSlide.SliderStep = [Constants.ELECTRODE_STEP/(hSlide.Max - hSlide.Min), 10];

    
% --- Executes on slider movement.
function SLIDE_electrode_1_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

ElectrodeSlideCBHelper(hObject,handles.EB_electrode_1);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
    
% --- Executes on slider movement.
function SLIDE_electrode_2_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_2);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);


% --- Executes on slider movement.
function SLIDE_electrode_3_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_3);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);


% --- Executes on slider movement.
function SLIDE_electrode_4_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_4);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);


% --- Executes on slider movement.
function SLIDE_electrode_5_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_5);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);


% --- Executes on slider movement.
function SLIDE_electrode_6_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_6);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
 

% --- Executes on slider movement.
function SLIDE_electrode_7_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_7);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
 

% --- Executes on slider movement.
function SLIDE_electrode_8_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_8);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
 

% --- Executes on slider movement.
function SLIDE_electrode_9_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_9);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
 

% --- Executes on slider movement.
function SLIDE_electrode_10_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_10);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
 

% --- Executes on slider movement.
function SLIDE_electrode_11_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_11);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
 

% --- Executes on slider movement.
function SLIDE_electrode_12_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_12);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
 

% --- Executes on slider movement.
function SLIDE_electrode_13_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_13);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
 

% --- Executes on slider movement.
function SLIDE_electrode_14_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_14);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
 

% --- Executes on slider movement.
function SLIDE_electrode_15_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_15);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
 

% --- Executes on slider movement.
function SLIDE_electrode_16_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_16);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
 

% --- Executes on slider movement.
function SLIDE_electrode_17_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_17);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
 

% --- Executes on slider movement.
function SLIDE_electrode_18_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_18);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
 

% --- Executes on slider movement.
function SLIDE_electrode_19_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_19);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
 

% --- Executes on slider movement.
function SLIDE_electrode_20_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_20);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
 

% --- Executes on slider movement.
function SLIDE_electrode_21_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_21);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
 

% --- Executes on slider movement.
function SLIDE_electrode_22_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_22);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
 

% --- Executes on slider movement.
function SLIDE_electrode_23_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_23);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
 

% --- Executes on slider movement.
function SLIDE_electrode_24_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_24);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
 

% --- Executes on slider movement.
function SLIDE_electrode_25_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_25);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
 

% --- Executes on slider movement.
function SLIDE_electrode_26_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_26);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
 

% --- Executes on slider movement.
function SLIDE_electrode_27_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_27);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
 

% --- Executes on slider movement.
function SLIDE_electrode_28_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_28);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
 

% --- Executes on slider movement.
function SLIDE_electrode_29_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_29);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_29_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
 

% --- Executes on slider movement.
function SLIDE_electrode_30_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_30);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_30_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
 

% --- Executes on slider movement.
function SLIDE_electrode_31_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_31);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
 

% --- Executes on slider movement.
function SLIDE_electrode_32_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ElectrodeSlideCBHelper(hObject,handles.EB_electrode_32);

% --- Executes during object creation, after setting all properties.
function SLIDE_electrode_32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDE_electrode_32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
SLIDE_electrode_initialization(hObject);
 

%function called whenever an electrode slider callback is called
function ElectrodeSlideCBHelper(hObject, hEdit)
    hEdit.String = num2str(hObject.Value);
    


function EB_FixedAmp_Callback(hObject, eventdata, handles)
% hObject    handle to EB_FixedAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_FixedAmp as text
%        str2double(get(hObject,'String')) returns contents of EB_FixedAmp as a double

%round text to nearest tens
hObject.String = num2str(round(str2double(hObject.String), -1));

% --- Executes during object creation, after setting all properties.
function EB_FixedAmp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_FixedAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_MinStochAmp_Callback(hObject, eventdata, handles)
% hObject    handle to EB_MinStochAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_MinStochAmp as text
%        str2double(get(hObject,'String')) returns contents of EB_MinStochAmp as a double


% --- Executes during object creation, after setting all properties.
function EB_MinStochAmp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_MinStochAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_MaxStochAmp_Callback(hObject, eventdata, handles)
% hObject    handle to EB_MaxStochAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_MaxStochAmp as text
%        str2double(get(hObject,'String')) returns contents of EB_MaxStochAmp as a double


% --- Executes during object creation, after setting all properties.
function EB_MaxStochAmp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_MaxStochAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_StartRampAmp_Callback(hObject, eventdata, handles)
% hObject    handle to EB_StartRampAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_StartRampAmp as text
%        str2double(get(hObject,'String')) returns contents of EB_StartRampAmp as a double


% --- Executes during object creation, after setting all properties.
function EB_StartRampAmp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_StartRampAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit52_Callback(hObject, eventdata, handles)
% hObject    handle to edit52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit52 as text
%        str2double(get(hObject,'String')) returns contents of edit52 as a double


% --- Executes during object creation, after setting all properties.
function edit52_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_RampAmpStep_Callback(hObject, eventdata, handles)
% hObject    handle to EB_RampAmpStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_RampAmpStep as text
%        str2double(get(hObject,'String')) returns contents of EB_RampAmpStep as a double


% --- Executes during object creation, after setting all properties.
function EB_RampAmpStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_RampAmpStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PB_AddPhase.
function PB_AddPhase_Callback(hObject, eventdata, handles)
% hObject    handle to PB_AddPhase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
iterations = str2double(handles.EB_numPhases.String);
if isnan(iterations)
    return;
end                 

%get the type of amplitude and width (fixed, stochastic, etc....)
switch (handles.BG_PhaseAmp.SelectedObject.Tag)
    case 'RB_FixedAmp'
        ampType = PhaseTypes.Fixed;
        minAmp = str2double(handles.EB_FixedAmp.String);
        maxAmp = minAmp;
        ampStep = 0;
    case 'RB_StochasticAmp'
        ampType = PhaseTypes.Stochastic;
        minAmp = str2double(handles.EB_MinStochAmp.String);
        maxAmp = str2double(handles.EB_MaxStochAmp.String);
        ampStep = 0;
    case 'RB_RampAmp'
        ampType = PhaseTypes.Ramped;
        minAmp = str2double(handles.EB_StartRampAmp.String);
        maxAmp = str2double(handles.EB_MaxRampAmp.String);
        ampStep = str2double(handles.EB_RampAmpStep.String);
end

%get type of phase width, setting up the phase parameters
switch (handles.BG_PhaseWidth.SelectedObject.Tag)
    case 'RB_FixedWidth'
        widthType = PhaseTypes.Fixed;
        minWidth = str2double(handles.EB_FixedWidth.String);
        maxWidth = minAmp;
        widthStep = 0;
    case 'RB_StochasticWidth'
        widthType = PhaseTypes.Stochastic;
        minWidth = str2double(handles.EB_MinStochWidth.String);
        maxWidth = str2double(handles.EB_MaxStochWidth.String);
        widthStep = 0;
    case 'RB_RampWidth'
        widthType = PhaseTypes.Ramped;
        minWidth = str2double(handles.EB_RampWidthStart.String);
        maxWidth = str2double(handles.EB_RampWidthMax.String);
        widthStep = str2double(handles.EB_RampWidthStep.String);
end

%if ramped type amplitude, add an additional phase
%if (ampType==PhaseTypes.Ramped)
    %handles.waveform.AddPhase(Phase(-ampVal, minAmp, maxAmp, ampStep, widthVal, minWidth, maxWidth, widthStep, ampType, widthType));
%end

handles.waveform.GeneratePhases(ampType, widthType, minAmp, maxAmp, ampStep, minWidth, maxWidth, widthStep, iterations);


function EB_numPhases_Callback(hObject, eventdata, handles)
% hObject    handle to EB_numPhases (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_numPhases as text
%        str2double(get(hObject,'String')) returns contents of EB_numPhases as a double
if isnan(str2double(hObject.String)) || (mod(str2double(hObject.String),1) ~= 0)
    warningPopUpMenu(Constants.INT_REQUIRED_ERROR);
    hObject.String='';
end

% --- Executes during object creation, after setting all properties.
function EB_numPhases_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_numPhases (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_FixedWidth_Callback(hObject, eventdata, handles)
% hObject    handle to EB_FixedWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_FixedWidth as text
%        str2double(get(hObject,'String')) returns contents of EB_FixedWidth as a double


% --- Executes during object creation, after setting all properties.
function EB_FixedWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_FixedWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_MinStochWidth_Callback(hObject, eventdata, handles)
% hObject    handle to EB_MinStochWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_MinStochWidth as text
%        str2double(get(hObject,'String')) returns contents of EB_MinStochWidth as a double


% --- Executes during object creation, after setting all properties.
function EB_MinStochWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_MinStochWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_MaxStochWidth_Callback(hObject, eventdata, handles)
% hObject    handle to EB_MaxStochWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_MaxStochWidth as text
%        str2double(get(hObject,'String')) returns contents of EB_MaxStochWidth as a double


% --- Executes during object creation, after setting all properties.
function EB_MaxStochWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_MaxStochWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_RampWidthStart_Callback(hObject, eventdata, handles)
% hObject    handle to EB_RampWidthStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_RampWidthStart as text
%        str2double(get(hObject,'String')) returns contents of EB_RampWidthStart as a double


% --- Executes during object creation, after setting all properties.
function EB_RampWidthStart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_RampWidthStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_RampWidthMax_Callback(hObject, eventdata, handles)
% hObject    handle to EB_RampWidthMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_RampWidthMax as text
%        str2double(get(hObject,'String')) returns contents of EB_RampWidthMax as a double


% --- Executes during object creation, after setting all properties.
function EB_RampWidthMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_RampWidthMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_RampWidthStep_Callback(hObject, eventdata, handles)
% hObject    handle to EB_RampWidthStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_RampWidthStep as text
%        str2double(get(hObject,'String')) returns contents of EB_RampWidthStep as a double


% --- Executes during object creation, after setting all properties.
function EB_RampWidthStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_RampWidthStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ElectrodeEditHelper(hObject, hSlide)
num = str2double(hObject.String);

%check that the value is an integer and is within the min and max of
%the slider
if (mod(num,1) == 0) && num>=hSlide.Min && num<=hSlide.Max
    if hSlide.Value ~= num
        hSlide.Value = num;
    end
else
%error
warningPopUpMenu(Constants.INVALID_NUMBER_ERROR);
end

function ElectrodeSumTooHigh()
sumPos=0;
sumNeg=0;
for i=1:32
    
end
    
    
function EB_electrode_1_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_1 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_1 as a double

%make sure value entered is integer between 0 and 100
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_1);

% --- Executes during object creation, after setting all properties.
function EB_electrode_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_electrode_32_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_32 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_32 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_32)

% --- Executes during object creation, after setting all properties.
function EB_electrode_32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function EB_electrode_31_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_31 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_31 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_31);

% --- Executes during object creation, after setting all properties.
function EB_electrode_31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function EB_electrode_30_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_30 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_30 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_30);

% --- Executes during object creation, after setting all properties.
function EB_electrode_30_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function EB_electrode_29_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_29 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_29 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_29);

% --- Executes during object creation, after setting all properties.
function EB_electrode_29_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function EB_electrode_28_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_28 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_28 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_28);

% --- Executes during object creation, after setting all properties.
function EB_electrode_28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function EB_electrode_27_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_27 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_27 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_27);

% --- Executes during object creation, after setting all properties.
function EB_electrode_27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function EB_electrode_26_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_26 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_26 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_26);

% --- Executes during object creation, after setting all properties.
function EB_electrode_26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function EB_electrode_25_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_25 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_25 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_25);

% --- Executes during object creation, after setting all properties.
function EB_electrode_25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function EB_electrode_24_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_24 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_24 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_24);

% --- Executes during object creation, after setting all properties.
function EB_electrode_24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function EB_electrode_23_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_23 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_23 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_23);

% --- Executes during object creation, after setting all properties.
function EB_electrode_23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function EB_electrode_22_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_22 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_22 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_22);

% --- Executes during object creation, after setting all properties.
function EB_electrode_22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_electrode_21_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_21 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_21 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_21);

% --- Executes during object creation, after setting all properties.
function EB_electrode_21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_electrode_20_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_20 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_20 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_20);

% --- Executes during object creation, after setting all properties.
function EB_electrode_20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_electrode_19_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_19 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_19 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_19);

% --- Executes during object creation, after setting all properties.
function EB_electrode_19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_electrode_18_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_18 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_18 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_18);

% --- Executes during object creation, after setting all properties.
function EB_electrode_18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_electrode_17_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_17 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_17 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_17);

% --- Executes during object creation, after setting all properties.
function EB_electrode_17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_electrode_16_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_16 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_16 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_16);

% --- Executes during object creation, after setting all properties.
function EB_electrode_16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_electrode_15_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_15 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_15 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_15);

% --- Executes during object creation, after setting all properties.
function EB_electrode_15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_electrode_14_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_14 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_14 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_14);

% --- Executes during object creation, after setting all properties.
function EB_electrode_14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_electrode_13_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_13 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_13 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_13);

% --- Executes during object creation, after setting all properties.
function EB_electrode_13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_electrode_12_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_12 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_12 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_12);

% --- Executes during object creation, after setting all properties.
function EB_electrode_12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_electrode_11_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_11 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_11 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_11);

% --- Executes during object creation, after setting all properties.
function EB_electrode_11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_electrode_10_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_10 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_10 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_10);

% --- Executes during object creation, after setting all properties.
function EB_electrode_10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_electrode_9_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_9 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_9 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_9);

% --- Executes during object creation, after setting all properties.
function EB_electrode_9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_electrode_8_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_8 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_8 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_8);

% --- Executes during object creation, after setting all properties.
function EB_electrode_8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_electrode_7_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_7 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_7 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_7);

% --- Executes during object creation, after setting all properties.
function EB_electrode_7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_electrode_6_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_6 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_6 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_6);

% --- Executes during object creation, after setting all properties.
function EB_electrode_6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function EB_electrode_5_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_5 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_5 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_5);

% --- Executes during object creation, after setting all properties.
function EB_electrode_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function EB_electrode_4_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_4 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_4 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_4);

% --- Executes during object creation, after setting all properties.
function EB_electrode_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function EB_electrode_3_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_3 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_3 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_3);

% --- Executes during object creation, after setting all properties.
function EB_electrode_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_electrode_2_Callback(hObject, eventdata, handles)
% hObject    handle to EB_electrode_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_electrode_2 as text
%        str2double(get(hObject,'String')) returns contents of EB_electrode_2 as a double
ElectrodeEditHelper(hObject, handles.SLIDE_electrode_2);

% --- Executes during object creation, after setting all properties.
function EB_electrode_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_electrode_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ClearData(handles)
handles.waveform = Waveform(handles);      %clears waveform object
cla(handles.axes_Pulse, 'reset');
cla(handles.axes_Waveform, 'reset');
guidata(handles.mainFig, handles);

% --- Executes on button press in PB_ClearAll. Clears all data pertaining
% to the waveform and the plots
function PB_ClearAll_Callback(hObject, eventdata, handles)
% hObject    handle to PB_ClearAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ClearData(handles);

function EB_MaxRampAmp_Callback(hObject, eventdata, handles)
% hObject    handle to EB_MaxRampAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_MaxRampAmp as text
%        str2double(get(hObject,'String')) returns contents of EB_MaxRampAmp as a double


% --- Executes during object creation, after setting all properties.
function EB_MaxRampAmp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_MaxRampAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_Refresh_Callback(hObject, eventdata, handles)
% hObject    handle to EB_Refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_Refresh as text
%        str2double(get(hObject,'String')) returns contents of EB_Refresh as a double




% --- Executes during object creation, after setting all properties.
function EB_Refresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_Refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PB_Refresh.
function PB_Refresh_Callback(hObject, eventdata, handles)
% hObject    handle to PB_Refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
num=str2double(handles.EB_Refresh.String);
if isnan(num)
    num=0;
end

handles.waveform.RefreshPulse(num);
handles.waveform.PlotWaveform();


% --- Executes on button press in PB_PulseEditor.
function PB_PulseEditor_Callback(hObject, eventdata, handles)
% hObject    handle to PB_PulseEditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

PulseEditor(handles.waveform);      %pass the waveform handle to Pulse Editor

function EB_ForceInteger(hEdit)
if isnan(str2double(hEdit.String))
    warningPopUpMenu(Constants.INT_REQUIRED_ERROR);
    hEdit.String = '';
end

%returns true if hEdit's string property contains an integer
function isInt = StringIsInteger(string)
val = str2double(string);
if isnan(val) || mod(val, 1.0) ~= 0
    isInt = false;
    warningPopUpMenu(Constants.INT_REQUIRED_ERROR);
else
    isInt = true;
end

%UpdateMode: updates the waveform and GUI elements whenever the mode is switched
function UpdateMode(handles, mode)
handles.constraints.Update(mode);

%clear the waveform object
handles.waveform = Waveform(handles);
cla(handles.axes_Pulse, 'reset');
cla(handles.axes_Waveform, 'reset');

switch mode
    case Constants.MODE_FALCON
        %update GUI
        handles.PANEL_phaseSetup.Visible = 'off';
        handles.PANEL_falconPulseSetup.Visible = 'on';
        handles.EB_falconPhaseOneAmp.String = num2str(Constants.FALCON_DEFAULT_AMP(1));
        handles.EB_falconPhaseTwoAmp.String = num2str(Constants.FALCON_DEFAULT_AMP(2));
        handles.EB_falconPhaseOneWidth.String = num2str(Constants.FALCON_DEFAULT_WIDTH(1));
        handles.EB_falconPhaseTwoWidth.String = num2str(Constants.FALCON_DEFAULT_WIDTH(2));
        %generate the two default phases
        handles.waveform.GeneratePhases(PhaseTypes.Fixed, PhaseTypes.Fixed, Constants.FALCON_DEFAULT_AMP(1), Constants.FALCON_DEFAULT_AMP(1), ...
                                        0, Constants.FALCON_DEFAULT_WIDTH(1), Constants.FALCON_DEFAULT_WIDTH(1), 0, 1 );
        handles.waveform.GeneratePhases(PhaseTypes.Fixed, PhaseTypes.Fixed, Constants.FALCON_DEFAULT_AMP(2), Constants.FALCON_DEFAULT_AMP(2), ...
                                        0, Constants.FALCON_DEFAULT_WIDTH(2), Constants.FALCON_DEFAULT_WIDTH(2), 0, 1 );
                                    
    case Constants.MODE_SANDBOX
        handles.PANEL_falconPulseSetup.Visible = 'off';
        handles.PANEL_phaseSetup.Visible = 'on';   
end

guidata(handles.mainFig, handles);



% --- Executes on selection change in POP_modeSelect.
function POP_modeSelect_Callback(hObject, eventdata, handles)
% hObject    handle to POP_modeSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns POP_modeSelect contents as cell array
%        contents{get(hObject,'Value')} returns selected item from POP_modeSelect
mode = hObject.String{hObject.Value};
UpdateMode(handles, mode);


% --- Executes during object creation, after setting all properties.
function POP_modeSelect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to POP_modeSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

hObject.String = {  Constants.MODE_SANDBOX, Constants.MODE_FALCON };    %in future: more modes


% --- Executes on selection change in POP_electrodes.
function POP_electrodes_Callback(hObject, eventdata, handles)
% hObject    handle to POP_electrodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns POP_electrodes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from POP_electrodes


% --- Executes during object creation, after setting all properties.
function POP_electrodes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to POP_electrodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PB_plotElectrodeWaveform.
function PB_plotElectrodeWaveform_Callback(hObject, eventdata, handles)
% hObject    handle to PB_plotElectrodeWaveform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%get index of electrode
electrodeIndex = handles.POP_electrodes.String{handles.POP_electrodes.Value};
%if all, then we plot the overall output waveform
if strcmp(electrodeIndex, 'All')
    coefficient=100;
else    %otherwise, get scaling coefficient
    coefficient = str2double(handles.PANEL_electrodesPolarity.UserData(str2double(electrodeIndex)).String);
    
end
handles.waveform.Scale = coefficient;
handles.waveform.PlotWaveform();


% --- Executes on button press in PB_falconUpdatePhase.
function PB_falconUpdatePhase_Callback(hObject, eventdata, handles)
% hObject    handle to PB_falconUpdatePhase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
amp1 = str2double(handles.EB_falconPhaseOneAmp.String);
width1 = str2double(handles.EB_falconPhaseOneWidth.String);
amp2 = str2double(handles.EB_falconPhaseTwoAmp.String);
width2 = str2double(handles.EB_falconPhaseTwoWidth.String);

handles.waveform.SetPhaseAmplitude(1, amp1);
handles.waveform.SetPhaseWidth(1, width1);
handles.waveform.SetPhaseAmplitude(2, amp2);
handles.waveform.SetPhaseWidth(2, width2);
handles.waveform.PlotWaveform();

function EB_falconPhaseTwoAmp_Callback(hObject, eventdata, handles)
% hObject    handle to EB_falconPhaseTwoAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_falconPhaseTwoAmp as text
%        str2double(get(hObject,'String')) returns contents of EB_falconPhaseTwoAmp as a double


% --- Executes during object creation, after setting all properties.
function EB_falconPhaseTwoAmp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_falconPhaseTwoAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_falconPhaseTwoWidth_Callback(hObject, eventdata, handles)
% hObject    handle to EB_falconPhaseTwoWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_falconPhaseTwoWidth as text
%        str2double(get(hObject,'String')) returns contents of EB_falconPhaseTwoWidth as a double


% --- Executes during object creation, after setting all properties.
function EB_falconPhaseTwoWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_falconPhaseTwoWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_falconPhaseOneAmp_Callback(hObject, eventdata, handles)
% hObject    handle to EB_falconPhaseOneAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_falconPhaseOneAmp as text
%        str2double(get(hObject,'String')) returns contents of EB_falconPhaseOneAmp as a double


% --- Executes during object creation, after setting all properties.
function EB_falconPhaseOneAmp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_falconPhaseOneAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_falconPhaseOneWidth_Callback(hObject, eventdata, handles)
% hObject    handle to EB_falconPhaseOneWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_falconPhaseOneWidth as text
%        str2double(get(hObject,'String')) returns contents of EB_falconPhaseOneWidth as a double


% --- Executes during object creation, after setting all properties.
function EB_falconPhaseOneWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_falconPhaseOneWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EB_falconAddPhases_Callback(hObject, eventdata, handles)
% hObject    handle to EB_falconAddPhases (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_falconAddPhases as text
%        str2double(get(hObject,'String')) returns contents of EB_falconAddPhases as a double


% --- Executes during object creation, after setting all properties.
function EB_falconAddPhases_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_falconAddPhases (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in PB_sandboxSettings.
function PB_sandboxSettings_Callback(hObject, eventdata, handles)
% hObject    handle to PB_sandboxSettings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SandboxRuleSettings(handles.constraints);



function edit111_Callback(hObject, eventdata, handles)
% hObject    handle to edit111 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit111 as text
%        str2double(get(hObject,'String')) returns contents of edit111 as a double


% --- Executes during object creation, after setting all properties.
function edit111_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit111 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PB_falconSettings.
function PB_falconSettings_Callback(hObject, eventdata, handles)
% hObject    handle to PB_falconSettings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hSettings = SandboxRuleSettings(handles.constraints);
uiwait(hSettings);
handles.waveform.PlotWaveform();



function EB_falconNumPulses_Callback(hObject, eventdata, handles)
% hObject    handle to EB_falconNumPulses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EB_falconNumPulses as text
%        str2double(get(hObject,'String')) returns contents of EB_falconNumPulses as a double


% --- Executes during object creation, after setting all properties.
function EB_falconNumPulses_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EB_falconNumPulses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PB_falconNumPulsesApply.
function PB_falconNumPulsesApply_Callback(hObject, eventdata, handles)
% hObject    handle to PB_falconNumPulsesApply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
strval = handles.EB_falconNumPulses.String;
if StringIsInteger(strval)
    handles.waveform.RepeatSelectedPulse(str2double(strval));
end
