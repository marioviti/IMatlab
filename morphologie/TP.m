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

for i=1:n_els
    
    dil = imdilate(imtest,sevec(i));
    ero = imerode(imtest,sevec(i));
    ope = imopen(imtest,sevec(i));
    clo = imclose(imtest,sevec(i));
    
    subplot(2*n_els,4,(i-1)*8+1);
    imshow(dil);
    title('dilatation');
    subplot(2*n_els,4,(i-1)*8+2);
    imshow(ero);
    title('erosion');
    
    subplot(2*n_els,4,(i-1)*8+3);
    imshow(ope);
    title('open');
    
    subplot(2*n_els,4,(i-1)*8+4);
    imshow(clo);
    title('close');

    subplot(2*n_els,4,(i-1)*8+5);
    plot(dil(120,:));
    subplot(2*n_els,4,(i-1)*8+6);
    plot(ero(120,:));
    
    
    subplot(2*n_els,4,(i-1)*8+7);
    plot(ope(120,:));
    subplot(2*n_els,4,(i-1)*8+8);
    plot(clo(120,:));
    
end


imtest2 = imread(impath2);

%propriete de dilatation
%d(fVg,B) = d(f,B) V d(g,B)

[m,n]=size(imtest);
[m1,n1]=size(imtest2);
if m>m1
    m=m1;
end
if n>n1
    n=n1;
end

f=imtest(1:m,1:n);
g=imtest2(1:m,1:n);
fAg = min(f,g);
dilfAg = imdilate(fAg,sesq11);

dilf = imdilate(f,sesq11);
dilg = imdilate(g,sesq11);
dilfAdilg = min(dilf,dilg);

subplot(1,2,1);
imshow(dilfAg);

subplot(1,2,2);
imshow(dilfAdilg);

%propriete de dilatation
%d(fAg,B) meq d(f,B) A d(g,B)

fVg = max(f,g);
dilfVg = imdilate(fVg,sesq11);

dilfVdilg = max(dilf,dilg);

subplot(1,2,1);
imshow(dilfVg);

subplot(1,2,2);
imshow(dilfVdilg);

%propriete de erosion
%e(fVg,B) Meq e(f,B) V e(g,B)

erofVg = imerode(fVg,sesq11);
erofVerog = max(imerode(f,sesq11),imerode(g,sesq11));

subplot(1,2,1);
imshow(erofVg);

subplot(1,2,2);
imshow(erofVerog);

%propriete de erosion
%e(fAg,B) = e(f,B) A e(g,B)

erofAg = imerode(fAg,sesq11);
erofAerog = min(imerode(f,sesq11),imerode(g,sesq11));

subplot(1,2,1);
imshow(erofAg);

subplot(1,2,2);
imshow(erofAerog);

%propriete open

%antiestensive X>X_B

B = sesq11;
X = imtest;
X_B = imopen(X,B);

diff_non_null = X-X_B;

subplot(1,1,1);
imshow(diff_non_null);

%croissante X<Y => X_B<Y_B

%fAg<f => fAg_B<f_B => f_B-fAg_B > 0

fAg_B = imopen(fAg,B);
f_B = imopen(f,B);
diff_non_null = f_B-fAg_B;

subplot(1,1,1);
imshow(diff_non_null);

%idempotente X_B = ((X_B)_B)..._B

f_B = imopen(f,B);
f_B_B = imopen(f_B,B);

subplot(1,2,1);
imshow(f_B);

subplot(1,2,2);
imshow(f_B_B);

%propriete ferm

%estensive X<XtB

B = sesq11;
X = imtest;
XtB = imclose(X,B);

diff_non_null = XtB-X;

subplot(1,1,1);
imshow(diff_non_null);

%croissante X<Y => XtB<YtB

%fAg<f => fAgtB<ftB => ftB-fAgtB > 0

fAgtB = imclose(fAg,B);
ftB = imclose(f,B);
diff_non_null = ftB-fAgtB;

subplot(1,1,1);
imshow(diff_non_null);

%prop iteration
sesq8=strel('square',8);

dil3 = imdilate(f,sesq3);
dil35 = imdilate(dil3,sesq5);
dil8 = imdilate(f,sesq8);

diff_null = dil35-dil8;

subplot(1,1,1);
imshow(diff_null);
