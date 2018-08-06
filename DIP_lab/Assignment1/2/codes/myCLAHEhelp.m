function valAtCentre = myCLAHEhelp(inp_array, N, clipLimit)
%MYCLAHEHELP Summary of this function goes here
%   Detailed explanation goes here

[row,col] = find(inp_array); % find the positions of all non zero element
unpad_array = inp_array(min(row):max(row),min(col):max(col));

K=0:256;
bincount=histcounts(unpad_array, K,'Normalization','pdf');
excess=0;
for i=1:256
    if bincount(i)>clipLimit
        excess=excess+bincount(i)-clipLimit;
        bincount(i)=clipLimit;
    end
end
excess=excess/256;
for i=1:256
   %% if bin_count(i)>clipLimit
   bincount(i)=bincount(i)+excess;
    %%end
end




T = MyHistogram(unpad_array);
x = floor((N+1)/2);
% x = cast(x,'uint8');
valAtCentre = T(inp_array(x,x)+1);

end

