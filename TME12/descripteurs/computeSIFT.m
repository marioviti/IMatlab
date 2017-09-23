function sift=computeSIFT(s,Ig,Ior,Mg)
    %computeSIFT computes sift descriptor vector for a image patch
    function [histo] = subpatchSIFT(MIgr,Ior)
        histo = zeros(8,1);
        for i=1:4
            for j=1:4
                if Ior(i,j) > 0
                    histo(Ior(i,j)) = histo(Ior(i,j)) + MIgr(i,j);
                end
            end
        end
    end
    sift = zeros(128,1);
    MIgr = Mg.*Ig;
    for ibin=1:s/4
       for jbin=1:s/4
           histo = subpatchSIFT(MIgr(((ibin-1)*4)+1:(ibin*4),((jbin-1)*4)+1:(jbin*4)), Ior(((ibin-1)*4)+1:(ibin*4),((jbin-1)*4)+1:(jbin*4)));
           sift( (((ibin-1)*8*4) + (jbin-1)*8) + 1: ((ibin-1)*8*4) + (jbin)*8) = histo;
        end
    end
    sift=sift/norm(sift);
    sift(sift>0.2) = 0.2;
    sift=sift/norm(sift);
end

