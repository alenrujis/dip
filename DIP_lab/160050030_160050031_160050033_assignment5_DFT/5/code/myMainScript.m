%% MyMainScript

tic;
%% Your code here
im = double(imread('../data/barbara256.png'));
im1 = double(im) + randn(size(im))*20;
sigma=20;
figure(1);
rmse_PCADenoising1=myPCADenoising1(im,im1,sigma);

figure(2);
rmse_PCADenoising2=myPCADenoising2(im,im1,sigma);

figure(3);
[rmse_BilateralFiltering,a]=myBilateralFiltering(im,im1,20,10);

im_poisson1=sqrt(im)+randn(size(im))*1/4;
figure(4);
rmse_poisson1=myPoissonDenoising1(im,im_poisson1,1/4);

im_poisson2=sqrt(im)./sqrt(20)+randn(size(im))*1/4;
figure(5);
rmse_poisson2=myPoissonDenoising2(im,im_poisson2,1/4);

toc;
