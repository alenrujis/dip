%% MyMainScript

tic;
%% Your code here
load('../data/boat.mat')
imageOrig = imageOrig/256;

myHarrisCornerDetector(imageOrig,2,2,0.05);
toc;
