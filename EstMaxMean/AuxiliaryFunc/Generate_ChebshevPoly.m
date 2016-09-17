function Generate_ChebshevPoly(Kmax)
% Generate the coefficients of Chebyshev Polynomial in form
% G_K(x)=sum_{i=0}{K}g_i*x^i, where i=even integer.
% For each K, the coefficeints are arranged as a column vector
% All the coefficients of Ks are stored in cell S
for K=1:Kmax
    R=zeros(K+1);
    R(1,1)=1*2/pi;
    for k=1:K
        CoefVec=zeros(1,K+1);
        for j=0:k
            CoefVec(k+1-j)=(-1)^j*(2*k)/(2*k-j)*nchoosek(2*k-j,j)*2^(2*k-2*j-1);
        end
        CoefVec=(-1)^(k+1)/(4*k^2-1)*4/pi*CoefVec;
        R(k+1,:)=CoefVec;
    end
    S(K)={sum(R)'};
end

save('.\ChebyshevPolyCoeff','-v7','S');

end