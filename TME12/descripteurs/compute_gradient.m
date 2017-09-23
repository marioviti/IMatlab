function [Ix,Iy] = compute_gradient(I)
    hx = 0.25*[1,2,1];
    hy = [-1;0;1];
    Ix = convolution_separable(I,hx,hy);
    Iy = convolution_separable(I,hy.',hx.');
end