function []=lowpassfilter(im1,h,w,D)
H=zeros(2*h,2*w);

for u=1:D(1)

   for v=1:D(1)
       if u*u+v*v <=D(1)*D(1)
       H(h+u,w+v)=1;
       H(h-u,w+v)=1;
       H(h+u,w-v)=1;
       H(h-u,w-v)=1;     
       end
   end      
end
 figure
 imagesc(log(abs(H)+1));
  title(['LPF frequencyD=',num2str(D)]);
 colormap(jet);colorbar;
 
newF=im1.*H;
inverse=ifft2(ifftshift(newF));
realpart=real(inverse);

extract=realpart(h/2+1:h+h/2,w/2+1:w+w/2);
figure
imshow(mat2gray(extract));
title(['LPF image D=',num2str(D)]);
end
