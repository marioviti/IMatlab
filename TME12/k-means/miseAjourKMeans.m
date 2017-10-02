
function [ newcenters , errorq , movecenters ] = miseAjourKMeans( listPts , centers  , nc)
    [k,d] = size(centers);
    newcenters = zeros(k,d);
    errorq = 0;
    for i=1:k
        assigned = listPts(nc==i,:);
        [kn,d] = size(assigned);
        c_wi = mean(assigned);
        newcenters(i,:) = c_wi;
        C_wi = repmat(c_wi,[kn,1]);
        %sum < x - c >'<x - c>
        diff_x_c = assigned - C_wi;
        sqr_dist = sum(diff_x_c.^2,2);
        errorq = errorq + sum(sqr_dist);
    end
    movecenters = sum(dot(newcenters-centers,newcenters-centers,2));
end