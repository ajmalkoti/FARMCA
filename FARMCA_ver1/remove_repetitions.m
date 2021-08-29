%function [Mdepth1, phiU1, vsand1, Vsh1,philog_mfd]= remove_repeatations(phiU1,depth,B)
function [BL2]= remove_repetitions(BL)
BL2=BL;
for i=1:length(BL.PHI_U1)-1
    if BL.PHI_U1(i)==BL.PHI_U1(i+1)
        BL2.Depth(i+1)=0;
        %  vsand1(i+1)=0;
        %    Vsh1(i+1)=0;
    end
end
indx_interest_zone=find(BL2.Depth==0);
BL2.Depth(indx_interest_zone)=[];
BL2.PHI_U1(indx_interest_zone)=[];
BL2.VSST(indx_interest_zone)=[];
BL2.VSH(indx_interest_zone)=[];
BL2.PHI_e(indx_interest_zone)=[];
BL2.PHI_c(indx_interest_zone)=[];
%perm=zeros(size(phiU1,1),1);
%grainsize=zeros(size(phiU1,1),1);
%Ubound=zeros(size(phiU1,1),1);
%Lbound=zeros(size(phiU1,1),1);
%error=zeros(size(phiU1,1),1);
%philog_mfd=[Depth1 phiU1 VSST Vsh1 grainsize perm Ubound Lbound error];
end
