function [values] = trainTest(train, test, y)
    model = svmtrain(y, train, '-c 1000 -t linear') ;
    [w,b] = getPrimalSVMParameters(model);
    [n_test,~] = size(test);
    values = zeros(n_test,1);
    for i=1:n_test
        values(i,1) = test(i,:)*w + b;
    end

end
