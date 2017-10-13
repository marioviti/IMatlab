function [bow ]= computeBow(sifts, clusters, matNormClusters)
    [K,d] = size(clusters);
    [d,N] = size(sifts);
    H = zeros(K,N);
    ctc = matNormClusters;
    xtx = sum(sifts.^2,1);
    ctc_n = repmat(ctc,[1 N]);
    ctx = clusters * double(sifts);
    d_xc = xtx + ctc_n - 2*ctx;
    [C,nc] = min(d_xc);
    for i=1:K
        H(i,nc==i) = 1;
    end
    bow = sum(H,2);
    bow = bow/N;
end