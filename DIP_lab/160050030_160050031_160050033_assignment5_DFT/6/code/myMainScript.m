%% MyMainScript

tic;
%% Your code here

Rectangle = ones(50,70);
x = -30;
y = 70;
%Image I
ImageI = zeros(300,300);
ImageI(51:100,51:120) = Rectangle*255;
%Image J
ImageJ = zeros(300,300);
ImageJ(51+y:100+y,51+x:120+x) = Rectangle*255;

FI = fft2(padarray(ImageI,[150,150]));
FJ = fft2(padarray(ImageJ,[150,150]));
% FI = fftshift(FI);
% FJ = fftshift(FJ);
Cross_pow_num = FI.*conj(FJ);
Cross_pow_den = abs(FI.*FJ);

Cross_pow = Cross_pow_num./Cross_pow_den;
Cross_pow(isnan(Cross_pow)) = 0;
invCp = ifft2(Cross_pow);
invCp = ifftshift(invCp);
[M,I] = max(invCp(:));
[I_row,I_col] = ind2sub(size(invCp),I);

figure(1)

imshow(log(abs(Cross_pow)+1))

%%%

% ImageIG = imnoise(ImageI,'gaussian',0,20);
% ImageJG = imnoise(ImageJ,'gaussian',0,20);
ImageIG = normrnd(ImageI,20);
ImageJG = normrnd(ImageJ,20);
FIG = fft2(padarray(ImageIG,[150,150]));
FJG = fft2(padarray(ImageJG,[150,150]));
% FIG = fftshift(FIG);
% FJG = fftshift(FJG);
Cross_pow_numG = FIG.*conj(FJG);
Cross_pow_denG = abs(FIG.*FJG);

Cross_powG = Cross_pow_numG./Cross_pow_denG;
Cross_powG(isnan(Cross_powG)) = 0;
invCpG = ifft2(Cross_powG);
invCpG = ifftshift(invCpG);
[MG,IG] = max(invCpG(:));
[I_rowG,I_colG] = ind2sub(size(invCpG),IG);

figure(2)

imshow(log(abs(Cross_powG)+1))




toc;
