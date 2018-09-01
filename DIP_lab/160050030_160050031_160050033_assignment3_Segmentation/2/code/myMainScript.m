%% MyMainScript

tic;
%% Your code here
% no resizing of image done
% myMeanShiftSegmentation(filename, hr, hs, number_of_iteration, number_of_neighbour);
figure(1)
myMeanShiftSegmentation('../data/baboonColor.png', 150, 100, 40, 300);
% figure(2)
% myMeanShiftSegmentation('../data/baboonColor.png', 500, 100, 20, 100);
% figure(3)
% myMeanShiftSegmentation('../data/baboonColor.png', 250, 200, 20, 100);
% figure(4)
% myMeanShiftSegmentation('../data/baboonColor.png', 250, 100, 40, 100);
% figure(5)
% myMeanShiftSegmentation('../data/baboonColor.png', 250, 100, 20, 500);
%%
toc;
