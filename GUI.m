
function varargout = GUI(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function edit1_Callback(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit2_Callback(hObject, eventdata, handles)

a= get(hObject,'String');
handles.edit2=str2num(a);
guidata(hObject,handles);

function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit3_Callback(hObject, eventdata, handles)
b= get(hObject,'String');
handles.edit3=str2double(b);
guidata(hObject,handles);

function edit3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit4_Callback(hObject, eventdata, handles)
c= get(hObject,'String');
handles.edit4=str2double(c);
guidata(hObject,handles);

function edit4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
d= get(hObject,'String');
handles.edit5=str2double(d);
guidata(hObject,handles);

function edit5_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton1_Callback(hObject, eventdata, handles)
[handles.filename pathname]= uigetfile({'*.*'},'File Selector');
handles.fullpathname=strcat(pathname,handles.filename);
handles.text=fileread(handles.fullpathname);
set(handles.text2,'string',handles.filename);
guidata(hObject,handles);

function pushbutton2_Callback(hObject, eventdata, handles)
handles.m=dlmread(handles.fullpathname,'',handles.edit2)

guidata(hObject,handles);

handles.RHOlog=dlmread('AW1.txt','',[(handles.edit2+1) (handles.edit3-1) (handles.edit35-1) (handles.edit3-1)]);
handles.Depthlog=dlmread('AW1.txt','',[(handles.edit2+1) 0 (handles.edit35-1) 0]);
handles.GRlog=dlmread('AW1.txt','',[(handles.edit2+1) (handles.edit5-1) (handles.edit35-1) (handles.edit5-1)]);
guidata(hObject,handles);

function figure1_ResizeFcn(hObject, eventdata, handles)

function edit6_Callback(hObject, eventdata, handles)
e= get(hObject,'String');
handles.edit6=str2double(e);
guidata(hObject,handles);

function edit6_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit7_Callback(hObject, eventdata, handles)
f= get(hObject,'String');
handles.edit7=str2double(f);
guidata(hObject,handles);

function edit7_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit8_Callback(hObject, eventdata, handles)
h= get(hObject,'String');
handles.edit8=str2double(h);
guidata(hObject,handles);

function edit8_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit11_Callback(hObject, eventdata, handles)
k= get(hObject,'String');
handles.edit11=str2double(k);
guidata(hObject,handles);

function edit11_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit12_Callback(hObject, eventdata, handles)
l= get(hObject,'String');
handles.edit12=str2double(l);
guidata(hObject,handles);

function edit12_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
m= get(hObject,'String');
handles.edit13=str2double(m);
guidata(hObject,handles);


function edit13_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)

n= get(hObject,'String');
handles.edit14=str2double(n);
guidata(hObject,handles);


function edit14_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
o= get(hObject,'String');
handles.edit15=str2double(o);
guidata(hObject,handles);


function edit15_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
p= get(hObject,'String');
handles.edit16=str2double(p);
guidata(hObject,handles);

function edit16_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
q= get(hObject,'String');
handles.edit18=str2double(q);
guidata(hObject,handles);


function edit18_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit32_Callback(hObject, eventdata, handles)
r1= get(hObject,'String');
handles.edit40=str2double(r1);
guidata(hObject,handles);

function edit32_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit26_Callback(hObject, eventdata, handles)
y= get(hObject,'String');
handles.edit26=str2double(y);
guidata(hObject,handles);

function edit26_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit28_Callback(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit28 as text
%        str2double(get(hObject,'String')) returns contents of edit28 as a double
z= get(hObject,'String');
handles.edit28=str2double(z);
guidata(hObject,handles);

function edit28_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit29_Callback(hObject, eventdata, handles)

z1= get(hObject,'String');
handles.edit29=str2double(z1);
guidata(hObject,handles);

function edit29_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit30_Callback(hObject, eventdata, handles)
z2= get(hObject,'String');
handles.edit30=str2double(z2);
guidata(hObject,handles);

function edit30_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit31_Callback(hObject, eventdata, handles)

z3= get(hObject,'String');
handles.edit31=str2double(z3);
guidata(hObject,handles);



function edit31_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit35_Callback(hObject, eventdata, handles)

z4= get(hObject,'String');
handles.edit35=str2double(z4);
guidata(hObject,handles);



function edit35_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton6_Callback(hObject, eventdata, handles)
global depth Ldepth logs RHO GR 

%% Step (1)

logs.RHO=single(handles.RHOlog);
logs.Depth=single(handles.Depthlog);
logs.GR=single(handles.GRlog);
a=single(handles.edit6);

RHO.f=single(handles.edit7);    %fluid density- default density of saline water in g/cc    


RHO.m=single(handles.edit8);    %density of matrix-Default density of quartz mineral in g/cc

GR.high=single(handles.edit11);

GR.sand_max=single(handles.edit12);
GR.shale_min=single(handles.edit13); %Maximum porosity of predominantly shale intervals, the porosity values below which are ignored from the computation, it can be tween 0.11 to 0.14

depth.start=single(handles.edit14);  % Starting depth of the analysis window
depth.stop=single(handles.edit15);   % Stop depth of the analysis window

Ldepth.topSST=single(handles.edit28);  %top of pure sand layer
Ldepth.bottomSST=single(handles.edit30); %bottom of pure sand layer
Ldepth.topSh=single(handles.edit29);   %top of pure shale layer
Ldepth.bottomSh=single(handles.edit31); % bottom of pure shale layer



global phishale
phishale=single(handles.edit18); %Maximum porosity of predominantly shale intervals, the porosity values below which are ignored from the computation, it can be tween 0.11 to 0.14



RHO.min=single(handles.edit40); %RHOmin should be greater than or equal to RHOf
RHO.max=single(handles.edit26); %RHO.max this should less than or equal to RHOm
%find index for zone of interest
[logs]=Filter_N_Interpolate_logs(logs,depth,  RHO, GR, a );

%% Step (2) 
%%% step (2) finding porosity (micro, effective, useful), vol (of shale and sand)
global vol PHI
[PHI, vol]=Find_Parameters1(logs, GR, RHO,Ldepth);
global BL  
[BL, B] = blocked(PHI, vol, logs, GR);

figure(1);      h=plot(vol.shale*100,PHI.U*100,'b*',  vol.shale*100,PHI.PHI*100,'ko');
xlabel('shale volume');         ylabel('porosity');         title('\bf{porosity variation with shale volume}');
legend(h,{'total porosity','useful porosity','effective porosity'},'Location','NorthWest');
mkdir('OUTPUT');
mkdir('OUTPUT/PERMEABILITY')
mkdir('OUTPUT/PHI')
mkdir('OUTPUT/FIGURES')


fileID = fopen('OUTPUT/PHI/blocked_logsAW.txt','w');
fprintf(fileID,'%10s %10s %10s %10s %10s %10s \n', 'BL.Depth', 'BL.VSH', 'BL.VSST', 'BL.PHI_e', 'BL.PHI_c','BL.PHI_U1'); 
for jk=1:length(BL.Depth)
    fprintf(fileID, '%10.3f \t %10.3f \t %10.3f \t %10.3f \t %10.3f \t %10.3f \t \n', BL.Depth(jk), BL.VSH(jk),BL.VSST(jk),BL.PHI_e(jk), BL.PHI_c(jk),BL.PHI_U1(jk));
end 
fclose(fileID);

%% step (3)
%%% Estimate Grain radius, Df, lambda (min and max), cross section area (cross section area, pore area),
%%% Total number of pores
 GUI2;
 waitfor(GUI2);
