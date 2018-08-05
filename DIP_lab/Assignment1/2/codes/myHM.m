M1=imread('../data/retinaMask.png');
M2=imread('../data/retinaRefMask.png');
im1=imread('../data/retina.png');
im2=imread('../data/retinaRef.png');

%bIn3Dims = repmat(M1,1,1,3);

r = im1(:, :, 1);
g = im1(:, :, 2);
b = im1(:, :, 3);
r(~M1) = 0; g(~M1) = 0; b(~M1) = 0; 
new_im1= cat(3, r, g, b); 

r1 = im2(:, :, 1);
g1 = im2(:, :, 2);
b1 = im2(:, :, 3);
r1(~M2) = 0; g1(~M2) = 0; b1(~M2) = 0; 
new_im2 = cat(3, r1, g1, b1); 

sum0_1=sum(sum(~M1))*3;
sum0_2=sum(sum(~M2))*3;

M = zeros(256,1,'uint8'); %// Store mapping - Cast to uint8 to respect data type
% hist1=imhist(new_im1);
% hist2=imhist(new_im2);
K=0:256;
histcount_1=histcounts(new_im1,K);
K=0:256;
histcount_2=histcounts(new_im2,K);
cum_1 = cumsum(histcount_1) - sum0_1;
cum_2 = cumsum(histcount_2) - sum0_2;
cdf1 = cum_1/cum_1(end);
cdf2 = cum_2/cum_2(end);

% cdf1 = MyHistogram(new_im1); %// Compute CDFs
% cdf2 = MyHistogram(new_im2);

%// Compute the mapping
for i = 1 : 256
    [~,j] = min(abs(cdf1(i) - cdf2));
    M(i) = j-1;
end

%// Now apply the mapping to get first image to make
%// the image look like the distribution of the second image
out = M(double(new_im1)+1);


subplot(1,3,1);
imshow(im1);
subplot(1,3,2);
imshow(im2);
subplot(1,3,3);
imshow(out);

