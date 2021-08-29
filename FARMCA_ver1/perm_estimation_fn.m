function [Dtcalc,K,n_elem_bin_series2,KF, lambda,tau]= perm_estimation_fn(index, N_run,  Nt, Area, Df,  KB, LBD, BI, K,K1, cp)
G=pi/128;
Dtmat=single(zeros(N_run,length(BI.PHI_U1)));
t=(0.67)./BI.PHI_U1;
for runs=1:N_run
    for j=index' %1:length(BI.PHI_U1);
        ktest=KB.max+2;
        while ktest<KB.min||ktest>KB.max
            % The execution of MC algorithm
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            flag=1;
            while flag
                clear   lambda
                lambda_rand = rand(round(Nt(j)),1).* (  1 - LBD.ratio(j).^Df(j) );   % Constrain random no  to a range of lambda
                lambda = LBD.ratio(j)*(LBD.max(j)./(1-lambda_rand).^(1/Df(j)));      % Generate the lambda
                cum_Aj=  (pi/4)*cumsum(lambda.^2)./BI.PHI_U1(j);                     % Generate area
                
                check=( cum_Aj /Area(j) )>=1;                                        % To check if any cumulavie sum is less than Area, if yes then continue
                if any(check);                                                          % Check if any Aj> Area is found in cumsum matrix
                    id=find(check==1,1);                                             % find first occurance of 1 in the check vector
                    flag=~(  (  min(lambda(1:id))/max(lambda(1:id))  )<LBD.Ratio_check(j)   );
                end
            end
            LMratio_sim=min(lambda(1:id))/max(lambda(1:id)) ;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            av_diameter= Df(j)*  min(lambda(1:id))/ (Df(j) - 1)*(1- LMratio_sim^(Df(j)-1));
            Lo=sqrt(cum_Aj(id));
            
            Dt=1+(log(t(j))/log(Lo/av_diameter));
            S=sum(lambda(1:id).^(3+Dt));
            ktest=G*( (cum_Aj(id))^(-(1+Dt)/2))*S*(1/0.98692)*10^15;               %in mdarcy
        end
        K(runs,j)=ktest;   %check
        Dtmat(runs,j)=Dt;
    end
end

Dtcalc=mean(Dtmat);
if isempty(K1) 
     K1.LogKbin_mean=0;
     K1.err=0;
     K1.UB=0;
     K1.LB=0;
     K1.median=0;
end
[n_elem_bin_series2,  KTEMP.LogKbin_mean, KTEMP.err, KTEMP.UB, KTEMP.LB, KTEMP.median, tau]=... 
                                      fn_corr_time2(K,cp);
KF.LogKbin_mean = KTEMP.LogKbin_mean + K1.LogKbin_mean;
KF.err =KTEMP.err + K1.err;
KF.UB = KTEMP.UB + K1.UB;
KF.LB = KTEMP.LB + K1.LB;
KF.median = KTEMP.median + K1.median;
end

