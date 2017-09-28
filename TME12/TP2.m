clear all;
close all;
addpath('descripteurs');
addpath('k-means');

n = 20;
M = 2;
k = 2;
listPts = randomListPts(n,M);
listPts(1:n/2,1) = listPts(1:n/2,1) + 10;
listPts(1:n/2,2) = listPts(1:n/2,2) + 2;
centers = randomSeed(listPts,k);
listPts

epochs = 3;
for i=1:epochs
    nc = assignementKMeans( listPts , centers );
    [errorq, newcenters] = miseAjourKMeans( listPts, centers, nc );
    centers = newcenters;    
end
scatter(listPts(:,1),listPts(:,2));
hold on
scatter(centers(:,1),centers(:,2),'filled');


