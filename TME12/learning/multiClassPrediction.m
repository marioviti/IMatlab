function [ matConf, txCat ] = multiClassPrediction(predictclassifieurs, imCatTest)

    [n_cat,one] = size(imCatTest);
    imCatTest2 = zeros(n_cat+1,one)+1;
    imCatTest2(2:end)=imCatTest;
    matConf = zeros(n_cat,n_cat);
    
    txCat = zeros(n_cat,1);
    
    % loop over classifiers one per cat
    for i=1:n_cat
        % loop over examples per cat
        for j=1:n_cat
            for k=imCatTest2(j):imCatTest2(j+1)
                matConf(i,j) = matConf(i,j) + predictclassifieurs(k,i);
            end
        end
    end
   
end

