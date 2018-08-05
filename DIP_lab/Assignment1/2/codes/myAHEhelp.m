function valAtCentre = myAHEhelp(inp_array,N)
% -----------------------------------------------------------------------------
% apply global histogram in inp_array and returns the transformed value at
% ((N+1)/2, (N+1)/2).
%------------------------------------------------------------------------------

% inp_array = imread('../data/canyon.png');
% inImgArrRed = inp_array(:,:,1);
% inImgArrGreen = inp_array(:,:,2);

% [row,col] = size(inp_array);
% x = round((row+1)/2);
% y = round((col+1)/2);

%% Removal of Padding (for boundary pixel we have to calculate histogram only on those pixel which are inside)
[row,col] = find(inp_array); % find the positions of all non zero element
unpad_array = inp_array(min(row):max(row),min(col):max(col));
%Applying global histogram equalisation on updated array
T = MyHistogram(unpad_array);
x = floor((N+1)/2);
% x = cast(x,'uint8');
valAtCentre = T(inp_array(x,x)+1);
end

