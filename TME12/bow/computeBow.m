function [bow,nc]= computeBow(sifts, clusters, matNormClusters, coding, kpp)
    if nargin == 3
        coding = 'hard';
        kpp = 0;
    end
    [K,d] = size(clusters);
    [d,N] = size(sifts);
    H = zeros(K,N);
    ctc = matNormClusters; %sum(clusters.^2,2);
    xtx = sum(sifts.^2,1);
    ctc_n = repmat(ctc,[1 N]);
    ctx = clusters * double(sifts);
    d_xc = xtx + ctc_n - 2*ctx;
    if strcmp(coding,'hard')
        [C,nc] = min(d_xc);
        for i=1:K
            for j=1:N
                if nc(j) == i;
                    H(i,j) = 1;
                end
            end
        end
        bow = sum(H,2);
        bow = bow/N;
    end
    if strcmp(coding, 'kpp')
        if nargin == 4
            kpp = K;
        end
        for i=1:K
            [C,nc] = min(d_xc);
            d_xc(nc) = inf;
            for j=1:kpp
                H(i,j) = C(j);
            end
        end
        bow = sum(H,2);
        bow = bow/Nsum(bow);
    end
end