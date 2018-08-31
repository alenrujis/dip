function imd = sobelOp(im,dir)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%Sobel matrix
if dir == 'x'; sobelMat = [-1 0 1;-2 0 2;-1 0 1]; end
if dir == 'y'; sobelMat = [1 2 1; 0 0 0; -1 -2 -1]; end
    
%padding image with the same values at boundary
imt = cat(2,im(:,1),im);
imt = cat(2,imt(:,end),imt);
imt = cat(1,imt(1,:),imt);
imt = cat(1,imt(end,:),imt);

[row,col] = size(im);
imd = zeros(row,col);

for i = 1:row
    for j = 1:col
        m1 = imt(i:i+2,j:j+2).*sobelMat;
        imd(i,j) = abs(sum(sum(m1)));
    end
end
end

