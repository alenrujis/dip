function []=myLinearContrastStretching(img,flag)
    image=imread(img);
    if flag==0
        
        min1=min(min(image));
        max1=max(max(image));
        new_image = round((image-min1)*(255/(max1-min1)));
        myNumOfColors=200;
        myColorScale = [(0:1/(myNumOfColors-1):1)',(0:1/(myNumOfColors-1):1)',(0:1/(myNumOfColors-1):1)'];
        colormap(myColorScale);
        colormap gray;
        subplot(1,2,1);
        imshow(image),colorbar;
        subplot(1,2,2);
        imshow(new_image),colorbar;
    else 
        I_red= image(:,:,1);
        I_green = image(:,:,2);
        I_blue = image(:,:,3);

        min1_red=min(min(I_red));
        max1_red=max(max(I_red));
        New_I_red=round((I_red-min1_red)*(255/(max1_red-min1_red)));

        min1_green=min(min(I_green));
        max1_green=max(max(I_green));
        New_I_green=round((I_green-min1_green)*(255/(max1_green-min1_green)));

        min1_blue=min(min(I_blue));
        max1_blue=max(max(I_blue));
        New_I_blue=round((I_blue-min1_blue)*(255/(max1_blue-min1_blue)));

        New_I_colored(:,:,1) = New_I_red;
        New_I_colored(:,:,2) = New_I_green;
        New_I_colored(:,:,3) = New_I_blue;
        
        myNumOfColors=200;
        myColorScale = [(0:1/(myNumOfColors-1):1)',(0:1/(myNumOfColors-1):1)',(0:1/(myNumOfColors-1):1)'];
        colormap(myColorScale);
        colormap jet;
        subplot(1,2,1);
        imshow(image),colorbar;
        subplot(1,2,2);
        imshow(New_I_colored),colorbar;
        
        
    end


        
end
