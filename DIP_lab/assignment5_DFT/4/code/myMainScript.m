%% MyMainScript

tic;
%% Your code here
im=imread('../data/barbara256.png');


[h,w]=size(im);
imnew=padarray(im,[h/2,w/2]);
imf=fft2(imnew);
im1=fftshift(imf);


D=[40 80];

 lowpassfilter(im1,h,w,D(1));
lowpassfilter(im1,h,w,D(2));
sigma=[40 80];
 gaussianfilter(im1,h,w,sigma(1));
 gaussianfilter(im1,h,w,sigma(2));



toc;


