function [WEMaxMean,MEMaxMean,Prob1,Prob2]=WEandME(mu1,mu2,var1,var2)

N=100;
K=2;
M=2000;

% if draw the picture
ifdraw=0;

% True Distribution and generate sample

TrueDis=NormStru();
TrueDis.mu=[mu1 mu2]';
TrueDis.var=[var1 var2]';   % standard deviation
% rng(2);

for i=1:K
%     rng(i);
    TrueDis.data(i,:)=TrueDis.normdis(TrueDis.mu(i),TrueDis.var(i),1,N);
end

% weight=1/sqrt(2*var2^2*pi)*exp(-(TrueDis.data(2,1)-TrueDis.mu(2))^2/(2*var2^2));
% Intermediary Distribution and Estimation of the probability that some
% mean is larger than other ones.

EstDis=NormStru();
EstDis.mu=mean(TrueDis.data,2);
EstDis.var=TrueDis.var./N^(1/2);
EstDis.prob=zeros(K,1);

for i=1:M
    for j=1:K
        EstDis.data(j,i)=EstDis.normdis(EstDis.mu(j),EstDis.var(j),1,1);
    end
    [~, MaxIndex]=max(EstDis.data(:,i));
    EstDis.prob(MaxIndex)=EstDis.prob(MaxIndex)+1;
end

EstDis.prob=EstDis.prob/M;

% Use weighted sum to estimate the max mean

WEMaxMean=EstDis.mu'*EstDis.prob;
MEMaxMean=max(EstDis.mu);

Prob1=EstDis.prob(1);
Prob2=EstDis.prob(2);

% Draw to analyze
if ifdraw
    
    Xp1=ones(1,M)*1;
    Xp2=ones(1,N)*2;
    Xp3=ones(1,M)*3;
    Xp4=ones(1,N)*4;

    F1=scatter(1,EstDis.mu(1),40,'d','r');hold on;text(1.05, EstDis.mu(1),['$\hat\mu_1=$',num2str(EstDis.mu(1))],'Interpreter','latex');
    F2=scatter(1,EstDis.mu(1)+EstDis.var(1),40,'^','b');hold on;
    F3=scatter(1,EstDis.mu(1)-EstDis.var(1),40,'v','b');hold on;
    F4=scatter(Xp1,EstDis.data(1,:),10,'x','k');hold on;

    scatter(2,TrueDis.mu(1),40,'d','r');hold on;text(2.05, TrueDis.mu(1),['$\mu_1=$',num2str(TrueDis.mu(1))],'Interpreter','latex');
    scatter(2,TrueDis.mu(1)+TrueDis.var(1),40,'^','b');hold on;
    scatter(2,TrueDis.mu(1)-TrueDis.var(1),40,'v','b');hold on;
    scatter(Xp2,TrueDis.data(1,:),10,'x','k');hold on;

    scatter(3,EstDis.mu(2),40,'d','r');hold on;text(3.05, EstDis.mu(2),['$\hat\mu_2=$',num2str(EstDis.mu(2))],'Interpreter','latex');
    scatter(3,EstDis.mu(2)+EstDis.var(2),40,'^','b');hold on;
    scatter(3,EstDis.mu(2)-EstDis.var(2),40,'v','b');hold on;
    scatter(Xp3,EstDis.data(2,:),10,'x','k');hold on;

    scatter(4,TrueDis.mu(2),40,'d','r');hold on;text(4.05, TrueDis.mu(2),['$\mu_2=$',num2str(TrueDis.mu(2))],'Interpreter','latex');
    scatter(4,TrueDis.mu(2)+TrueDis.var(2),40,'^','b');hold on;
    scatter(4,TrueDis.mu(2)-TrueDis.var(2),40,'v','b');hold on;
    scatter(Xp4,TrueDis.data(2,:),10,'x','k');hold on;

    ly=min([min(min(EstDis.data)), min(min(TrueDis.data)), EstDis.mu(1)-EstDis.var(1), TrueDis.mu(1)-TrueDis.var(1), EstDis.mu(2)-EstDis.var(2), TrueDis.mu(2)-TrueDis.var(2)]);
    uy=max([max(max(EstDis.data)), max(max(TrueDis.data)), EstDis.mu(1)+EstDis.var(1), TrueDis.mu(1)+TrueDis.var(1), EstDis.mu(2)+EstDis.var(2), TrueDis.mu(2)+TrueDis.var(2)]);

    text(1.1,ly,['Beating Prob 1=', num2str(Prob1)]);text(2.1,ly,['\sigma_1^2=', num2str(var1^2)]);
    text(3.1,ly,['Beating Prob 2=', num2str(Prob2)]);text(4.1,ly,['\sigma_2^2=', num2str(var2^2)]);

    axis([0 5 ly-0.5 uy+0.5]);
    set(gca,'XTick',[1 2 3 4]);
    set(gca,'XTickLabel',{'DND1','TrueNormalDis1','DND2','TrueNormalDis2'});
    F5=line([0,5],[EstMaxMean,EstMaxMean],'color','g');
    text(0.5,EstMaxMean,num2str(EstMaxMean));
    legend([F1 F2 F3 F4 F5],'Mean','Mean+\sigma','Mean-\sigma','Observations','Estimated Max Mean');
end

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