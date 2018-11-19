% function = m(img)
%M Summary of this function goes here
%   Detailed explanation goes here
img='../data/';
im=imread(img);
[rows, cols]=size(im);
red_mask=zeros(rows,cols);

% outputArg2 = inputArg2;
% end