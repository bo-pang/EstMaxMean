function Generate_HermitePoly(Kmax)

for i=1:Kmax
    fprintf(1,'K=%d\n',i);
    S(i)={hermite(i)};
end

save('.\HermitePolyCoeff.mat','-v7','S');

end