function [] =myNearestNeighborInterpolation(image)
%image = '../data/barbaraSmall.png';
im =imread(image);
[r ,c] = size(im); 
newr=3*r-2;
newc=2*c-1;
newim=zeros(newr,newc);

vec1=1:3:newr;
vec2=1:2:newc;

newim(vec1,vec2) = im;
for i = 1:newr
    for j = 1:newc
        if(mod(i,3) == 1 && mod(j,2) == 0)
            newim(i, j) = newim(i, (j + 1));
        end
    end
end
for i = 1:newr
    for j = 1:newc
        if(mod(i,3) == 2)
            newim(i, j) = newim(i - 1, j);
        elseif(mod(i,3) == 0)
            newim(i, j) = newim(i + 1, j);
        end
    end
end

% myNumOfColors=200;
% myColorScale = [(0:1/(myNumOfColors-1):1)',(0:1/(myNumOfColors-1):1)',(0:1/(myNumOfColors-1):1)'];
% colormap(myColorScale);
% colormap gray;

subplot(1,2,1);
imshow(im),colorbar;
subplot(1,2,2);
imshow(mat2gray(newim)),colorbar;
end