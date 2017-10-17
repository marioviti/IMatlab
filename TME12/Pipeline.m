close all;

addpath('descripteurs');
addpath('learning');
addpath('learning/libsvm');
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

% W and b
path_class = './classifier/';
name_ws = 'ws.mat';
name_bs = 'bs.mat';

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

nTrain = 100;

% dividing training and test data
[imCat, imCatTest] = NbImCatAllTest( pathbow, nTrain );
[train, test] = loadData( nTrain, imCat, pathbow, K );
[ntest, K] = size(test);
[num_cat,one] = size(imCat);
predictclassifieurs = zeros(num_cat,ntest);

ws = zeros(num_cat,K);
bs = zeros(num_cat);

[check,~] = size(dir(path_class));
if check == 0 
    mkdir(path_class);
    for i=1:num_cat
        [y, ytest] = labelsTrainTest( nTrain, ntest, imCat, i );
        [ values,w,b ] = trainTest( train, test, y);
        ws(i,:) = w;
        bs(i) = b;
        predictclassifieurs(i,:) = values;
    end
    save(strcat(path_class,'ws.mat'), 'ws');
    save(strcat(path_class,'bs.mat'), 'bs');
    save(strcat(path_class,'predictclassifieurs.mat'), 'predictclassifieurs');
else
    ws = load(strcat(path_class,'ws.mat'));
    ws = ws.ws;
    bs = load(strcat(path_class,'bs.mat'));
    bs = bs.bs;  
    predictclassifieurs = load(strcat(path_class,'predictclassifieurs.mat'));
    predictclassifieurs = predictclassifieurs.predictclassifieurs;
end

[ confusionMatrix, nGoodCat ] = multiClassPrediction(predictclassifieurs, imCatTest);

figure();
subplot(2,1,1);
plot(nGoodCat);
subplot(2,1,2);
imagesc(confusionMatrix);

% compute heatmap

cat_test = 2;
test_image_name = 'PARoffice/image_0198';
test_name = strcat('./Scene/',test_image_name,'.jpg');
image_test = imread(test_name);
test_sift_name = strcat('./descriptorsSIFTs/',test_image_name,'.mat');
sift_test = load(test_sift_name);
sift_test = sift_test.sifts;

[heatmap,nc] = test_heatmap_prediction(image_test, sift_test, clusters, ws, cat_test);

figure();
subplot(2,1,1);
imagesc(image_test);
subplot(2,1,2);
imagesc(heatmap);

baseDir = './Scene/';
baseDirDes = './descriptorsSIFTs/';
baseDirDico = './visualdico/clusters.mat';
[patchmin] = visuDico(baseDirDico, baseDir, baseDirDes);
visuHeatMap( image_test , nc, ws(cat_test,:)', heatmap, patchmin , test_image_name);






