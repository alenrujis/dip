%% MyMainScript

tic;
%% Your code here
figure(1)
[a1,mat_fltr] = myBilateralFiltering('../data/grassNoisy.mat',2,15,2);
figure(2)
% [a2,~] = myBilateralFiltering('../data/grassNoisy.mat',2,12,2);
% figure(3)
% [a3,~] = myBilateralFiltering('../data/grassNoisy.mat',2,13,2);
figure(4)
imshow(mat_fltr)
colorbar
toc;
