%Mask for original image(binary)
M1=imread('../data/retinaMask.png');
%Mask for reference image(binary)
M2=imread('../data/retinaRefMask.png');
%original image
im1=imread('../data/retina.png');
%refrence image
im2=imread('../data/retinaRef.png');

%////////////////////
% makes the value of the pixels of original image zero where pixels values of mask is zero.  
r = im1(:, :, 1);
g = im1(:, :, 2);
b = im1(:, :, 3);
r(~M1) = 0; g(~M1) = 0; b(~M1) = 0; 
new_im1= cat(3, r, g, b); 

%/////////////////////

%/////////////////////
% makes the value of the pixels of refrence image zero where pixels values of mask is zero

r1 = im2(:, :, 1);
g1 = im2(:, :, 2);
b1 = im2(:, :, 3);
r1(~M2) = 0; g1(~M2) = 0; b1(~M2) = 0; 
new_im2 = cat(3, r1, g1, b1); 

%////////////////////
%////////////////////
%finding number of pixels of zero intensity in mask
sum0_1=sum(sum(~M1))*3;
sum0_2=sum(sum(~M2))*3;
%////////////////////


M = zeros(256,1,'uint8'); %// Store mapping - Cast to uint8 to respect data type

K=0:256; %bins 0-1,1-2,...
histcount_1=histcounts(new_im1,K); %counts number of pixels in each bin of histogram
K=0:256;
histcount_2=histcounts(new_im2,K);%counts number of pixels in each bin of histogram
cum_1 = cumsum(histcount_1) - sum0_1; %subtracts the pixels of value 0
cum_2 = cumsum(histcount_2) - sum0_2; %subtracts the pixels of value 0
cdf1 = cum_1/cum_1(end); %cdf of original image after masking out
cdf2 = cum_2/cum_2(end); %cdf of refrence image after masking out


% Compute the mapping
for i = 1 : 256
    [~,j] = min(abs(cdf1(i) - cdf2));
    M(i) = j-1;
end

% Now apply the mapping to get first image to make
% the image look like the distribution of the second image
out = M(double(new_im1)+1);


subplot(1,3,1);
imshow(im1);
subplot(1,3,2);
imshow(im2);
subplot(1,3,3);
imshow(out);

