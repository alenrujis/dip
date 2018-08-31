% function [] = myMeanShiftSegmentation(filename,hr,hs,k)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%%%%%%%%Test block%%%%%%%%%%%%%
filename = '../data/baboonColor.png';
hr = 3;
hs = 3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% read image
im= imread(filename);

% filter image
im = imgaussfilt(im,1);

% A = fspecial('gaussian',[5,5], 1);
% convolution = imfilter(im,A,'conv');

% resize image
im=imresize(im,.5);


[row,col,~] = size(im);
upImg = zeros(row,col,3);
% selecting n nearest neighbours
n = 10;

for z = 1:20
%%
    % 3D matrix to 2D matrix
    X = reshape(im,[],3);
    % substep for finding Knn
    X = cast(X,'double');
    Mdl = ExhaustiveSearcher(X);
    for i = 1:row
        for j = 1:col
            idx = knnsearch(Mdl,cast(reshape(im(i,j,:),[],3),'double'),'K',n); % finding indexes of k nearest nbrs to (i,j) pixel by color
            fun = @(x) appKernal(x,i,j,X,hs,hr);
            res = arrayfun(fun,idx); % each element in res is K(space)*K(color) for each nearest nbr to (i,j)
            fun2 = @(x,y) X(x)*y;
            smth = arrayfun(fun2,idx,res);
    %         meanShift = sum(smth)/sum(res) - im(i,j,:);
            upImg(i,j,:) = sum(smth)/sum(res);
        end
    end
    im = upImg;
end
%%
% end

