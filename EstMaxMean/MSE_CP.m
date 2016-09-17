function MSE_CP(num)
% Compare mse performance of different estimator

BaseMu=-1;
MaxDiff=2;
DiffStep=0.05;
Rept=2000;
var1=1;
var2=var1;

i=1;
for Diff=0:DiffStep:MaxDiff
    fprintf(1,'Diff: %.2f\n', Diff);
    mseWE(i)=0;mseME(i)=0;mseAE(i)=0;
    for j=1:Rept
        [WE,ME,~,~]=WEandME(BaseMu,BaseMu+Diff,var1,var2);
        AE(i,j)=AbsEst(BaseMu,BaseMu+Diff,var1,var2,1);
        mseWE(i)=(WE-BaseMu-Diff)^2+mseWE(i);
        mseME(i)=(ME-BaseMu-Diff)^2+mseME(i);
        mseAE(i)=(AE(i,j)-BaseMu-Diff)^2+mseAE(i);
    end
    mseWE(i)=mseWE(i)/Rept;
    mseME(i)=mseME(i)/Rept;
    mseAE(i)=mseAE(i)/Rept;
    i=i+1;
end

plot(0:DiffStep:MaxDiff,mseWE,'r');hold on;
plot(0:DiffStep:MaxDiff,mseME,'b');hold on;
plot(0:DiffStep:MaxDiff,mseAE,'g');
legend('WE','ME','AE');

save(['.\Trial' num2str(num) '.mat'],'-v7');
saveas(gcf,['.\Trial' num2str(num) '.fig']);

end