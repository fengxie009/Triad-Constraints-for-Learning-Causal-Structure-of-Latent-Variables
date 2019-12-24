function Data = Update_Data(Data,Exogenous_Variable,Dims)
%Updata the rest of varaibles by exogenous variable
for i=1:length(Dims)
    Data(Dims(1,i),:) = Regression_Residual(Data(Dims(1,i),:),Data(Exogenous_Variable(1,1),:),Data(Exogenous_Variable(1,2),:));%%%%Xi,X1|X2
end
end

