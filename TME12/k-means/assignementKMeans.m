function [ nc ] = assignementKMeans( listPts , centers )
    [n,M] = size(listPts);
    ctc = sum(centers.^2,2);
    ctc_n = repmat(ctc,[1 n]);
    ctx = centers * listPts.';
    d_xc = ctc_n - 2*ctx;
    [C,nc] = min(d_xc);
end
