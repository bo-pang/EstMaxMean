function [y]=GaussianFunc(mu,var,x)

[m,n]=size(x);
for i=1:m
    for j=1:n
        y(i,j)=1/(2*var^2*pi)^(1/2)*exp(-(x(i,j)-mu)^2/(2*var^2));
    end
end

end