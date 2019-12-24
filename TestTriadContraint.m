function Bollean = TestTriadContraint(A,B,C,alpha)
%Teat Triad Contraint (A,B|C)
% A,B,C are three observed variables,each column a variable
%bollean 1 or 0; 1: satisfy Triad
% CCI control conditional independence , 1: test (Default, value); 0: not test
%cal covariance
% TestClusters
% Bollean=1;
% A-B|C
%%%%%%%%------%%%%%%%%%%%
RF=A-(Cov_Two(A,C)/Cov_Two(B,C))*B;
[p_val, ~] = UInd_KCItest(RF',C');
if p_val>alpha
    Bollean=1;
else
    Bollean=0;
end
end

