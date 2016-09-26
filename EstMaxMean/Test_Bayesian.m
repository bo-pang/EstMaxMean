function Test_Bayesian(a,num)
i=1;
var=1;
lb=-20;ub=20;step=0.1;
for mu=lb:step:ub
    MSE(i)=BayesianEst(a,mu,var);
    i=i+1;
end
figure(num);
plot(lb:step:ub,MSE);
title(['MSE of Different mu with var/a=',num2str(var/a)]);
xlabel('\mu');ylabel('MSE');
end