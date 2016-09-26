function p=Pareto(x,xm,K)

if x>xm || x==xm
    p=K*xm^K/x^(K+1);
else
    p=0;
end

end