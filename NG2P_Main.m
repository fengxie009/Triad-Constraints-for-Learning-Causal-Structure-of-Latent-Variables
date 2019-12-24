function [G,Name] = NG2P_Main(X,alpha)
%Input
%X: dims * sample size
%alpha: Set the significance level of independent test

%Add the path of method of independent test
addpath('.\KCI');
fprintf('Using KCI for Independent Test\n');

[dims,samples]=size(X);
%Remove the Mean of Variables
X = X - mean(X,2)*ones(1,samples);
%%
%----------------------------------------------------------------------%
% Phase 1: Finding Clusters
%----------------------------------------------------------------------%

fprintf('Runing the Phase 1: Finding Clusters\n');
%Calculate All Triad conditions
fprintf('Considering the method of Kernel test, it may need more time to run\n');
[CaT_Bol] = Calculate_All_Traid(X,alpha);

T_number=1:dims;
Cluster=[];%Initialize all possible clusters
Latent_number=0;%Initialize the number of Cluster to 0;

% S_CLuster=[];%these clusters have structural information in Phase 1
% S_Latent_number=0;%Initialize the number of S_CLuster to 0;

%save the number of variables£¬it may be latent or observed variable
for i=1:dims
    Xi=['X',num2str(i)];
    %eval([b,'=Tem']);
    Label(i)={Xi};
end

%Use the connected Matrix G to save the causal structure,1: have edge;
%Observed variables+Latent variables
Number_Variable=dims+Latent_number;%
G=zeros(Number_Variable,Number_Variable);%Row -> Column

%Find all possible clusters
while 1
    Tem_Cluster=[];% Temporary cluster
    Combine_M=nchoosek(T_number,2);
    Tem_Cluter_Num=0;
    %
    for i=1:size(Combine_M,1)
        Rest_Var=setdiff(T_number,[Combine_M(i,1),Combine_M(i,2)]);
        Bolean = Identify_Cluster_for_TwoVariables(CaT_Bol(Combine_M(i,1),Combine_M(i,2),Rest_Var));
        %         [Bolean]= FisherTest(CaT_Bol(Combine_M(i,1),Combine_M(i,2),Rest_Var),alpha);
        %Select
        if Bolean==1
            Tem_Cluter_Num=Tem_Cluter_Num+1;
            Tem_Cluster(Tem_Cluter_Num).a=[Combine_M(i,1),Combine_M(i,2)];
        end
    end
    T_number_Posi=T_number;
    if Tem_Cluter_Num==0
        break;
    else
        %Merge overlap cluster and Selcet one of variable from these
        %clusters and update the structural information G
        [Cluster,Latent_number,T_number,Label,G] = Merge_Overlap_Clusters_and_Updata_G(Cluster,Tem_Cluster,Latent_number,T_number,Label,G);
    end
    if length(T_number_Posi)==length(T_number)
        %No clusters that satisfies Theorem 2
        break;
    end
    if length(T_number)==2
        %Test whether there exist another latent variable
        Bollean = Test_Exist_Latent(T_number,Label,Cluster,CaT_Bol,alpha);
        if Bollean==0 %Exist another latent
            Latent_number=Latent_number+1;
            Cluster(Latent_number).a=T_number;
            Cluster(Latent_number).b{1}=Label{T_number(1,1)};
            Cluster(Latent_number).b{2}=Label{T_number(1,2)};
            break;
        else
            break;
        end
    end
    if length(T_number)<2
        break;
    end
end


%Print all latent variables
fprintf('Here, we find %d clusters \n',Latent_number);
for i=1:Latent_number
    fprintf('The %d cluster contains \n',i);
    Lag=Cluster(i).b;
    disp(Lag);
end

if Latent_number==0
    fprintf('There is no cluster and Stop runing the next Phase 2\n');
else
    %----------------------------------------------------------------------%
    % Phase 2: Learning the Structure of Latent Variables
    %----------------------------------------------------------------------%
    fprintf('Runing the Phase 2: Learning the Structure of Latent Variables\n');
    %
    %Find the clusters that require further learning the causal order
    CC=[];
    CC_number=0;
    for i=1:Latent_number
        if isempty(find(G(:,dims+i)==1, 1))
            CC_number=CC_number+1;
            CC(CC_number)=i;
        end
    end
    
    % Select two variables from each cluster to learn the causal order of
    % latent variables
    LL=CC_number;
    for i=1:LL
        Len_Cluster=length(Cluster(CC(i)).a);
        T=Cluster(CC(i)).a;
        T_Cluster(i,:)=T(1,1:2);
    end
    
    %Identify causal directs and confounders by independent noise
    addpath('.\Kernel Mutual Information');
    G = Find_CausalOrder(T_Cluster,X,CaT_Bol,G,CC);
    
    %Lable the name
    Number_Variable=size(G,1);
    for i=1:Number_Variable
        if i<=dims %Observed variables
            Xi=['X',num2str(i)];
            %eval([b,'=Tem']);
            Name(i)={Xi};
        else %Latent variables
            S=i-dims;
            Li=['L',num2str(S)];
            Name(i)={Li};
        end
    end
    %
    %Plot the Graph
    G1=biograph(G,Name);
    view(G1);
end
end

