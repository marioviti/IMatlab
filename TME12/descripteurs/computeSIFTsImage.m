function [sifts,r] = computeSIFTsImage(I,s,delta,contrast_tresh)
    %sample scale
    %s = 16;
    % sampling step
    %delta = 8;
    if nargin == 1
        s = 16;
        delta = 8;
        contrast_tresh = 1.2;
    end
    [Ix,Iy] = compute_gradient(I);
    Ig = (Ix.^2 + Iy.^2).^(0.5);
    Ior = orientation(Ix,Iy,Ig);
    r = denseSampling(I,s,delta);
    dimensioni_immagine = size(r);
    num_of_patches =dimensioni_immagine(2);
    Mg = gaussSIFT(s);
    sifts = zeros(128,num_of_patches);
    for i = 1:num_of_patches
       Ig_patch = Ig(r(1,i):r(1,i)+s-1,r(2,i):r(2,i)+s-1);
       Ior_patch = Ior(r(1,i):r(1,i)+s-1,r(2,i):r(2,i)+s-1);
       sifts(:,i) = computeSIFT(s, Ig_patch, Ior_patch, Mg, contrast_tresh);
    end
end

