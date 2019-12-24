function [CaT_pval] = Calculate_All_Traid(X,alpha)
%Input:
%   X:a dims*samples Matrix, represents the observed data

%Output:
%   CaT_pval£ºa dims*dims*dims Matrix,i.g., CaT_pval(i,j,k) represtents the bollean of Triad(X_i,X_j|X_k)

[Dims,~]=size(X);
CaT_pval(1:Dims,1:Dims,1:Dims)=-1;
for i=1:Dims-1
    for j=i+1:Dims
        for k=1:Dims
            if k~=i && k~=j
                Bollean = TestTriadContraint(X(i,:),X(j,:),X(k,:),alpha);% A-B|C
                CaT_pval(i,j,k)=Bollean;
                CaT_pval(j,i,k)=Bollean;
            end
        end
    end
end
end

