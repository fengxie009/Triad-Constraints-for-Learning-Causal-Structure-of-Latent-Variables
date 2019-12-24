function Bolean = Identify_Cluster_for_TwoVariables(Test_Pvalue)
%Identify whether if cluster for any two variables
[m,p,n]=size(Test_Pvalue);
Bolean=1;
for i=1:n
    if Test_Pvalue(i)==0
        Bolean=0;
        break;
    end
end
end

