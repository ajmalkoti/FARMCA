
function varargout = merror(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @merror_OpeningFcn, ...
    'gui_OutputFcn',  @merror_OutputFcn, ...
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

function merror_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = merror_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

function edit4_Callback(hObject, eventdata, handles)
a= get(hObject,'String');
handles.edit4=str2double(a);
guidata(hObject,handles);

function edit4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit5_Callback(hObject, eventdata, handles)
b= get(hObject,'String');
handles.edit5=str2double(b);
guidata(hObject,handles);

function edit5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit6_Callback(hObject, eventdata, handles)
c= get(hObject,'String');
handles.edit6=str2double(c);
guidata(hObject,handles);

function edit6_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit7_Callback(hObject, eventdata, handles)
d= get(hObject,'String');
handles.edit7=str2double(d);
guidata(hObject,handles);

function edit7_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit8_Callback(hObject, eventdata, handles)
e= get(hObject,'String');
handles.edit8=str2double(e);
guidata(hObject,handles);

function edit8_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton1_Callback(hObject, eventdata, handles)
disp('processing...  ')
tic
N_run=single(handles.edit4);
error_limit=single(handles.edit5);
cp=single(handles.edit6);
KB.min=single(handles.edit7);
KB.max=single(handles.edit8);
global BI Nt Area Df LBD
PHI_U1_max=max(BI.PHI_U1);            % the maximum useful porosity is considered for error analysis
i=find(BI.PHI_U1==PHI_U1_max,1);
% PHI_U1_min=min(BI.PHI_U1);              % the minimum useful porosity is considered for error analysis
% i=find(BI.PHI_U1==PHI_U1_min,1);

flag=0;

temp_i=1;
while flag==0
    N_run= N_run*2^(temp_i-1);
    disp(N_run)
    for iter=1:3
        rng('shuffle')        %        rng_seed=rng;
        K=zeros(N_run,length(BI.PHI_U1));
        
        [Dt1, K,  N_bin_series,K1,simulated_LBD, tau]=...
            perm_estimation_fn(i, N_run,  Nt, Area, Df,  KB, LBD, BI,K,[],cp);
        err_round = round(K1.err(:,i),2);  %error is rounded to two decimal places
        if err_round(cp)<error_limit
            flag=issorted(err_round(1:cp));
            if flag==1
                break
            end
        end
    end
    temp_i=2;
end
disp('Total time for testing is : ')
toc
disp('Running... ')
sim_LBD=simulated_LBD*10^6; % simulated pore dia meters in micrometers
fileID = fopen('OUTPUT/PERMEABILITY/AW_max_phi_lambda.txt','w');
fprintf(fileID,'%25s \n', 'LBD_sim_maxphi(micro m)');
for jj=1:length(sim_LBD)
    fprintf(fileID, '%16.10f \n', sim_LBD(jj));
end
fclose(fileID);




%##################################
figure(2);
subplot(2,1,1); plot(N_bin_series,round(K1.err(:,i),2));
xlabel('number of runs');   ylabel('standard error');           title('variation of error with number of runs');
subplot(2,1,2); plot(N_bin_series,tau(:,i));
xlabel('number of runs');   ylabel('tau');


a1=min(simulated_LBD*10^6);
a2=max(simulated_LBD*10^6);
a=a1:0.1:a2;

NLM=zeros(length(a),1);
for l=1:length(a)
    n=find(simulated_LBD*10^6>=a(l));
    N=length(n);
    NLM(l,1)=N;
end
poredia_powerlaw=[a' NLM];


X=log(a'); Y=log(NLM);
X1=X; Y1=Y;
n=find(diff(Y1)==0); X1(n)=[]; Y1(n)=[];
C=polyfit(X1,Y1,1); Y1=polyval(C,X1);

figure (3);
plot(X,Y,'b*',X1,Y1,'r-')
xlabel('ln(lamda)')
ylabel('ln(N)')
annotation('textbox', [.4 .4 .1 .1], 'String', ...
    ['Df=',num2str(abs(C(1)))]);
title('power law distribution of pore diameters')

pause(1);

%################################## Full Run #################################


global radius
radius.eff=round(radius.eff*10^3,3); %(effective radius is converted to mm and rounded to 3 decimal places)
LBD.max=(round(LBD.max*10^8))/(10^8); %(LBD.max is rounded to 3 decimal places and converted to um)
[temp,index1,index2] = unique(LBD.max);% to save time the program runs for unique LBD.max
[Dt, K,  N_bin_series,   K1,   simulated_LBD, tau] = perm_estimation_fn(index1(1:end-1), N_run,  Nt, Area, Df,  KB, LBD, BI,K,[],cp);
disp('Total time for Full Run is : ')
toc
disp('saving output files : ')

%%%%%%%%% Fill duplicated coloumns
Dt= Dt+Dt1;
for i=1:length(temp)
    index1=find(temp(i)==radius.eff);
    for j=index1'
        K1.LogKbin_mean(:,j)=K1.LogKbin_mean(:,index1(1));
        K1.err(:,j)=K1.err(:,index1(1));
        K1.UB(:,j)=K1.UB(:,index1(1));
        K1.LB(:,j)=K1.LB(:,index1(1));
        K1.median(:,j)=K1.median(:,index1(1));
        Dt(j)=Dt(index1(1));
    end
end

fileID = fopen('OUTPUT/PERMEABILITY/AW_simulated_K.txt','w');
fprintf(fileID,'%5s \n', 'K_sim');
for ii=1:size(K,1)
    for ij=1:length(BI.PHI_U1)
        fprintf(fileID, '%7.0f ', K(ii,ij));
    end
    fprintf(fileID, '\n');
end
fclose(fileID);


fileID = fopen('OUTPUT/PERMEABILITY/AW_err.txt','w');
fprintf(fileID,'%4s \n', 'K1.err');
for iii=1:size(K1.err,1)
    for ijj=1:length(BI.PHI_U1)
        fprintf(fileID, '%10.2f ', K1.err(iii,ijj));
    end
    fprintf(fileID, '\n');
end
fclose(fileID);

figure(4)
histfit(K(:,i));
xlabel('permeability');
ylabel('frequency');

PHI_K=[BI.Depth BI.PHI_U1 K1.median' radius.eff];
PHI_fDim=[BI.Depth BI.PHI_U1 BI.VSH BI.VSST K1.median' K1.UB' K1.LB' radius.eff Df Dt' LBD.ratio];

fileID = fopen('OUTPUT/PERMEABILITY/phi_perm_fract_dims_AW.txt','w');
fprintf(fileID,'%10s %10s %10s %10s %10s %10s %10s %10s %10s %10s %16s \n', 'BI.Depth', 'BI.PHI_U1', 'BI.VSH', 'BI.VSST', 'K1.median', 'K1.UB', 'K1.LB', 'radius.eff', 'Df', 'Dt', 'LBD.ratio');
for jp=1:length(BI.Depth)
    fprintf(fileID, '%10.5f %10.2f %10.2f %10.2f %10.0f %10.0f %10.0f %10.3f %10.2f %10.2f %16.8f \n', ...
        BI.Depth(jp), BI.PHI_U1(jp), BI.VSH(jp), BI.VSST(jp), K1.median(jp), K1.UB(jp), K1.LB(jp), radius.eff(jp), Df(jp), Dt(jp), LBD.ratio(jp));
end
fclose(fileID);


global BL2 BL
BI_perm_stats=zeros(length(BL2.Depth),5);
global index



for ik=1:length(K1.median)
    BI_perm_stats(index(ik),1)=K1.median(ik);
    BI_perm_stats(index(ik),5)=radius.eff(ik);
    BI_perm_stats(index(ik),2)= K1.UB(ik);
    BI_perm_stats(index(ik),3)=K1.LB(ik);
    BI_perm_stats(index(ik),4)=K1.err(1,ik);
end

Kcalc=BI_perm_stats(:,1);
Reff=BI_perm_stats(:,5);
KUBound=BI_perm_stats(:,2);
KLBound=BI_perm_stats(:,3);
error=BI_perm_stats(:,4);
PHI_K_stats=[BL2.Depth BL2.PHI_U1 Reff Kcalc error KUBound KLBound];

fileID = fopen('OUTPUT/PERMEABILITY/zone_permeabilityAW.txt','w');
fprintf(fileID,'%10s %10s %10s %10s %10s %10s %10s \n','BL2.Depth','BL2.PHI_U1','Reff','Kcalc','error','KUBound','KLBound');
for jz=1:length(BL2.Depth)
    fprintf(fileID, '%10.5f %10.2f %10.3f %10.0f %10.2f %10.0f %10.0f \n', ...  %%%modified
        BL2.Depth(jz), BL2.PHI_U1(jz), Reff(jz), Kcalc(jz), error(jz), KUBound(jz), KLBound(jz));
end
fclose(fileID);


[Klog_interpolated]=create_perm_log(BL.Depth,BL2.Depth,Kcalc);

BL.K=Klog_interpolated(:,2);


fileID = fopen('OUTPUT/PERMEABILITY/permeability_blockedlogAW.txt','w');
fprintf(fileID,'%10s %10s \n', 'BL.Depth', 'BL.K');
for jb=1:length(BL.Depth)
    fprintf(fileID, '%10.5f \t %10.0f \t \n', BL.Depth(jb), BL.K(jb));
end
fclose(fileID);

figure (5)
subplot(1,2,1);
plot(flipud(BL.PHI_U1*100),flipud(BL.Depth),'k-','Linewidth',2);
set(gca,'ydir','reverse')
title('useful porosity (%)')

subplot(1,2,2);
plot(flipud(BL.K),flipud(BL.Depth),'k-','Linewidth',2);
set(gca,'ydir','reverse')
title('permeability (mD)')


global phishale
IA1=find(BL2.PHI_U1>phishale);

Kcalc1=Kcalc(IA1);
KUBound1=KUBound(IA1);
KLBound1=KLBound(IA1);


BL2.PHI_U=BL2.PHI_U1(IA1);

[BL2.PHI_U2,IA,IC]=unique(BL2.PHI_U,'first');

Kcalc2=Kcalc1(IA);
KUBound2=KUBound1(IA);
KLBound2=KLBound1(IA);

figure(6);
h=plot(BL2.PHI_U2*100,Kcalc2,'k.',BL2.PHI_U2*100,KUBound2,'r-',BL2.PHI_U2*100,KLBound2,'b-');
hold on
plot(BL2.PHI_U*100,Kcalc1,'k.')%%%modified

xlabel('useful porosity (%)');      ylabel('permeability (mD)');     title('Useful porosity versus permeability')
legend(h,{'median','first quartile','third quartile'});


figure(7)
plot(radius.eff,Kcalc1,'b*')
xlabel('grain radius (mm)')
ylabel('permeability (mD)')
title('grain radius versus permeability')


%Figure 8
figure(8)
plot(LBD.max*10^6, Kcalc1,'b*');
xlabel('max. pore diameter (um)')
ylabel('permeability (mD)')

for jf=1:8
    n=8-jf+1;
    h=figure(n);
    saveas(gcf,['OUTPUT/FIGURES/figure',num2str(n)],'fig')
    saveas(gcf,['OUTPUT/FIGURES/figure',num2str(n)],'jpg')
    close(gcf)
end

disp('Completed Successfully')
close(merror)
