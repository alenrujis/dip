% function [] = myMeanShiftSegmentation(filename,hr,hs,k)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%%%%%%%%Test block%%%%%%%%%%%%%
filename = '../data/baboonColor.png';
hr = 10;
hs = 10;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% read image
im= imread(filename);

% filter image
im = imgaussfilt(im,1);

% A = fspecial('gaussian',[5,5], 1);
% convolution = imfilter(im,A,'conv');

% resize image
im=imresize(im,.25);


[row,col,~] = size(im);
upImg = zeros(row,col,3);
% selecting n nearest neighbours
n = 10;

% gradient steps
tau = 3;
%%
wait = waitbar(0,'Wait');

for z = 1:20
%%
    % 3D matrix to 2D matrix
    X = reshape(im,[],3);
    % substep for finding Knn
    X = cast(X,'double');
    Mdl = KDTreeSearcher(X);
    for i = 1:row
        for j = 1:col
            [idx,D] = knnsearch(Mdl,cast(reshape(im(i,j,:),[],3),'double'),'K',n); % finding indexes of k nearest nbrs to (i,j) pixel by color
            fun = @(x,y) appKernal(x,i,j,y,hs,hr,row);
            res = arrayfun(fun,idx,D); % each element in res is K(space)*K(color) for each nearest nbr to (i,j)
            fun2 = @(x,y) X(x,:)*y;
            smth = arrayfun(fun2,idx,res,'un',0);
    %         meanShift = sum(smth)/sum(res) - im(i,j,:);
            rgb = sum(reshape(cell2mat(smth),3,[]),2)/sum(res);
            upImg(i,j,1) = tau*(rgb(1) - im(i,j,1)) + im(i,j,1);
            upImg(i,j,2) = tau*(rgb(2) - im(i,j,2)) + im(i,j,2);
            upImg(i,j,3) = tau*(rgb(3) - im(i,j,3)) + im(i,j,3);
        end
    end
    im = upImg;
    waitbar(z/20,wait,'chalne do');
end
close(wait)
%%
% end

