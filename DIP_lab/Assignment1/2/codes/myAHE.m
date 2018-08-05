function [] = myAHE(filename,flag,N)
% inImgArr = imread('../data/canyon.png');
% flag = 0;
% N = 50;
%-----------------------------------------------------------
%Description- Implement AHE on filename with window size N
%-----------------------------------------------------------
inImgArr = imread(filename); % reading the file

%% applying nlfilter
fun = @(x) myAHEhelp(x,N); % function which has to be applied on block in nlfilter
if flag==1 %for black and white images
outImgArr = nlfilter(inImgArr,[N N],fun);
elseif flag==0 %for colored images
    %applying nlfilter on 3 components seperately, after that recombine
    %them
    inImgArrRed = inImgArr(:,:,1);
    inImgArrGreen = inImgArr(:,:,2);
    inImgArrBlue = inImgArr(:,:,3);
%%
    A = nlfilter(inImgArrRed,[N,N],fun);
    B = nlfilter(inImgArrGreen,[N,N],fun);
    C = nlfilter(inImgArrBlue,[N,N],fun);
  
    outImgArr(:,:,1) = A;
    outImgArr(:,:,2) = B;
    outImgArr(:,:,3) = C;
end
%% showing image

myNumOfColors=200;
myColorScale = [(0:1/(myNumOfColors-1):1)',(0:1/(myNumOfColors-1):1)',(0:1/(myNumOfColors-1):1)'];
colormap(myColorScale);
if flag==1
    colormap gray;
elseif flag == 0
    colormap jet;
end
   
subplot(1,2,1)
imshow(mat2gray(inImgArr)),colorbar;
subplot(1,2,2)
% if flag==1
imshow(outImgArr),colorbar;
% elseif flag==0
%     imshow(outImgArrC),colorbar;
end