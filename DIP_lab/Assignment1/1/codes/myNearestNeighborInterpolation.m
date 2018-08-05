function [] =myNearestNeighborInterpolation(image)
%image = '../data/barbaraSmall.png';
im =imread(image);
[r ,c] = size(im); 
newr=3*r-2;
newc=2*c-1;
newim=zeros(newr,newc);

vec1=1:3:newr;
vec2=1:2:newc;

newim(vec1,vec2) = im;%old image is transferred to expected index of new image

%filling the values of pixel along rows overlaping with old image row by
%pixel value next to it
for i = 1:newr
    for j = 1:newc
        if(mod(i,3) == 1 && mod(j,2) == 0)
            newim(i, j) = newim(i, (j + 1));
        end
    end
end
%filling the values of remaining pixels by the value of pixel above it 
for i = 1:newr
    for j = 1:newc
        if(mod(i,3) == 2)
            newim(i, j) = newim(i - 1, j);
        elseif(mod(i,3) == 0)
            newim(i, j) = newim(i + 1, j);
        end
    end
end

myNumOfColors=200;
myColorScale = [(0:1/(myNumOfColors-1):1)',(0:1/(myNumOfColors-1):1)',(0:1/(myNumOfColors-1):1)'];


subplot(1,2,1);
imagesc(mat2gray(im));    
colormap(myColorScale);
colormap gray;
daspect([1 1 1]);
axis tight;
colorbar

subplot(1,2,2);
imagesc(mat2gray(newim));
colormap(myColorScale);
colormap gray;
daspect([1 1 1]);
axis tight;
colorbar
end