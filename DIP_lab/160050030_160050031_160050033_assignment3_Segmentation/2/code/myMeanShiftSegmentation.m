function [] = myMeanShiftSegmentation(filename,hr,hs,nitr,nnbr)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%%%%%%%%Test block%%%%%%%%%%%%%
% filename = '../data/baboonColor.png';
%  hr = 250;
%  hs = 100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% read image
im= imread(filename);
% im=mat2gray(im);
% filter image
im = imgaussfilt(im,1);
% resize image
im=imresize(im,.5);


[row,col,~] = size(im);
% upImg = zeros(row,col,3);
% selecting n nearest neighbours
% n = 75;

% gradient steps
% tau = 3;

wait = waitbar(0,'Wait');

%%%
feature=zeros(5,row*col);

for i = 1:row
    for j=1:col
        feature(:,i*col - col +j)=[i;j;im(i,j,1); im(i,j, 2); im(i,j,3);];
    end
end
X=feature';
X = cast(X,'double');
X(:, 3:5) = X(:, 3:5)/(hr);
X(:, 1:2) = X(:, 1:2)/(hs);

   	
for z = 1:nitr
%     X(:, 3:5) = X(:, 3:5)/(hr);
%     X(:, 1:2) = X(:, 1:2)/(hs);
    Mdl = KDTreeSearcher(X);
    [idx,D] = knnsearch(Mdl,X,'K',nnbr); % finding indexes of k nearest nbrs to (i,j) pixel by color
    res = exp(-(D.^2));            
    suma=sum(res,2);
%     X(:, 3:5) = X(:, 3:5)*(hr);
%     X(:, 1:2) = X(:, 1:2)*(hs);
    X(:,3) = sum(res.*reshape(X(idx(:,:),3),[],nnbr),2)./suma;
    X(:,4) = sum(res.*reshape(X(idx(:,:),4),[],nnbr),2)./suma;
    X(:,5) = sum(res.*reshape(X(idx(:,:),5),[],nnbr),2)./suma;

    waitbar(z/nitr,wait,'Chill bro, we are still computing..');
end
close(wait)
final_im = zeros(row,col,3);
for i = 1:row
    for j = 1:col
        final_im(i,j,:) = X(i*col-col+j,3:5);
    end
end
%%
%figures
myNumOfColors=200;
myColorScale = [(0:1/(myNumOfColors-1):1)',(0:1/(myNumOfColors-1):1)',(0:1/(myNumOfColors-1):1)'];

subplot(1,2,1);
imshow(imread(filename));
colormap(myColorScale);
subplot(1,2,2);
imshow(final_im);
title(['hr=' num2str(hr) 'hs=' num2str(hs)] )
colormap(myColorScale);
end


