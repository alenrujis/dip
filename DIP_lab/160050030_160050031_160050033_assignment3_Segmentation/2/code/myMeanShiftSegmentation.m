% function [] = myMeanShiftSegmentation(filename,hr,hs,k)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%%%%%%%%Test block%%%%%%%%%%%%%
filename = '../data/baboonColor.png';
 hr = 80;
 hs = 40;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% read image
im= imread(filename);
% im=mat2gray(im);
% filter image
im = imgaussfilt(im,1);
% resize image
im=imresize(im,.5);


[row,col,~] = size(im);
upImg = zeros(row,col,3);
% selecting n nearest neighbours
n = 75;

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
    % 3D matrix to 2D matrix
%     X = reshape(feature,[],3);
    % substep for finding Knn
    X = cast(X,'double');
    X(:, 3:5) = X(:, 3:5)/(hr);
    X(:, 1:2) = X(:, 1:2)/(hs);
   	
for z = 1:5
    Mdl = KDTreeSearcher(X);
    [idx,D] = knnsearch(Mdl,X,'K',n); % finding indexes of k nearest nbrs to (i,j) pixel by color
    weight = exp(-(D.^2));
    % upImg=zeros(row,col,3);
    for i = 1:row
        for j = 1:col
            p=i*col-col+j;
            res=weight(p,:);
            suma=sum(res);
%%%%%%%%%%%%%%%%%%%%%%%yeh bhiu dekh%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % res=res';
            % res_mat=[res,res,res];
            % X(p,3:5)=sum(res_mat.*X(idx(p,:),3:5))/suma;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
            
%             fun = @(x,y) appKernal(x,i,j,y,hs,hr);
%             res = arrayfun(fun,idx,D); % each element in res is K(space)*K(color) for each nearest nbr to (i,j)
%              fun2 = @(x,y) X(x*col-col+j,3:5)*[y,y,y];
%              smth = arrayfun(fun2,idx,res,'un',0);
%         meanShift = sum(smth)/sum(res) - im(i,j,:);
            fun = @(x,y) X(x,3:5)*y;
            temp= arrayfun(fun,idx(p,:),res,'un',0);
            X(p,3:5) = sum(reshape(cell2mat(temp),3,[]),2)/suma;
%             upImg(i,j,1) = rgb(1);
%             upImg(i,j,2) = rgb(2);
%             upImg(i,j,3) = rgb(3);
        end
    end
    % im = upImg;
    waitbar(z/20,wait,'chalne do');
end
close(wait)
final_im = zeros(row,col,3);
for i = 1:row
    for j = 1:col
        final_im(i,j,:) = X(i*col-col+j,3:5);
    end
end
%%
figure(1);
imshow(final_im);
% end

