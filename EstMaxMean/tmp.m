function [mseW,VarW,BiasW,mse1,Var1,Bias1,mse2,Var2,Bias2]=tmp(Weight)
% % Calculate value of two terms in upper bounds given in Cai's paper 
%     K=log(n)/(2*log(log(n)));
%     Term1=0.28^2*M^2/(2*K)^2;
%     Term2=2*exp(M^2)*2^(8*K)*K^(2*K)/n;
Rept=100000;

mu1=5;var1=10^(1/2);
mu2=5;var2=10^(1/2);

for i=1:Rept
    data1=mean(normrnd(mu1,var1,1,1));
    data2=mean(normrnd(mu2,var2,1,1));
    x=Weight*[data1 data2]';
    mseW(i)=(x-mu1)^2;
    VarW(i)=(x^2-mu1^2);
    BiasW(i)=(x-mu1);
    mse1(i)=(data1-mu1)^2;
    Var1(i)=(data1^2-mu1^2);
    Bias1(i)=data1-mu1;
    mse2(i)=(data2-mu1)^2;
    Var2(i)=(data2^2-mu1^2);
    Bias2(i)=data2-mu1;
end

mseW=sum(mseW)/Rept;
VarW=sum(VarW)/Rept;
BiasW=sum(BiasW)/Rept;
mse1=sum(mse1)/Rept;
Var1=sum(Var1)/Rept;
Bias1=sum(Bias1)/Rept;
mse2=sum(mse2)/Rept;
Var2=sum(Var2)/Rept;
Bias2=sum(Bias2)/Rept;

end