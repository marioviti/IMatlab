clear all;
close all;

addpath('descripteurs');
s = 16;
%I = imread('tools.gif'),
I = marche();
[Ix,Iy] = compute_gradient(I);
Ig = (Ix.^2 + Iy.^2).^(0.5);
Ior = orientation(Ix,Iy,Ig);
patch = [121,136;121,136];
Mg = gaussSIFT(s);
sift = computeSIFT(s,Ig(121:136,121:136),Ior(121:136,121:136),Mg);
visuSIFT(I,Ig,Ior,patch,'marche',s,sift);