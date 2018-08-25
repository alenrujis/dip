%% MyMainScript

tic;
%% Your code here
%Loading barbara original and corrupt it
load('../data/barbara.mat')
im_a = imageOrig;
im_a = im_a(1:2:end,1:2:end);
max1 = max(max(im_a));
min1 = min(min(im_a));
range1 = max1 - min1;
curr_a = normrnd(im_a,0.05*range1);
curr_a = curr_a(1:2:end,1:2:end);

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

%%
figure(1)
a1 = myPatchBasedFiltering(im_a,curr_a,2,2);
%%
figure(2)
a2 = myPatchBasedFiltering(im_b,curr_b,1,2);
%%
figure(3)           
a3 = myPatchBasedFiltering(im_c,curr_c,0.15,2);
%%
% figure('name','0.001')
% myPatchBasedFiltering('../data/barbara.mat',0.001,1)
% %%
% figure('name','0.01')
% myPatchBasedFiltering('../data/barbara.mat',0.01,1)
% %%
% figure('name','0.1')
% myPatchBasedFiltering('../data/barbara.mat',0.1,1)
% %%
% figure('name','1')
% myPatchBasedFiltering('../data/barbara.mat',1,1)
% %%
% figure('name','10')
% myPatchBasedFiltering('../data/barbara.mat',10,2,1)
% %%
% figure('name','100')
% myPatchBasedFiltering('../data/barbara.mat',100,1)
%%
toc;
