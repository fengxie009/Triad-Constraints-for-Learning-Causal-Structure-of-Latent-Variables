function [] = Test_NG2P_Main()
%This is a simple example to test our method
%Latent variables
nSample=5000;
L1=mapstd(unifrnd (-1,1,1,nSample).^5);
L2=0.5*L1+mapstd(unifrnd (-1,1,1,nSample).^5);
%Observed variables
X1=0.5*L1+mapstd(unifrnd (-1,1,1,nSample).^5);
X2=0.5*L1+mapstd(unifrnd (-1,1,1,nSample).^5);
X3=0.5*L2+mapstd(unifrnd (-1,1,1,nSample).^5);
X4=0.5*L2+mapstd(unifrnd (-1,1,1,nSample).^5);
X=[X1; X2; X3; X4];
alpha=0.05;
%Test our method
[G,Name] = NG2P_Main(X,alpha);
end

