eps=1e-10;
imCatTest = [116 ; 141 ; 211 ; 110 ; 189 ; 260 ; 228 ; 160 ; 208 ; 274 ; 310 ; 192 ; 256 ; 115 ; 215];
classifiersname = 'http://webia.lip6.fr/~thomen/Teaching/RDFIA/cody/classifiers.mat';
urlwrite(classifiersname,'temp.mat');
load('temp.mat');
[ confusionMatrix , nGoodCat ] = multiClassPrediction( predictclassifieurs , imCatTest );
figure();
subplot(2,2,1);
plot(nGoodCat);
subplot(2,2,2);
imagesc(confusionMatrix);
subplot(2,2,3);
plot(nGoodCatr);
subplot(2,2,4);
imagesc(confusionMatrixr);