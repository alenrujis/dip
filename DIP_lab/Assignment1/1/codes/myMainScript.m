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
toc;
