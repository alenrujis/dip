%% MyMainScript

tic;
%% Your code here
figure('name','0.001')
myPatchBasedFiltering('../data/barbara.mat',0.001,1)
%%
figure('name','0.01')
myPatchBasedFiltering('../data/barbara.mat',0.01,1)
%%
figure('name','0.1')
myPatchBasedFiltering('../data/barbara.mat',0.1,1)
%%
figure('name','1')
myPatchBasedFiltering('../data/barbara.mat',1,1)
%%
figure('name','10')
myPatchBasedFiltering('../data/barbara.mat',10,2,1)
%%
figure('name','100')
myPatchBasedFiltering('../data/barbara.mat',100,1)
%%
toc;
