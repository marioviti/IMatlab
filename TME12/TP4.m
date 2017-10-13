addpath('descripteurs');
addpath('bow');
addpath('k-means');
addpath('learning');
addpath('libsvm');

pathBow = './descriptors_bow2/';
K = 1001;
nTrain = 100;

[imCat, imCatTest] = NbImCatAllTest( pathBow, nTrain );
[train, test] = loadData( nTrain, imCat, pathBow, K );
[ntest, K] = size(test);
[num_cat,one] = size(imCat);

predictclassifieurs = zeros(ntest,num_cat);

for i=1:num_cat
    [y, ytest] = labelsTrainTest( nTrain, ntest, imCat, i );
    [ values ] = trainTest( train, test, y);
    predictclassifieurs(:,i) = values;
end

[ matConf , txCat ] = multiClassPrediction( predictclassifieurs , imCatTest);