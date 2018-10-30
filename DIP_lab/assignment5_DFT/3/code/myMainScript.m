%% MyMainScript

tic;
%% Your code here

image=load('../data/image_low_frequency_noise.mat');
im=image.Z;
[h,w]=size(im);
imnew=padarray(im,[h/2,w/2]);
imf=fft2(imnew);
im1=fftshift(imf);

logmag=log(abs(im1)+1);



















toc;
