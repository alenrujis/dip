function [RMSD,spg_mat] = myBilateralFiltering(im1,corrupt_im1,ss,si)
%bilateral_filter Summary of this function goes here
% input - Image, sigma-spatial, sigma-intensity
% create corrupt image, apply bilateral filter with given sigmas, calculate
% root squared mean difference between new image and old.
% filename = '../data/barbara.mat';
% ss = 1;
% si = 1;
%load image

%size
[row1,col1] = size(im1);

%initialize new image
new_im1 = zeros(row1,col1);

for i = 1:row1
    for j = 1:col1
        l = floor(j - 3*ss);
        if (l < 1);  l = 1; end
        r = floor(j + 3*ss);
        if (r > col1);  r = col1; end
        t = floor(i - 3*ss);
        if (t < 1);  t = 1; end
        b = floor(i + 3*ss);
        if (b > row1);  b = row1; end
        X = corrupt_im1(t:b,l:r);
        in = X-corrupt_im1(i,j);
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
        sp = sqrt(sp);
        in = exp((-0.5/si^2)*(in.*in));
        sp = exp((-0.5/ss^2)*(sp.*sp));
        wts = in.*sp;
        new_im1(i,j) = sum(sum(wts.*X))/sum(sum(wts));
    end
end

%printing gaussian spatial mask
l = 2*floor(3*ss) + 1;
sp_r = 1:l;
sp_r = sp_r';
sp_r = repmat(sp_r,1,l);
sp_c = 1:l;
sp_c = repmat(sp_c,l,1);
sp_r = sp_r - (floor(3*ss) + 1);
sp_c = sp_c - (floor(3*ss) + 1);
sp_r = sp_r.*sp_r;
sp_c = sp_c.*sp_c;
sp = sp_r + sp_c;
sp = sqrt(sp);
spg_mat = exp((-0.5/ss^2)*(sp.*sp))/(ss*sqrt(2*pi));
    
RMSD = sqrt(mean(mean((new_im1 - im1).^2)));
% RMSD = 0;

myNumOfColors=200;
myColorScale = [(0:1/(myNumOfColors-1):1)',(0:1/(myNumOfColors-1):1)',(0:1/(myNumOfColors-1):1)'];


subplot(1,3,1)
imshow(mat2gray(im1))
colormap(myColorScale);
colormap gray;
colorbar
subplot(1,3,2)
imshow(mat2gray(corrupt_im1))
colormap(myColorScale);
colormap gray;
colorbar
subplot(1,3,3)
imshow(mat2gray(new_im1))
colormap(myColorScale);
colormap gray;
colorbar


end

