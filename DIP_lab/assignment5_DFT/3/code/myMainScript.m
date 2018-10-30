%% MyMainScript

tic;
%% Your code here

image=load('../data/image_low_frequency_noise.mat');
im=image.Z;
a=fft2(im);
absfim2 = log(abs(a)+1); 
toc;
