function [centres,erreur] = solutionKMeans(listPts,k)
    centers = randomSeed(listPts,k);
    nc = assignementKMeans( listPts , centers );
    [newcenters , erreur , movecenters ] = miseAjourKMeans( listPts , centers , nc);
end

