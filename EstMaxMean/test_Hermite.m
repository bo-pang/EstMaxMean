function [Bias1,Bias2,Var1,Var2]=test_Hermite(k)
% This function aims to test the performance of Hermite Polynomial as estimation of higher moments 

Loop=100;
N=100;
mu=0;
Est1=zeros(Loop,N);
Est2=Est1;

tmp=load('.\HermitePolyCoeff.mat');
Hermite=tmp.b;
[~,HermiteKmax]=size(Hermite);
if HermiteKmax<2*k
    error('Too Large k!!');
end

for i=1:Loop
    X=normrnd(mu,1,1,N);
    for j=1:N
        Est1(i,j)=2^(-k)*Cal_Hermite_Value(Hermite{2*k+1},X(j)/2^(1/2)); % Change first version of Hermite Polynomial into secound version 
    end
    Est2(i,:)=2^(-k).*hermite(2*k,X./2^(0.5));
end

% Calculate Bias

mean1=sum(sum(Est1))/(Loop*N);
mean2=sum(sum(Est2))/(Loop*N);

Bias1=mean1-mu^(2*k);
Bias2=mean2-mu^(2*k);

% Calculate Variance

Var1=0;Var2=0;
for i=1:Loop
    for j=1:N
        Var1=Var1+(Est1(i,j)-mean1)^2;
        Var2=Var2+(Est2(i,j)-mean2)^2;
    end
end
Var1=Var1/(Loop*N);
Var2=Var2/(Loop*N);

end