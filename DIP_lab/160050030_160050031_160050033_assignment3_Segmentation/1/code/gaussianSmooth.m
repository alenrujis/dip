function imo = gaussianSmooth(im,ss)
%UNTITLED2 Summary of this function goes here
%return gaussian smoothed image
%   Detailed explanation goes here

%size
[row,col] = size(im);
imo = zeros(row,col);

for i = 1:row
    for j = 1:col
        l = floor(j - 3*ss);
        if (l < 1);  l = 1; end
        r = floor(j + 3*ss);
        if (r > col);  r = col; end
        t = floor(i - 3*ss);
        if (t < 1);  t = 1; end
        b = floor(i + 3*ss);
        if (b > row);  b = row; end
        X = im(t:b,l:r);
        sp_r = 1:b-t+1 ;
        sp_r = sp_r';
        sp_r = repmat(sp_r,1,r-l+1);
        sp_c = 1:r-l+1;
        sp_c = repmat(sp_c,b-t+1,1);
        sp_r = sp_r - (i - t + 1);
        sp_c = sp_c - (j - l + 1);
        sp_r = sp_r.*sp_r;
        sp_c = sp_c.*sp_c;
        sp = sp_r + sp_c;
        sp = exp((-0.5/ss^2)*sp);
        imo(i,j) = sum(sum(sp.*X))/sum(sum(sp));
    end
end
end

