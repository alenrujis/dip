imgPath = '../data/lionCrop.mat';

Struct = load(imgPath);
Image = Struct.imageOrig;
InputImage = mat2gray(myLinearContrastStretching(Image));
scale = 2;
radius = 2;
A = fspecial('gaussian',[ 5,5], radius);
convolution = imfilter(Image,A,'conv');

matrix = Image + scale*(Image - convolution);
OutputImage = mat2gray(myLinearContrastStretching(matrix));

 subplot(1,2,1);
 imshow(InputImage), colorbar;
 subplot(1,2,2);
 imshow(OutputImage), colorbar;





