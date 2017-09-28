function [errorq, newcenters] = miseAjourKMeans( listPts , centers , nc)
    [M,k] = size(centers);
    newcenters = zeros(M,k);
    for i=1:k
        assigned = listPts(nc==i,:);
        c_wi = mean(assigned);
        newcenters(i,:) = c_wi;
    end
    errorq = norm(centers-centers);
end

