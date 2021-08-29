%function [PHI_T, PHI, phic, PHI_U ,vsand, vol.shale]=Find_Parameters(depth,GR,max_GMAsand,RHO,min_GMAshale,RHOm,RHOf)
function [PHI,vol]=Find_Parameters1(logs,GR,RHO,Ldepth)
PHI.PHI=single(zeros(length(logs.Depth),1));
GMA1=round(logs.GR);

indx_interest_zone=find(GMA1<GR.sand_max);
n1=find(GMA1>=GR.shale_min);

%estimation of porosity
num1=find(logs.Depth<Ldepth.bottomSST&logs.Depth>Ldepth.topSST);
num2=find(logs.Depth<Ldepth.bottomSh&logs.Depth>Ldepth.topSh);


%to estimate the average density of pure sand interval
RHO_clean=mean(logs.RHO(num1));

%to estimate the average density of pure shale interval
RHO_shale=mean(logs.RHO(num2));


%estimate effective porosity
for i=1:length(PHI.PHI)
    if GMA1(i)<GR.sand_max
        PHI.PHI(i)=(logs.RHO(i)-RHO.m)/(RHO.f-RHO.m);      %porosity of pure sand layer
    else
        GMA1(indx_interest_zone)=GR.sand_max;
        GMA1(n1)= GR.shale_min;
        
        I=(GMA1- GR.sand_max)/(GR.shale_min - GR.sand_max);             %Shale volume calculated from Gamma-ray log
        vol.shale=0.083*(2.^(3.7* I)-1);                           %Dresser tertiary rock equation
        
        logs.RHO(i) = RHO_clean*(1-vol.shale(i))+RHO_shale*vol.shale(i);          %In case of shaly sand stone layers Bulk density is corrected for shale volume
        PHI.PHI(i)=(logs.RHO(i)-RHO.m)/(RHO.f-RHO.m);           %effective porosity of shaly sand stone
    end
end
vol.sand=1-PHI.PHI-vol.shale;

indx_interest_zone=find(vol.sand<0);
vol.sand(indx_interest_zone)=0;

C=(vol.shale./(vol.shale+vol.sand));
PHI.phic=PHI.PHI .*C;                               %critical porosity
PHI.U=PHI.PHI -PHI.phic;                            %useful porosity
% 
% phisand=vol.sand.*(PHI.PHI ./(1-PHI.PHI));
% phish=vol.shale.*(PHI.PHI ./(1-PHI.PHI));
% PHI.T=phisand+phish;                         %total porosity

end