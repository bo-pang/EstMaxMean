function MSE=BayesianEst(a,mu,var)
N=1;
Rept=3000;
MSE=0;

for i=1:Rept
   x=normrnd(mu,var,1,N);
   % Posterior
   muP=sum(x)/(var^2/a^2+N);
   varP=(1/(1/a^2+N/var^2))^(0.5);
   % Expectation of |\mu| with respect to posterior distribution
   fun=@(y,Mu,Var) abs(y).*GaussianFunc(Mu,Var,y);
   AbsMu=integral(@(y)fun(y,muP,varP),-Inf,Inf);
   
   MSE=MSE+(AbsMu-abs(mu))^2;
end

MSE=MSE/Rept;

end