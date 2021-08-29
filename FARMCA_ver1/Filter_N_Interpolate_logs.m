%function [RHO,GR,depth]=Filter_N_Interpolate_logs(depth,startdepth,stopdepth,RHO, RHOmax, RHOmin, GR, GMA_high, a )
function [logs]=Filter_N_Interpolate_logs(logs, depth, RHO, GR, a )

indx_interest_zone=find(logs.Depth <depth.start|logs.Depth>depth.stop);
logs.Depth(indx_interest_zone)=[];       
logs.RHO(indx_interest_zone)=[];     
logs.GR(indx_interest_zone)=[];

%remove high values
indx_high=find(logs.RHO>=RHO.max|   logs.GR>=GR.high|logs.RHO<RHO.min); %very high and very low values of density are removed to avoid verylow and very high porosity

logs.RHO(indx_high)=[];      
logs.Depth(indx_high)=[];    
logs.GR(indx_high)=[];

curves=[logs.RHO logs.GR];
interpolcurves=zeros(size(curves));

for i=1:2;
    curve1 = curves(:,i);
    index=find(curve1~=a);
    idx=find(diff(index)>1);
    nidx=length(idx);
    for ii=1:nidx
        ia=index(idx(ii));
        ie=index(idx(ii)+1);
        curve1(ia+1:ie-1)=interp1q(depth([ia,ie]),curve1([ia,ie]),depth(ia+1:ie-1));
    end
    interpolcurves(:,i)=curve1;
end

logs.RHO=single(interpolcurves(:,1));
logs.GR=single(interpolcurves(:,2));

end
