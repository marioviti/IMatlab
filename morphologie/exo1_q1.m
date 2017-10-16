%el struct diff tailles
sesq11=strel('square',11);
sesq9=strel('square',9);
sesq7=strel('square',7);
sesq5=strel('square',5);
sesq3=strel('square',3);
sevec=[sesq3,sesq5,sesq7,sesq9,sesq11];
[~,n_els]=size(sevec);

%image test
impath='img/retina2.gif';
impath2='img/cailloux.png';
imtest=imread(impath);

[h,w] = size(imtest);

for i=1:n_els
    
    dil = imdilate(imtest,sevec(i));
    ero = imerode(imtest,sevec(i));
    ope = imopen(imtest,sevec(i));
    clo = imclose(imtest,sevec(i));
    
    size_se = size(sevec(i).Neighborhood);
    
    subplot(2*n_els,4,(i-1)*8+1);
    imshow(dil);
    title_s = sprintf('dilatation s=%d',size_se(1));
    title(title_s);
    subplot(2*n_els,4,(i-1)*8+2);
    imshow(ero);
    title_s = sprintf('erosion s=%d',size_se(1));
    title(title_s);
    
    subplot(2*n_els,4,(i-1)*8+3);
    imshow(ope);
    title_s = sprintf('open s=%d',size_se(1));
    title(title_s);
    
    subplot(2*n_els,4,(i-1)*8+4);
    imshow(clo);
    title_s = sprintf('close s=%d',size_se(1));
    title(title_s);

    subplot(2*n_els,4,(i-1)*8+5);
    plot(dil(h/2,:));
    subplot(2*n_els,4,(i-1)*8+6);
    plot(ero(h/2,:));
    
    subplot(2*n_els,4,(i-1)*8+7);
    plot(ope(h/2,:));
    subplot(2*n_els,4,(i-1)*8+8);
    plot(clo(h/2,:));
    
end