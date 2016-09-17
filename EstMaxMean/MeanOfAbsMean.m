function mse=MeanOfAbsMean()
% This code estimates T(\theta)=\frac{1}{n}\sum_{i=1}
%^{n}|\mu_i|

n=9;
mu=[0.1 0.9 0.3 -0.3 -0.8 0.9 0.6 0.5 0.3];
var=[1 1 1 1 1 1 1 1 1];
TrueAbsMuMean=sum(abs(mu))/n;
N=1000;
K=ceil(log(n)/(2*log(log(n))));
Repeat=1000;
mse=0;

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

for r=1:Repeat

    for i=1:n
        x(i,:)=normrnd(mu(i),var(i),1,N);
    end

    H=zeros(n,K+1);
    for k=0:K
        for i=1:n
            for j=1:N
                H(i,k+1)=H(i,k+1)+2^(-k)*Cal_Hermite_Value(Hermite{2*k+1},x(i,j)/2^(0.5));
            end
            H(i,k+1)=H(i,k+1)/N;
        end
        B(k+1)=sum(H(:,k+1))/n;
    end

    EstMeanOfAbsMean(r)=B*ChebyCoeff;
    mse=mse+(EstMeanOfAbsMean(r)-TrueAbsMuMean)^2;

end

mse=mse/Repeat;

end