function [] = myHarrisCornerDetector(im,s1,s2,k)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%%
%%%%%%%%%%%%%%Testing Block%%%%%%%%%%%%%%%%%%%
% load('../data/boat.mat')
% im = imageOrig/256;
% s1 = 2;
% s2 = 2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%size
[row,col] = size(im);
img1 = gaussianSmooth(im,s1); %smoothing 1

%X derivative
imgx = sobelOp(img1,'x');
% Y derivative
imgy = sobelOp(img1,'y');

imgx2 = imgx.*imgx;
imgy2 = imgy.*imgy;
imgxy = imgx.*imgy;
A11 = zeros(row,col);
A12 = zeros(row,col);
A22 = zeros(row,col);
for i = 1:row
    for j = 1:col
        l = floor(j - 3*s2);
        if (l < 1);  l = 1; end
        r = floor(j + 3*s2);
        if (r > col);  r = col; end
        t = floor(i - 3*s2);
        if (t < 1);  t = 1; end
        b = floor(i + 3*s2);
        if (b > row);  b = row; end
        A11t = imgx2(t:b,l:r);
        A12t = imgxy(t:b,l:r);
        A22t = imgy2(t:b,l:r);
        sp_r = 1:b-t+1 ;
        sp_r = sp_r';
        sp_r = repmat(sp_r,1,r-l+1);
        sp_c = 1:r-l+1;
        sp_c = repmat(sp_c,b-t+1,1);
        sp_r = sp_r - (i - t + 1);
        sp_c = sp_c - (j - l + 1);
        sp_r = sp_r.*sp_r;
        sp_c = sp_c.*sp_c;
        sp = sp_r + sp_c;
        sp = exp((-0.5/s2^2)*sp);
        sp_sum = sum(sum(sp));
        A11(i,j) = sum(sum(A11t.*sp))/sp_sum;
        A12(i,j) = sum(sum(A12t.*sp))/sp_sum;
        A22(i,j) = sum(sum(A22t.*sp))/sp_sum;
    end
end

%% Harris corner-ness measure
% k = 0.05;
trace = A11+A22;
C = A11.*A22 - A12.^2 - k*(trace.^2);
C = C/max(max(C));
%% eigenvalues

eigen1 = (A11+A22 + sqrt((A11-A22).^2 + 4*A12.^2))/2;
eigen2 = (A11+A22 - sqrt((A11-A22).^2 + 4*A12.^2))/2;

%figures
myNumOfColors=200;
myColorScale = [(0:1/(myNumOfColors-1):1)',(0:1/(myNumOfColors-1):1)',(0:1/(myNumOfColors-1):1)'];

figure(1)

imshow(mat2gray(imgx))
colormap(myColorScale);
colormap gray;

figure(2)

imshow(mat2gray(imgy))
colormap(myColorScale);
colormap gray;

figure(3)

imshow(mat2gray(eigen1))
colormap(myColorScale);
colormap gray;
colorbar

figure(4)

imshow(mat2gray(eigen2))
colormap(myColorScale);
colormap gray;
colorbar
%%
figure(5)

imshow(C)
colormap(myColorScale);
colormap gray;
colorbar

end

