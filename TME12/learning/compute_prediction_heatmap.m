function [ hmap ] = compute_prediction_heatmap( I , nc , ws )
    r = denseSampling(I,16,8);
    [~,npatch] = size(r);
    [h,w] = size(I);
    hmap = zeros(size(I));
    delta = 15;
    for i=1:npatch
       pxi = ws(nc(i));
       if delta+r(1,i)<= h && delta+r(2,i) <=w
         hmap(r(1,i):delta+r(1,i),r(2,i):delta+r(2,i)) = hmap(r(1,i):delta+r(1,i),r(2,i):delta+r(2,i)) + pxi;
       end
    end
    hmap = hmap*(1/npatch);
end

