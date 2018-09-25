
function [blocked_logs,B] =blocked(PHI, vol, logs, GR)

% blocking of porosity logs
A=[PHI.PHI PHI.phic PHI.U vol.sand vol.shale];
A=round(A*100)./100;

logs.GR=round(logs.GR);
n1=find(logs.GR<GR.sand_max);

n2=find(logs.GR>=GR.sand_max&logs.GR<=GR.shale_min);
n3=find(logs.GR>GR.shale_min);

idx1=find(diff(n1)>1);
idx2=find(diff(n2)>1);
idx3=find(diff(n3)>1);


B=zeros(size(A,1),size(A,2));
%%%%%%%%%%
l=1;
if isempty(idx1)==1
    idx1=n1(end);
    jrange=[1;idx1+1];
else
    jrange=[1;idx1+1];
    idx1=[idx1;idx1(end)+(size(n1,1)-idx1(end))];
end

for j1=1:size(idx1,1)
    j=jrange(l);
    idx1(j1);
    c=A(n1(j):n1(idx1(j1)),:);
    if size(c,1)==1
        c1=c;
    else
        c1=mean(c);
    end
    
    n1(j);
    n1(idx1(j1));
    B(n1(j):n1(idx1(j1)),:)=repmat(c1,size(c,1),1);
    
    l=l+1;
end

%%%%%%%%%%%%%%
l=1;
if isempty(idx2)==1
    idx2=n2(end);
    jrange=[1;idx2+1];
else
    jrange=[1;idx2+1];
    idx2=[idx2;idx2(end)+(size(n2,1)-idx2(end))];
end

for j1=1:size(idx2,1)
    j=jrange(l);
    c=A(n2(j):n2(idx2(j1)),:);
    if size(c,1)==1
        c1=c;
    else
        c1=mean(c);
    end
    
    B(n2(j):n2(idx2(j1)),:)=repmat(c1,size(c,1),1);
    l=l+1;
end
%%%%%%%%%%%%
l=1;
if isempty(idx3)==1
    idx3=n3(end);
    jrange=[1;idx3+1];
else
    jrange=[1;idx3+1];
    idx3=[idx3;idx3(end)+(size(n3,1)-idx3(end))];
end
for j1=1:size(idx3,1)
    j=jrange(l);
    c=A(n3(j):n3(idx3(j1)),:);
    if size(c,1)==1
        c1=c;
    else
        c1=mean(c);
    end
    
    B(n3(j):n3(idx3(j1)),:)=repmat(c1,size(c,1),1);
    
    l=l+1;
end
%%%%%%%%

B=round(B*100)./100;
B=single(B);

blocked_logs.PHI_e=B(:,1);
blocked_logs.PHI_c=B(:,2);
blocked_logs.PHI_U1=B(:,3);
blocked_logs.VSST=B(:,4);
blocked_logs.VSH=B(:,5);

blocked_logs.Depth=logs.Depth ;

end