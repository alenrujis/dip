function value = appKernal(x,i,j,X,hs,hr)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

j1 = x/256;
j1 = floor(j1) + 1;
i1 = rem(x,256);
a = (j-1)*256 + i;

value = exp(-((i-i1)^2+(j-j1)^2)/hs^2)*exp(-sumsqr(X(a,:)-X(x,:))/hr^2);
end

