function [ centers, errors ] = kmeans( X, K , eps, max_epochs )
    if nargin == 2
        eps = 1e-1;
        max_epochs = 100;
    end
    epochs = 0;
    centers = randomSeed(X,K);
    errors = [];
    movecenters = 10e2;
    while movecenters > eps && epochs < max_epochs
        nc = assignementKMeans( X , centers );
        [ newcenters , errorq , movecenters ] = miseAjourKMeans( X, centers, nc );
        centers = newcenters;
        errors = [errors,errorq];
    end
end

