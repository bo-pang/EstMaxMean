function test_CAI(K)

% % Test Abs function approximation
% X=-1:0.01:1;
% [~,N]=size(X);
% 
% 
% for i=1:N
%    EstAbsX(i)=CAI(X(i),K); 
% end
% 
% plot(X,abs(X),'r');hold on;
% plot(X,EstAbsX,'b');hold on;
% legend('True','Estimate');

N=1000;
Rept=1000;
mu=-0.9:0.05:0.9;
[~,Nmu]=size(mu);
mse=zeros(1,Nmu);

for i=1:Nmu
    fprintf(1,'mu=%.1f\n',mu(i));
    for j=1:Rept
        X=normrnd(mu(i),1,N,1);
        EstAbsMu=CAI(X,K);
        mse(i)=(abs(mu(i))-EstAbsMu)^2+mse(i);
    end
end

mse=mse./Rept;

plot(mu,mse);
xlabel('True \mu');
ylabel('MSE');

save(['.\TrialEstAbs',num2str(K),'.mat'],'-v7');
saveas(gcf,['.\TrialEstAbs',num2str(K),'.fig']);

end

