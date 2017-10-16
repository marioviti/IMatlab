close all;

addpath('descripteurs');
addpath('learning');
addpath('bow');
addpath('k-means');

% A REMPLACER AVEC LE DOSSIER CONTENANT LES IMAGES 
pathsrc = './Scene/';

% A REMPLACER AVEC LE DOSSIER CONTENANT LES DESCRIPTEURS SIFT 
pathsifts = './descriptorsSIFTs/';

% VISUAL DICTIONARY LOCATION
pathdico = './visualdico/';
name_dico = 'clusters.mat';

% BOW descriptions
pathbow = './descriptorsBOWs/';

% parameters of pipeline

% threshold on SIFT l2
noisethres = 0.7;

% number of clusters
K = 1000;

% number of initializations for k-means
kinitializations = 10;

% eps for convergence
keps = 1e-3;

% max epochs in convergence
kepochs = 1000;



[check,~] = size(dir(pathsifts));
if check == 0
    computeSIFTsBase(pathsrc,pathsifts,noisethres);
end

mess='loaded SIFTs';
mess

[check,~] = size(dir(pathdico));
if check == 0 && exist(strcat(pathdico,name_dico),'file') == 0
    mkdir(pathdico);
    clusters = computeVisualDico(pathsifts,K,kinitializations,keps,kepochs);
    save(strcat(pathdico,name_dico),'clusters');
else
    load(strcat(pathdico,name_dico));
end

[K,~] = size(clusters); 
mess ='loaded VisualDico';
mess

[check,~] = size(dir(pathbow));
if check == 0
    computeBowBase(pathsifts,pathbow,clusters);
end

mess ='loaded Bow';
mess

nTrain = 110;

[imCat, imCatTest] = NbImCatAllTest( pathbow, nTrain );
[train, test] = loadData( nTrain, imCat, pathbow, K );
[ntest, K] = size(test);
[num_cat,one] = size(imCat);

predictclassifieurs = zeros(num_cat,ntest);

for i=1:num_cat
    [y, ytest] = labelsTrainTest( nTrain, ntest, imCat, i );
    [ values ] = trainTest( train, test, y);
    predictclassifieurs(i,:) = values;
end

[ confusionMatrix, nGoodCat ] = multiClassPrediction(predictclassifieurs, imCatTest)

figure();
subplot(2,1,1);
plot(nGoodCat);
subplot(2,1,2);
imagesc(confusionMatrix);





