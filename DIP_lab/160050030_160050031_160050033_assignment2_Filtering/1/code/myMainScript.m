%% MyMainScript

tic;
%% Your code here
imgPath1 = '../data/lionCrop.mat';
Struct = load(imgPath1);
Image1 = Struct.imageOrig;
InputImage = mat2gray(myLinearContrastStretching(Image1));
radius1=2;
scale1=2;
OutputImage=myUnsharpMasking(Image1,radius1,scale1);
	figure
subplot(1,2,1);
 imshow(InputImage), colorbar;
 subplot(1,2,2);
 imshow(OutputImage), colorbar;

 
 
imgPath2 = '../data/superMoonCrop.mat';
Struct2 = load(imgPath2);
Image2 = Struct2.imageOrig;
InputImage2 = mat2gray(myLinearContrastStretching(Image2));
radius2=2;
scale2=2;
OutputImage2=myUnsharpMasking(Image2,radius2,scale2);
	figure
subplot(1,2,1);
 imshow(InputImage2), colorbar;
 subplot(1,2,2);
 imshow(OutputImage2), colorbar;








toc;
