%% MyMainScript

tic;
%% Your code here
figure(1);
rmsd_PCADenoising1=myPCADenoising1();

figure(2);
rmsd_PCADenoising2=myPCADenoising2();

figure(3);
im = double(imread('../data/barbara256.png'));
im1 = double(im) + randn(size(im))*20;
[rmsd_BilateralFiltering,a]=myBilateralFiltering(im,im1,20,10);
toc;
