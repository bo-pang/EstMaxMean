function MSE_CP(num)
% Compare mse performance of different estimator

BaseMu=5;
MaxDiff=10;
DiffStep=0.1;
Rept=2000;
var1=10^(0.5);
var2=var1;

i=1;
for Diff=0:DiffStep:MaxDiff
    fprintf(1,'Diff: %.2f\n', Diff);
    mseWE(i)=0;mseME(i)=0;mseEME(i)=0;mseAE(i)=0;
    for j=1:Rept
        [WE,ME,~,~]=WEandME(BaseMu,BaseMu+Diff,var1,var2);
        AE=AbsEst(BaseMu,BaseMu+Diff,var1,var2,1);
        EME=ExpMaxEst(BaseMu,BaseMu+Diff,var1,var2);
        mseWE(i,j)=(WE-BaseMu-Diff)^2;
        mseME(i,j)=(ME-BaseMu-Diff)^2;
        mseEME(i,j)=(EME-BaseMu-Diff)^2;
        mseAE(i,j)=(AE-BaseMu-Diff)^2;
    end
    
    FinalmseWE(i)=sum(mseWE(i,:))/Rept;stdWE=std(mseWE,0,2)';
    
    FinalmseME(i)=sum(mseME(i,:))/Rept;stdME=std(mseME,0,2)';
    
    FinalmseAE(i)=sum(mseAE(i,:))/Rept;stdAE=std(mseAE,0,2)';

    FinalmseEME(i)=sum(mseEME(i,:))/Rept;stdEME=std(mseEME,0,2)';
    
    i=i+1;
    
end

figure(1);
plot(0:DiffStep:MaxDiff,FinalmseWE,'r');hold on;
plot(0:DiffStep:MaxDiff,FinalmseME,'b');hold on;
plot(0:DiffStep:MaxDiff,FinalmseAE,'g');hold on;
plot(0:DiffStep:MaxDiff,FinalmseEME,'m');

legend('WE','ME','AE','EME');
saveas(gcf,['.\Trial' num2str(num) '-1.fig']);

figure(2);
errorbar(0:DiffStep:MaxDiff,FinalmseWE,stdWE,'r');hold on;
errorbar(0:DiffStep:MaxDiff,FinalmseME,stdME,'b');hold on;
errorbar(0:DiffStep:MaxDiff,FinalmseAE,stdAE,'g');hold on;
errorbar(0:DiffStep:MaxDiff,FinalmseEME,stdEME,'m');
legend('WE','ME','AE','EME');
saveas(gcf,['.\Trial' num2str(num) '-2.fig']);

save(['.\Trial' num2str(num) '.mat'],'-v7');


end