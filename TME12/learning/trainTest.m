function [values] = trainTest(train, test, y)
    model = svmtrain(train, y);
    [w,b] = getW_from_alphas(model,y);
    values = test*w';
    values = values+b;
    %model = fitcsvm(train, y, 0.6);
    %model = fitcsvm(train, y, );
    %[~,values] = predict(model,test);
    %values = values(:,1);
end
