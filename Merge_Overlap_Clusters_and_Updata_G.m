function [Cluster,Cluster_Num,T_number,Label,G] = Merge_Overlap_Clusters_and_Updata_G(Cluster,Tem_Cluster,Cluster_Num,T_number,Label,G)
%Test Clusters, if two clusters are overlap, then we merge them. Then
%Update the structural information G if there exist a latent variable
%Input:
%   Label: find which variable that the T_number represents
%   dims
dims=length(Label);
N=length(Tem_Cluster);
C_Num=1:N;
while 1
    if length(C_Num)==1% Only one cluster
        La1=Label{Tem_Cluster(C_Num(1,1)).a(1,1)};
        La2=Label{Tem_Cluster(C_Num(1,1)).a(1,2)};
        %if two latent variables in cluster, then no new latent variable
        if strcmp(La1(1,1),'L') && strcmp(La2(1,1),'L')
            break;
        else
            %creat a new latent variable
            Cluster_Num=Cluster_Num+1;
            Cluster(Cluster_Num).a=Tem_Cluster(C_Num(1,1)).a;
            Cluster(Cluster_Num).b{1}=La1;
            Cluster(Cluster_Num).b{2}=La2;
            
                        %%Update G
            G(dims+Cluster_Num,:)=0;
            G(:,dims+Cluster_Num)=0;
            %new latent ->cluster  (Row --> Column)
            X1_num=str2num(La1(1,2:length(La1)));
            X2_num=str2num(La2(1,2:length(La2)));
            if strcmp(La1(1,1),'L')
                G(dims+Cluster_Num,dims+X1_num)=1;
            else
                G(dims+Cluster_Num,X1_num)=1;
            end
            if strcmp(La2(1,1),'L')
                G(dims+Cluster_Num,dims+X2_num)=1;
            else
                G(dims+Cluster_Num,X2_num)=1;
            end
            
            %Romves and represents
            T_number(T_number==Tem_Cluster(C_Num(1,1)).a(1,2))=[];
            Li=['L',num2str(Cluster_Num)];
            Label(Tem_Cluster(C_Num(1,1)).a(1,1))={Li};
            
            break;
        end
        
    else
        %Merge the pissible clusters
        Mer_Posi_Cluster=Tem_Cluster(C_Num(1,1)).a;
        C_Num(1)=[];
        CC_Num=C_Num;
        for i=CC_Num
            if ~isempty(intersect(Mer_Posi_Cluster,Tem_Cluster(i).a))
                Mer_Posi_Cluster=unique([Mer_Posi_Cluster Tem_Cluster(i).a]);
                C_Num(C_Num==i)=[];
            end
        end
        L=length(Mer_Posi_Cluster);
        %Count the number of latent variables in Mer_Posi_Cluster
        Cou_Latent=0;
        for i=1:L
            La1=Label{Mer_Posi_Cluster(1,i)};
            if strcmp(La1(1,1),'L')
                Cou_Latent=Cou_Latent+1;
            end
        end
        %if two or more latent variables in cluster, then no new latent variable
        if Cou_Latent>=2
            break;
        else
            %creat a new latent variable
            Cluster_Num=Cluster_Num+1;
            Cluster(Cluster_Num).a=Mer_Posi_Cluster;
            for i=1:L
                Cluster(Cluster_Num).b{i}=Label{Cluster(Cluster_Num).a(1,i)};
            end
            %%Update G
            G(dims+Cluster_Num,:)=0;
            G(:,dims+Cluster_Num)=0;
            %new latent ->cluster  (Row --> Column)
            for i=1:L
                La1=Label{Cluster(Cluster_Num).a(1,i)};
                X1_num=str2num(La1(1,2:length(La1)));
                if strcmp(La1(1,1),'L')
                    G(dims+Cluster_Num,dims+X1_num)=1;
                else
                    G(dims+Cluster_Num,X1_num)=1;
                end
            end
            
            %Romves and represents
            for i=2:L
            T_number(find(T_number==Mer_Posi_Cluster(i)))=[];
            end
            Li=['L',num2str(Cluster_Num)];
            Label(Mer_Posi_Cluster(1))={Li};
            
        end
    end
    if isempty(C_Num)
        break;
    end
end
end

