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

subplot(1,2,1)
imshow(mat2gray(img_arr))
% daspect([1 1 1]);
% axis tight;
colorbar
subplot(1,2,2)
imshow(mat2gray(shrinked_img))
% daspect([1 1 1]);
% axis tight;
colorbar

% end

