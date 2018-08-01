%% MyMainScript

tic;
%% Your code here
%nlfilter;
% colfilt;
% blockproc;
figure(1)
title('d = 2')
myShrinkImageByFactorD('../data/circles_concentric.png',2);
figure(2)
title('d = 3')
myShrinkImageByFactorD('../data/circles_concentric.png',3);
figure(3)
myBilinearInterpolation('../data/barbaraSmall.png')
figure(4)
myNearestNeighborInterpolation('../data/barbaraSmall.png')
toc;
