eps = 1e-6;
baseDir = 'http://webia.lip6.fr/~thomen/Teaching/RDFIA/cody/';
imname = 'MITtallbuilding_image_0241.jpg';
ncname = 'MITtallbuilding_nc_0241.mat';
classifierName = 'classifiers.mat';
% Loading image
imnamefull = strcat(baseDir,imname);
I = imread(imnamefull);
% Loading sifts assignements corresponding to a test image (MITTallbuilding, 241)
ncnamefull = strcat(baseDir,ncname);
urlwrite(ncnamefull,'temp.mat');
load('temp.mat');
% Loading previously trained binary classifiers
% contains 'ws','ras','predictclassifieurs','test'
classifierNamefull = strcat(baseDir,classifierName);
urlwrite(classifierNamefull,'temp.mat');
load('temp.mat');
indcat = 13;
indnum = find(ras{indcat}==241) - 100;
imCatTest = [116 ; 141 ; 211 ; 110 ; 189 ; 260 ; 228 ; 160 ; 208 ; 274 ; 310 ; 192 ; 256 ; 115 ; 215];
cpt = sum(imCatTest(1:indcat-1)) + indnum;
[ hmap ] = compute_prediction_heatmap( I , nc , ws(indcat,:)' );
figure();
subplot(1,3,1);
imagesc(I);
colormap(gray);
subplot(1,3,2);
imagesc(hmap);
colormap(jet);
subplot(1,3,3);
imagesc(hmap);
colormap(jet);
err = norm(hmap-hmap,'fro');
assert(err<eps)