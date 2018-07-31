I=imread('../data/barbara.png');
figure, imshow(I);

min1=min(min(I));
max1=max(max(I));
New_I=round((I-min1)*(255/(max1-min1)));

figure, imshow(New_I);

I_colored=imread('../data/canyon.png');
figure, imshow(I_colored);

I_red= I_colored(:,:,1);
I_green = I_colored(:,:,2);
I_blue = I_colored(:,:,3);

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

figure, imshow(New_I_colored);
