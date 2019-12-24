function PPP = EstimateDirection_ByKMI(Data,Latent_Cluster,X,L_G)
%Calculate the Kerner Mutual Information;
%Let PPP save the variables
CCC=length(L_G);
PPP=zeros(CCC,CCC);
% Find an root variable
for i=1:CCC
    for j=i+1:CCC
        %2019-05-25
        MI1 = My_KMI(Regression_Residual(Data(Latent_Cluster(L_G(i),1),:),Data(Latent_Cluster(L_G(j),1),:),X(Latent_Cluster(L_G(i),2),:)),X(Latent_Cluster(L_G(i),2),:));
        %MI2 = My_KMI(Regression_Residual(Data(Tem_Cluster(i,2),:),Data(Tem_Cluster(j,2),:),Data(Tem_Cluster(i,1),:)),X(Tem_Cluster(i,1),:));
        MI3 = My_KMI(Regression_Residual(Data(Latent_Cluster(L_G(i),1),:),Data(Latent_Cluster(L_G(j),1),:),X(Latent_Cluster(L_G(j),2),:)),X(Latent_Cluster(L_G(j),2),:));
        %MI4 = My_KMI(Regression_Residual(Data(Tem_Cluster(i,2),:),Data(Tem_Cluster(j,2),:),Data(Tem_Cluster(j,1),:)),X(Tem_Cluster(j,1),:));
        PPP(i,j)=MI1;
        PPP(j,i)=MI3;
    end
end
end

