baseDir = './Scene/';
baseDirDes = './descriptors3/';
baseDirDico = './visual_dico.mat';
[I,nomim,sifts] = randomImageDes(baseDir, baseDirDes);
load(baseDirDico);
clusters = centers;
matNormClusters = sum(clusters.^2,2);
[patchmin] = visuDico(baseDirDico, baseDir, baseDirDes);
[bow,nc] = computeBow(sifts,clusters,matNormClusters);
visuBoW(I,patchmin,bow,nc,nomim);


