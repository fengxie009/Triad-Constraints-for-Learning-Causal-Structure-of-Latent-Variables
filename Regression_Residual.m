function RR = Regression_Residual(A,B,C)
%
% A-B|C
RR=A-(Cov_Two(A,C)/Cov_Two(B,C))*B;
end

