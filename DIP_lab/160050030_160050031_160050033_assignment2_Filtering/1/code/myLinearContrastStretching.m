function matrix = myLinearContrastStretching(imgmatrix)

[ a, b, dimension] = size(mat2gray(imgmatrix));
if dimension==1
    max1 = max(max(imgmatrix));
	min1 = min(min(imgmatrix));
    matrix = (255/(max1- min1))*(imgmatrix-min1); 
else	
        
   	    max1 = max(max(imgmatrix(:,:,1)));
		min1 = min(min(imgmatrix(:,:,1)));
	    matrix(:,:,1) = (255/(max1- min1))*(imgmatrix(:,:,1)-min1);
        
        
   	    max2 = max(max(imgmatrix(:,:,2)));
		min2 = min(min(imgmatrix(:,:,2)));
	    matrix(:,:,2) = (255/(max2- min2))*(imgmatrix(:,:,2)-min2);
        
        
   	    max3 = max(max(imgmatrix(:,:,3)));
		min3 = min(min(imgmatrix(:,:,3)));
	    matrix(:,:,3) = (255/(max3- min3))*(imgmatrix(:,:,3)-min3);
        	
end
