function []  = create_mask(iter)
%M Summary of this function goes here
%   Detailed explanation goes here
% iter = 24;
  img=['../data/',num2str(iter),'.ppm'];
  im=imread(img);
  [rows,cols,~] =size(im);
  % im=imresize(im,0.5);
  %%
%   lab = rgb2lab(im);

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
    
    if(abs(im(i,j,1)-im(i,j,2))<20 && abs(im(i,j,1)-im(i,j,3))<20 && abs(im(i,j,2)-im(i,j,3))<30 && im(i,j,1) >110 && im(i,j,2) >110 && im(i,j,3) >110 )
%         sum(im(i,j,:))sum(
%         >60 && -10<=lab(i,j,2)<=10 && -10<=lab(i,j,3)<=10)
         white_mask(i,j)=0;
     else
         white_mask(i,j)=1;
     end
  end
end

SE=strel('rectangle',[3 3]);
BW1=imdilate(red_mask,SE);
red=imerode(BW1,SE);
% BW3=imdilate(white_mask,SE);
% white=imerode(BW3,SE);
% BW5=imdilate(skin_mask,SE);
% skin=imerode(BW5,SE);
skin = skin_mask;
white = white_mask;

%   subplot(2,2,1);
%   imshow(im);
%   subplot(2,2,2);
%   imshow(red);
%   subplot(2,2,3);
%   imshow(white);
%   subplot(2,2,4);
%   imshow(skin);
% end

%Masking done

 [tagimg,tag,xmin,xmax,ymin,ymax,P,A_r]=division(red);
%  [tagimg_w,tag_w,xmin_w,xmax_w,ymin_w,ymax_w,b_count_w,tot_count_w]=division(white);
%  [tagimg_s,tag_s,xmin_s,xmax_s,ymin_s,ymax_s,b_count_s,tot_count_s]=division(skin);

 x=10;
 
%  A_r=zeros(1,tag);
 A_s=zeros(1,tag);
 A_w=zeros(1,tag);
  R=zeros(1,tag);
%   P=zeros(1,tag);
 neta=zeros(1,tag);
  gamma=zeros(1,tag);
     zeta=zeros(1,tag);

 count_w= zeros(1,tag);
 count_s= zeros(1,tag);
 pw=zeros(1,tag);
 ps=zeros(1,tag);
 for i=1:tag
    if A_r(i) > x 
        
         
     
        R(i)=4*pi*A_r(i)/(P(i)*P(i)); 
        gamma(i)=(xmax(i)-xmin(i))/(ymax(i)-ymin(i));
        neta(i)=max(gamma(i),1/gamma(i));
        zeta(i)=A_r(i)/((xmax(i)-xmin(i)) *(ymax(i)-ymin(i)));
        
        A_w(i)=10*(xmax(i)-xmin(i)) *(ymax(i)-ymin(i));
        A_s(i)=12*(xmax(i)-xmin(i)) *6*(ymax(i)-ymin(i));
        
        %put conditions on this%
        
        count_w(i)=0;
        mx=(xmax(i)-xmin(i))/2;
        my=(ymax(i)-ymin(i))/2;
        mx = round(mx,0);
        my=round(my,0);
        for a=max(1,round(xmin(i)-9*mx,0)):min(round(xmax(i) + 9*mx,0),cols)
%         for a=max(1i,xmin(i) - ):min([mx + 30 , cols])
%             display(a);
            for b=max(1,ymin(i)):min(ymax(i),rows)
                if white(b,a) == 0
                   count_w(i)=count_w(i)+1; 
                end   
            end
        end
%         idx = white(max(1,ymin(i)):min(ymax(i),563),)
         count_s(i)=0;

        for c=max(1,round(xmin(i)-11*mx,0)):min(round(xmax(i) +11*mx,0),cols)
%         for c = max([mx -100,1]):min([mx + 100, cols])
            for d=max(1,ymin(i) - 5*my):min(ymax(i) + 5*my,rows)
                if skin(d,c)== 0
                   count_s(i)=count_s(i)+1; 
                end   
            end
        end
        
        pw(i)=count_w(i)/A_w(i);
        ps(i)=count_s(i)/A_s(i);    
        
        
    end
 end
 
 test_r = R > 0.03;
 test_n = neta < 2;
 test_z = zeta > 0.5;
 test_w = pw > 0;
 test_s = ps > 0.1;
 
 test_final = test_r & test_n & test_z & test_s & test_w;
 
 
 for t=1:tag
     if test_final(t) == 1
         for i=1:rows
             for j=1:cols
                 if tagimg(i,j) == t
                     x = (im(i,j,2) + im(i,j,3))/2;
                     if x < 50
                         im(i,j,1) = x;
                     end
                         
                 end
             end
         end
         im(ymin(t):ymax(t),xmin(t):xmax(t)) = imgaussfilt3(im(ymin(t):ymax(t),xmin(t):xmax(t)));
     end
 end
 figure1 = figure;
 subplot(2,2,1)
 imshow(img);
 subplot(2,2,2)
 imshow(red)
 subplot(2,2,3)
 imshow(im)
 subplot(2,2,4)
 imshow(white)

 saveas(figure1,['../corrected/',num2str(iter),'.ppm'])
 close all;
end
 
 
