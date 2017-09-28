clear all;
close all;

addpath('descripteurs');
I = randomImage('Scene/');
s = 16;
%I = imread('tools.gif'),
%I = marche();

coordx = 121;
coordy = 121;
[Ix,Iy] = compute_gradient(I);
Ig = (Ix.^2 + Iy.^2).^(0.5);
Ior = orientation(Ix,Iy,Ig);
patch = [coordx,coordx+s-1;coordy,coordy+s-1];
Mg = gaussSIFT(s);
%sift = computeSIFT(s,Ig(coordx:coordx+s-1,coordy:coordy+s-1),Ior(coordx:coordx+s-1,coordy:coordy+s-1),Mg,3);
%visuSIFT(I,Ig,Ior,patch,'marche',s,sift);
s = 16;
delta = 8;
contrast_tresh = 1.5;
%[sifts,r] = computeSIFTsImage(I,s,delta,contrast_tresh);
%drawPatches(I,r,s,sifts);