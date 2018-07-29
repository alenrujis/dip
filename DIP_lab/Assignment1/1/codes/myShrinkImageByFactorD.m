function[] = myShrinkImageByFactorD(input_img,d)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
img_arr = imread(input_img);
[x,y] = size(img_arr);
x_new = 1:d:x;
y_new = 1:d:y;
shrinked_img = img_arr(x_new,y_new);
myNumOfColors=200;
myColorScale = [(0:1/(myNumOfColors-1):1)',(0:1/(myNumOfColors-1):1)',(0:1/(myNumOfColors-1):1)'];
colormap(myColorScale);
colormap gray;
daspect([1 1 1]);
imagesc(shrinked_img);
axis tight;
colorbar

% end

