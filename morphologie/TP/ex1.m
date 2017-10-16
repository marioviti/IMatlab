se = strel('square',11); 
imtest = imread('img/bat200.bmp');
imshow(imtest);

closure = imclose(imtest,se);
imshow(closure);