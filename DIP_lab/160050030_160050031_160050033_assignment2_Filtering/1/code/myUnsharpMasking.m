function [OutputImage]= myUnsharpMasking(Image,radius,scale)
A = fspecial('gaussian',[5,5], radius);
convolution = imfilter(Image,A,'conv');

matrix = Image + scale*(Image - convolution);
OutputImage = mat2gray(myLinearContrastStretching(matrix));


end



