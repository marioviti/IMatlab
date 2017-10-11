function [values] = trainTest(train, test, y)
    model = fitcsvm(train, y);
    [label,values] = predict(model,test);
end

