    function sum=Cal_Hermite_Value(Coef,X)
        [~,P]=size(Coef);
        sum=0;
        for l=1:P
            sum=sum+Coef(l)*X^(P-l);
        end
    end