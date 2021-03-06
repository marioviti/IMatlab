clear all;
close all;
addpath('descripteurs');
addpath('k-means');

N = 120;
d = 2;
K = 3;

listPts0 = rand(N/4,d);
listPts1 = rand(N/4,d)+10;
listPts2 = rand(N/4,d)-10;
add_noise = rand(N/4,d)*10;
listPts = [listPts0.',listPts1.'].';
listPts = [listPts.',listPts2.'].';
listPts = [listPts.',add_noise.'].';
size(listPts)
nc = randi(K,1,N);
centers = rand(K,d);
centers = centers - mean(centers);
centers = centers *10;

figure
scatter(listPts(:,1),listPts(:,2));
hold on
scatter(centers(:,1),centers(:,2),'filled');
epochs = 4;
errors = [];
for i=1:epochs
    
    nc = assignementKMeans( listPts , centers );
    [ newcenters , errorq , movecenters ] = miseAjourKMeans( listPts, centers, nc );
    
    centers = newcenters;
    errors = [errors,errorq];
    errorq
    figure
    for j=1:K
        assigned = listPts(nc==j,:);
        scatter(assigned(:,1),assigned(:,2));
        hold on
    end
    scatter(centers(:,1),centers(:,2),'filled');
end
plot(errors);
