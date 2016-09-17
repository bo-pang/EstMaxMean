function EstMaxMu=AbsEst(mu1,mu2,var1,var2,K)
N=100;
X1=normrnd(mu1,var1,N,1);
X2=normrnd(mu2,var2,N,1);
EstAbsMu=CAI(X1-X2,K);

EstMaxMu=(mean(X1)+mean(X2)+EstAbsMu)/2;
end