%% MyMainScript

tic;
%% Your code here
figure('Name','Shrinked Image D=2')
title('d = 2')
myShrinkImageByFactorD('../data/circles_concentric.png',2);
figure('Name','Shrinked Image D=3')
title('d = 3')
myShrinkImageByFactorD('../data/circles_concentric.png',3);
figure('Name','Bilinear Interpolation')
myBilinearInterpolation('../data/barbaraSmall.png')
figure('Name','Nearest Neighbourhood Interpolation')
myNearestNeighborInterpolation('../data/barbaraSmall.png')
toc;
