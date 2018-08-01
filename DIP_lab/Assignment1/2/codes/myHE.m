function [] = myHE(img,flag)
%MYHE Summary of this function goes here
%   Detailed explanation goes here

    image=imread(img);
    if flag==0
        new_image=histeq(image);
        
        figure
        subplot(2,2,1);
        imshow(image);
        subplot(2,2,2);
        imhist(image);
        subplot(2,2,3);
        imshow(new_image);
        subplot(2,2,4);
        imhist(new_image);
    else
        image_red=image(:,:,1);
        image_green=image(:,:,2);
        image_blue=image(:,:,3);
        
        new_image_red = histeq(image_red);
        new_image_green = histeq(image_green);
        new_image_blue = histeq(image_blue);
        
        new_image(:,:,1) = new_image_red;
        new_image(:,:,2) = new_image_green;
        new_image(:,:,3) = new_image_blue;
        
        figure
        subplot(2,4,1);
        imshow(image);
        subplot(2,4,2);
        imhist(image(:,:,1));
        subplot(2,4,3);
        imhist(image(:,:,2));
        subplot(2,4,4);
        imhist(image(:,:,3));
        
        subplot(2,4,5);
        imshow(new_image);
        subplot(2,4,6);
        imhist(new_image_red);
        subplot(2,4,7);
        imhist(new_image_green);
        subplot(2,4,8);
        imhist(new_image_blue);
        
        
    end
end

