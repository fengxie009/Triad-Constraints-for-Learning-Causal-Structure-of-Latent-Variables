function G = Find_CausalOrder(Tem_Cluster,X,CaT_Bol,G,CC)
%Find causal order one by one
Data=X;
CCC=size(Tem_Cluster,1);
Dims=1:CCC;
dims_variable=size(X,1);
%First, Find the largest subset that satisfies Proposition 2
Count_M=zeros(CCC,CCC);
if CCC>1
    for i=1:CCC
        for j=1:CCC
            if i~=j
                Bollean = CaT_Bol(Tem_Cluster(i,1),Tem_Cluster(j,1),Tem_Cluster(i,2));% A-B|C
                Count_M(i,j)=Bollean;
            end
        end
    end
end
CM=sum(Count_M,2);%sum for each row
g=0;
while 1
    if length(CM)==1
        g=g+1;
        Grp(g).a=Dims(1);
        break;
    end
    [~,index]=max(CM');
    GT=find(Count_M(index(1),1:length(CM))==1);
    g=g+1;
    Grp(g).a=Dims([index(1) GT]);
    Dims([index(1) GT])=[];
    CM([index(1) GT])=[];
    %delete column
    Count_M(:,[index(1) GT])=[];
    %delete row
    Count_M([index(1) GT],:)=[];
    if isempty(CM)
        break;
    end
end

for i=1:g
    L_G=Grp(g).a;
    Num_Cluster=0;
    while 1
        if length(L_G)==1
            break;
        end
        %%%P_value
        %%%%%%%%%%%%%% Consider two measurement variables (A(1,1),A(1,2)) %%%%%%%%%%%%
        PPP = EstimateDirection_ByKMI(Data,Tem_Cluster,X,L_G);
        [FF1,Index1]=sort(sum(PPP,2)');%max_row ;Find the minimum
        
        %Update the graph G; Root Latent Variable--> the other Latent Variables
        Root_number=L_G(Index1(1));
        
        %Remove this number of root variable
        L_G(Index1(1))=[];
        
        G(dims_variable+CC(Root_number),dims_variable+CC(L_G))=1;%Here, we use CC() to find the corresponding latent location,
        
        %Update data
        if length(L_G)==1
            break;
        else
            A1=Tem_Cluster(Root_number,:);
            %A2=fliplr(Root_latent);
            %  First one
            Data = Update_Data(Data,A1,L_G);
        end
    end
end

%If there are more than one largest subset, then we construct an new
%latent variable

if g>1
    %Update G
    G(dims_variable+CCC+1,:)=0;
    G(:,dims_variable+CCC+1)=0;
    for i=1:g
        G(dims_variable+CCC+1,dims_variable+CC( Grp(i).a))=1;
    end
end

% %add last cluster
% Num_Cluster=Num_Cluster+1;
% Latent(Num_Cluster).a= Tem_Cluster(1,:);
% Causal_Order(Num_Cluster)=CC(1);
end

