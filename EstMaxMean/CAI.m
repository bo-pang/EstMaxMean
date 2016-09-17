function EstAbsMu=CAI(X,K)

[n,~]=size(X);

% Obtain Chebyshev polynomials coefficients of 2K degree as nearly optimal polynomial approximation

tmp=load('.\ChebyshevPolyCoeff.mat');
Cheby=tmp.S;
[~,ChebyKmax]=size(Cheby);
if ChebyKmax<K
    fprintf('Too Large K!!');
else
    ChebyCoeff=Cheby{K};
end

% Obtain Hermite polynomials coefficients

tmp=load('.\HermitePolyCoeff.mat');
Hermite=tmp.b;
[~,HermiteKmax]=size(Hermite);
if HermiteKmax<2*K
    error('Too Large K!!');
end

% %Test Estimation of Abs Function
% abs_X=0;
% 
% for k=0:K
%     abs_X=abs_X+ChebyCoeff(k+1)*X^(2*k);
% end
% 
% EstAbsMu=abs_X;

H=zeros(1,K+1);
for k=0:K
   for i=1:n
       H(k+1)=2^(-k)*Cal_Hermite_Value(Hermite{2*k+1},X(i)/2^(1/2))+H(k+1); % Change first version of Hermite Polynomial into secound version 
   end
end
H=H./n;

EstAbsMu=H*ChebyCoeff;

end