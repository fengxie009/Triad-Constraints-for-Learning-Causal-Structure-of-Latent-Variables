function CC = Cov_Two(X,Y)
% Cal covariance of X and Y,each row a variable
C=[X;Y];
T=cov(C');
CC=T(1,2);
end

