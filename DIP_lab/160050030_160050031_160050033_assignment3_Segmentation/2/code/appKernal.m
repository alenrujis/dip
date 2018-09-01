function value = appKernal(x,i,j,y,hs,hr,row)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

j1 = x/row;
j1 = floor(j1) + 1;
i1 = rem(x,row);

value = exp(-((i-i1)^2+(j-j1)^2)/hs^2)*exp(-y^2/hr^2);
end

