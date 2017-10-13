function [ confusionMatrix , nGoodCat ] = multiClassPrediction(predictclassifieurs , imCatTest )
    rang = 1;
    [n_cat,~]=size(imCatTest);
    confusionMatrix = zeros(n_cat,n_cat);
    for cat = 1:n_cat
        for element = 1: imCatTest(cat)
            col =max(predictclassifieurs(:,rang))==predictclassifieurs(:,rang);
            col = col./imCatTest(cat);
            confusionMatrix(cat,:) = confusionMatrix(cat,:) + col';  
            rang = rang+1;
        end
    end
    confusionMatrix = confusionMatrix*100;
    for i =1:n_cat
        nGoodCat(i) = confusionMatrix(i,i);
    end
end

