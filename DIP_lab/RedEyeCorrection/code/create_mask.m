% function [red_mask, white_mask, skin_mask]  = create_mask(img)
%M Summary of this function goes here
%   Detailed explanation goes here
  img='../data/8.ppm';
  im=imread(img);
  [rows,cols,~] =size(im);
  % im=imresize(im,0.5);
  %%
  lab = rgb2lab(im);

  % using lab color space and find red where a is greater than 25
  % red_mask=lab(:,:,2)<25;
  hsv = rgb2hsv(im);
skin_mask=zeros(rows,cols);
red_mask=zeros(rows,cols);
white_mask=zeros(rows,cols);
hsv(:,:,1)=hsv(:,:,1)*180;
hsv(:,:,2)=hsv(:,:,2)*255;
hsv(:,:,3)=hsv(:,:,3)*255;
for i=1:rows
  for j=1:cols
    if(im(i,j,1)>95 && im(i,j,2)>40 && im(i,j,3)>20 && (max(max(im(i,j,1), im(i,j,2)), im(i,j,3) ) - min(min( im(i,j,1), im(i,j,2)),   im(i,j,3) )) >15 && abs(im(i,j,1)-im(i,j,2)) >15 && im(i,j,1) >im(i,j,2) && im(i,j,1) > im(i,j,3) )
      skin_mask(i,j)=0;
    else
      skin_mask(i,j)=1;
    end
    if( ((hsv(i,j,1)>=0 && hsv(i,j,1) <=10) || (hsv(i,j,1) >=170 && hsv(i,j,1) <=180)) && hsv(i,j,2) > 130 && hsv(i,j,3) > 50  )
      red_mask(i,j)=0;
    else
      red_mask(i,j)=1;
    end
    
    if(im(i,j,1)>150 && im(i,j,2)>120 && im(i,j,3)>140)
%         sum(im(i,j,:))sum(
%         >60 && -10<=lab(i,j,2)<=10 && -10<=lab(i,j,3)<=10)
         white_mask(i,j)=0;
     else
         white_mask(i,j)=1;
     end
  end
end
  subplot(2,2,1);
  imshow(im);
  subplot(2,2,2);
  imshow(red_mask);
  subplot(2,2,3);
  imshow(white_mask);
  subplot(2,2,4);
  imshow(skin_mask);
% end