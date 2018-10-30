function []=gaussianfilter(im1,h,w,sigma)
H=zeros(2*h,2*w);

filter1=fspecial('gaussian',[2*h,2*w],sigma);

figure
 imagesc(log(abs(filter1))+1);
title(['gaussianfilter frequency sigma =',num2str(sigma)]);
 colormap(jet);colorbar;
 

newF=im1.*filter1;
inverse=ifft2(fftshift(newF));
realpart=real(inverse);

extract=realpart(h/2+1:h+h/2,w/2+1:w+w/2);
figure
imshow(mat2gray(extract));
title(['gaussianfiltereImage sigma =',num2str(sigma)]);


end