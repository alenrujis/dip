%% MyMainScript

tic;
%% Your code here

%Loading barbara original and corrupt it
load('../data/barbara.mat')
im_a = imageOrig;

max1 = max(max(im_a));
min1 = min(min(im_a));
range1 = max1 - min1;
curr_a = normrnd(im_a,0.05*range1);

%loading original grass and noisy
im_b = imread('../data/grass.png');
im_b = double(im_b)/256;
load('../data/grassNoisy.mat')
curr_b = imgCorrupt;

%loading original honeycomb and noisy
im_c = imread('../data/honeyCombReal.png');
im_c = double(im_c)/256;
load('../data/honeyCombReal_Noisy.mat')
curr_c = imgCorrupt;

figure(1)
[a1,sp_1] = myBilateralFiltering(im_a,curr_a,1.5,9.5);
%%
% [a1_1,~] = myBilateralFiltering(im_a,curr_a,1.5*0.9,9.5);
% [a1_2,~] = myBilateralFiltering(im_a,curr_a,1.5*1.1,9.5);
% [a1_3,~] = myBilateralFiltering(im_a,curr_a,1.5,9.5*0.9);
% [a1_4,~] = myBilateralFiltering(im_a,curr_a,1.5,9.5*1.1);
%%
figure(2)
[a2,sp_2] = myBilateralFiltering(im_b,curr_b,0.9,0.14);
%%
% [a2_1,~] = myBilateralFiltering(im_b,curr_b,0.9*0.9,0.14);
% [a2_2,~] = myBilateralFiltering(im_b,curr_b,0.9*1.1,0.14);
% [a2_3,~] = myBilateralFiltering(im_b,curr_b,0.9,0.14*0.9);
% [a2_4,~] = myBilateralFiltering(im_b,curr_b,0.9,0.14*1.1);
%%

figure(3)
[a3,sp_3] = myBilateralFiltering(im_c,curr_c,1,0.13);
%%
% [a3_1,~] = myBilateralFiltering(im_c,curr_c,1*0.9,0.13);
% [a3_2,~] = myBilateralFiltering(im_c,curr_c,1*1.1,0.13);
% [a3_3,~] = myBilateralFiltering(im_c,curr_c,1,0.13*0.9);
% [a3_4,~] = myBilateralFiltering(im_c,curr_c,1,0.13*1.1);

%%

figure(4)
imshow(sp_1)
colorbar

figure(5)
imshow(sp_2)
colorbar

figure(6)
imshow(sp_3)
colorbar
toc;
