function varargout = GUI2(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI2_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI2_OutputFcn, ...
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

function GUI2_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = GUI2_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function edit1_Callback(hObject, eventdata, handles)
b= get(hObject,'String');
handles.edit1=str2double(b);
guidata(hObject,handles);

function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit2_Callback(hObject, eventdata, handles)
c= get(hObject,'String');
%handles.edit2=str2double(c);
guidata(hObject,handles);

function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton1_Callback(hObject, eventdata, handles)
global dclay reply
global BL phishale BI Nt Area Df LBD radius
dclay=single(handles.edit1);
S=get(handles.edit2,'string');
S1=str2num(S);
if isempty(S1) 
  reply=-999;
else
    reply=S1;
end

global BL2 index
[BL2]=remove_repetitions(BL);
[Nt, Df, dclay, Area, index, radius,LBD, BI]= find_parameters_fractal(phishale, BL2, dclay,reply);
close(GUI2)

%% step (4) and (5)
%############################## Error analysis on maximum porosity #####################################################################
merror;
waitfor(merror);

