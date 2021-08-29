function [Nt, Df, dclay, Area, index, radius,LBD, BL2 ]=find_parameters_fractal(phishale,BL,dclay,rad_opt)
% to estimate permeability
% relative particle size

phi_U1_max=max(BL.PHI_U1); %highest useful porosity refers to pure sand interval
index=single(find(BL.PHI_U1>=phishale)); %program will run for these indices


BL2.PHI_U1=BL.PHI_U1(index);


BL2.VSST=BL.VSST(index);


BL2.VSH=BL.VSH(index);

%Mdepth2=BL.Depth(index);
BL2.Depth=BL.Depth(index);

dclay=dclay*10^-6; %minimum particle diameter converted to m

if (rad_opt<=0) 
    Kgess=(191*(10*phi_U1_max )^10)/(10^18);
    T2=(0.67/phi_U1_max)^2;     %tortuosity^2 of pure sand layer
    radius.sand=(sqrt(72*T2*Kgess)/2)*((1-phi_U1_max )/(phi_U1_max)^(3/2)); %sand grain radius in m
else
    radius.sand=rad_opt*10^-6; %the input value of sand grain radius is converted to m
end
radius.eff=((dclay/2)*BL2.VSH + radius.sand*BL2.VSST)./(BL2.VSH+BL2.VSST); %effective grain radius of shaly sand interval

d=2*radius.eff/dclay;

Area=(1/2)*pi*(radius.eff.^2).*(1./(1-BL2.PHI_U1));
Lo=sqrt(Area);                                  %Representative length of cubic cell,
LBD.max=(radius.eff/2).*(sqrt(2*((1./(1-BL2.PHI_U1))-1))+(sqrt((2*pi/sqrt(3))*(1./(1-BL2.PHI_U1)))-2));
LBD.ratio=((sqrt(2)./d).*(sqrt((1-BL2.PHI_U1))));
LBD.min=LBD.ratio.*LBD.max;


% to estimate Df from the formula
Df=2-(log(BL2.PHI_U1)./log(LBD.min./LBD.max));

Nt=(1./LBD.ratio).^Df;


LBD.Ratio_check= single(zeros(size(LBD.ratio)));
LBD.Ratio_check(LBD.ratio<10^-2) = .010;
idx=find(LBD.ratio>=10^-2);
LBD.Ratio_check(idx) = LBD.ratio(idx) * 1.1;


end
