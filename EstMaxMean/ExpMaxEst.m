function EMEMaxMean=ExpMaxEst(mu1,mu2,var1,var2)

N=1;
K=2;
M=2000;

% True Distribution and generate sample

TrueDis=NormStru();
TrueDis.mu=[mu1 mu2]';
TrueDis.var=[var1 var2]';   % standard deviation
% rng(2);

for i=1:K
%     rng(i);
    TrueDis.data(i,:)=TrueDis.normdis(TrueDis.mu(i),TrueDis.var(i),1,N);
end

% Intermediary Distribution 
EstDis=NormStru();
EstDis.mu=mean(TrueDis.data,2);
EstDis.var=TrueDis.var./3;
EstDis.prob=zeros(K,1);

for i=1:M
    for j=1:K
        EstDis.data(j,i)=EstDis.normdis(EstDis.mu(j),EstDis.var(j),1,1);
    end
    MaxValue(i)=max(EstDis.data(:,i));
%     [~, MaxIndex]=max(EstDis.data(:,i));
%     EstDis.prob(MaxIndex)=EstDis.prob(MaxIndex)+1;
end

% EstDis.prob=EstDis.prob/M;

% Use weighted sum to estimate the max mean

% WEMaxMean=EstDis.mu'*EstDis.prob;
% MEMaxMean=max(EstDis.mu);
EMEMaxMean=mean(MaxValue);

% Prob1=EstDis.prob(1);
% Prob2=EstDis.prob(2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function s=NormStru()
    s=struct();
    s.mu=[];
    s.var=[];
    s.data=[];
    s.prob=[];
    
    s.normdis=@(Mu,Var,m,n) normrnd(Mu,Var,m,n);
end

end