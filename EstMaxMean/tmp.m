function [Term1,Term2]=tmp(M,n)
% Calculate value of two terms in upper bounds given in Cai's paper 
    K=log(n)/(2*log(log(n)));
    Term1=0.28^2*M^2/(2*K)^2;
    Term2=2*exp(M^2)*2^(8*K)*K^(2*K)/n;
end