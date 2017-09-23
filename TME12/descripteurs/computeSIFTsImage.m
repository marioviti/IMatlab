function sifts = computeSIFTsImage(I)
    %sample scale
    s = 16;
    % sampling step
    delta = 8;
    [Ix,Iy] = compute_gradient(I);
    Ig = (Ix.^2 + Iy.^2).^(0.5);
    Ior = orientation(Ix,Iy,Ig);
    r = denseSampling(I,s,delta);
    num_of_patches = size(r)(2);
    Mg = gaussSIFT(s);
    sifts = zeros(num_of_patches,1);
    for i = 1:num_of_patches-1
       Ig_patch = Ig(r(1,i):r(2,i),r(1,i+1)+s:r(2,i+1)+s);
       Ior_patch = Ior(r(1,i):r(2,i),r(1,i+1)+s:r(2,i+1)+s);
       sifts(i:i+128) = computeSIFT(s, Ig_patch, Ior_patch, Mg);
    end
end

