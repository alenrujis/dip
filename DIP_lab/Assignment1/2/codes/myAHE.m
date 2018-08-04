function [] = myAHE(filename,flag,N)
% inImgArr = imread('../data/canyon.png');
% flag = 0;
% N = 50;
inImgArr = imread(filename);

%% applying nlfilter
fun = @(x) myAHEhelp(x,N);
if flag==1
outImgArr = nlfilter(inImgArr,[N N],fun);
elseif flag==0
    inImgArrRed = inImgArr(:,:,1);
%     figure(1)
%     imshow(inImgArrRed)
    inImgArrGreen = inImgArr(:,:,2);
%     figure(2)
%     imshow(inImgArrGreen)
    inImgArrBlue = inImgArr(:,:,3);
%     figure(3)
%     imshow(inImgArrBlue)
%%
    A = nlfilter(inImgArrRed,[N,N],fun);
    B = nlfilter(inImgArrGreen,[N,N],fun);
    C = nlfilter(inImgArrBlue,[N,N],fun);
    %%
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