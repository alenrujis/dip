function [] = myHE(img,flag)
%MYHE Summary of this function goes here
%   Detailed explanation goes here

    image=imread(img);
    if flag==1
        eqhisto=MyHistogram(image)*255;
        new_image=eqhisto(image+1);
        
%         figure
        subplot(1,2,1);
        imshow(image);
        
        subplot(1,2,2);
        imshow(mat2gray(new_image));
        
    else
        image_red=image(:,:,1);
        image_green=image(:,:,2);
        image_blue=image(:,:,3);
        eqhist_red=MyHistogram(image_red)*255;
        new_image_red = eqhist_red(image_red+1);
        eqhist_green=MyHistogram(image_green)*255;
        new_image_green = eqhist_green(image_green+1);
        eqhist_blue=MyHistogram(image_blue)*255;
        new_image_blue = eqhist_blue(image_blue+1);
        new_image(:,:,1) = new_image_red;
        new_image(:,:,2) = new_image_green;
        new_image(:,:,3) = new_image_blue;
        
%         figure
        subplot(1,2,1);
        imshow(image);
        
        subplot(1,2,2);
        imshow(mat2gray(new_image));
        
        
    end
end



