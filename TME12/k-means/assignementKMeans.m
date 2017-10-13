function [ nc ] = assignementKMeans( listPts , centers )
    [n,~] = size(listPts);
    ctc = sum(centers.^2,2);
    ctc_n = repmat(ctc,[1 n]);
    ctx = centers * listPts.';
    d_xc = ctc_n - 2*ctx;
    [~,nc] = min(d_xc);
end
