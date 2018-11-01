function rmse = myPoissonDenoising1(im, im1, sigma)
    %MYPCADENOISING2 Summary of this function goes here
    %   Detailed explanation goes here
    % outputArg1 = inputArg1;
    % outputArg2 = inputArg2;
    
    % im = imread('../data/barbara256.png');
    % im=double(im);
    % sigma=20;
    % im1 = im+randn(size(im))*sigma;
    [rows,cols]=size(im1);
    N=1;
    K=200;
    
    P=zeros(49,rows-6*cols-6);
    P_reconst=P;
    for i=1:rows-6
        for j=1:cols-6
            P(:,N)=reshape(im1(i:i+6,j:j+6), 49,1);
            N=N+1;
        end
    end
    N=N-1;
    
    im2_a=zeros(rows,cols);
    im2_b=zeros(rows,cols);
    
    for i=1:rows-6
        for j=1:cols-6
            l=(i-1)*(rows-6)+j;
            xMin = max(i-15,1);
            xMax = min(i+15,rows-6);
            yMin = max(j-15,1);
            yMax = min(j+15,cols-6);
    
            for a=xMin:xMax
                for b=yMin:yMax
                    Q(:,(xMax-xMin+1)*(a-xMin) + (b-yMin+1)) = P(:,(a-1)*(rows-6)+b);
                end
            end
            
            [IDX, D]=knnsearch(Q',P(:,l)', 'K',K);
            Q=Q(:,IDX);
    
            Q1=Q*Q';
            [V,D]=eig(Q1);
            alpha=V'*Q;
    
            alphasq=max(0,diag(alpha*alpha')/K-sigma*sigma);
    
            div=(((alphasq/(sigma*sigma)).^(-1))+1).^(-1);
            alpha_denoised=diag(div)*alpha(:,1);
    
            P_reconst(:,l)=V*alpha_denoised;
    
            im2_a(i:i+6, j:j+6)=im2_a(i:i+6, j:j+6)+ reshape(P_reconst(:, (i-1)*(rows-6)+j), 7, 7);
            im2_b(i:i+6, j:j+6)=im2_b(i:i+6, j:j+6)+1;
        end
        
    end
    
    % for i=1:250
    %     for j=1:250
    
    %     end
    % end
    
    im2=im2_a./im2_b;

    im2=im2.^2; %%%%%%%%%%%%%%%%%%%element wise square
    
    subplot(1,3,1);
    imshow(im/255);
    title('Original Image');
    subplot(1,3,2);
    imshow(im1.^2/255);
    title('Noised Image')
    subplot(1,3,3);
    imshow(im2/255);
    title('PCA Denoised1 poisson Image')
    
    A=double(im2)-double(im);
    A=A.*A;
    rmse=sqrt(sum(A(:))/(rows*cols));
    end
    
    