function rmsd = myPCADenoising1()
%MYPCA Summary of this function goes here
%   Detailed explanation goes here
% outputArg1 = inputArg1;
% outputArg2 = inputArg2;

im = imread('../data/barbara256.png');
im=double(im);
sigma=20;
im1 = im+randn(size(im))*sigma;
[rows,cols]=size(im1);
N=1;
P=zeros(49,rows-6*cols-6);
for i=1:rows-6
    for j=1:cols-6
        P(:,N)=reshape(im1(i:i+6,j:j+6), 49,1);
        N=N+1;
    end
end
N=N-1;

P1=P*P';
[V, D]=eig(P1);
alpha=V'*P;

alphasq=zeros(1,49);
for i=1:49
    alphasq(i)=max(0,sum(alpha(i,:)*(alpha(i,:)'))*(1/N)-sigma*sigma);
end

alpha_denoised=zeros(49,rows-6*cols-6);
for i=1:49
    for j=1:N
        alpha_denoised(i,j)=alpha(i,j)/(1+((sigma*sigma)/alphasq(i)));
    end
end

P_reconst = V*alpha_denoised;  %%reconstructed image

im2_a=zeros(rows,cols);
im2_b=zeros(rows,cols);
for i=1:rows-6
    for j=1:cols-6
        im2_a(i:i+6, j:j+6)=im2_a(i:i+6, j:j+6)+ reshape(P_reconst(:, (i-1)*(rows-6) +j), 7, 7);
        im2_b(i:i+6, j:j+6)=im2_b(i:i+6, j:j+6)+1;
    end
end

im2=im2_a./im2_b;
subplot(1,3,1);
imshow(im/255);
subplot(1,3,2);
imshow(im1/255);
subplot(1,3,3);
imshow(im2/255);

A=double(im2)-double(im);
A=A.*A;
rmsd=sqrt(sum(A(:))/(rows*cols));
end