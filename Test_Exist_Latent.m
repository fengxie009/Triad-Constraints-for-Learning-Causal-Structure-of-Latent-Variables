function Bollean = Test_Exist_Latent(T_number,Label,Cluster,CaT_pval,alpha)
%
T1=Label{T_number(1,1)};
%TT1=T1{1,1};
T2=Label{T_number(1,2)};
%TT2=T2{1,1};
Bollean=0;
if strcmp(T1(1,1),'L') && strcmp(T2(1,1),'L')
    N1=Label{T_number(1,1)};
    %NN1=N1{1,1};
    N2=Label{T_number(1,2)};
    %NN2=N2{1,1};
    C1=str2num(N1(1,2));
    C2=str2num(N2(1,2));
    %one
    P1=CaT_pval(Cluster(C1).a(1,1),Cluster(C1).a(1,2),Cluster(C2).a(1,1));
    P2=CaT_pval(Cluster(C1).a(1,1),Cluster(C2).a(1,1),Cluster(C1).a(1,2));
    P3=CaT_pval(Cluster(C1).a(1,2),Cluster(C2).a(1,1),Cluster(C1).a(1,1));
    %two
    Q1=CaT_pval(Cluster(C2).a(1,1),Cluster(C2).a(1,2),Cluster(C1).a(1,1));
    Q2=CaT_pval(Cluster(C2).a(1,1),Cluster(C1).a(1,1),Cluster(C2).a(1,2));
    Q3=CaT_pval(Cluster(C2).a(1,2),Cluster(C1).a(1,1),Cluster(C2).a(1,1));
    if P1>alpha && P2>alpha && P3>alpha
        Bollean=1;
    end
    if Q1>alpha && Q2>alpha && Q3>alpha
        Bollean=1;
    end
end

