function [ centers, errors ] = kmeans( X, K , eps, max_epochs )
    if nargin == 2
        eps = 1e-2;
        max_epochs = 100;
    end
    epochs = 0;
    d_shift = 10e2;
    centers = randomSeed(X,K);
    errors = [];
    while d_shift > eps && epochs < max_epochs
        nc = assignementKMeans( listPts , centers );
        [ newcenters , errorq , movecenters ] = miseAjourKMeans( X, centers, nc );
        d_shift = movecenters - d_shift;
        centers = newcenters;
        errors = [errors,errorq];
    end
end

