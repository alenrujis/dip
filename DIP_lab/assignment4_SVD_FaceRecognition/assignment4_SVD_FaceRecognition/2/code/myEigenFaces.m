% function myEigenFaces(Kvec)
    Kvec=[2, 10, 20, 50, 75, 100, 125, 150, 175];
    image_data=('../../CroppedYale/');
    dir_list=dir(image_data);
    sub_dir=38;
    n_train=40;
    a=192;
    b=168;
    
   X=zeros(a*b, sub_dir*n_train);

   x_iterator=1;
%%

   for i=1:sub_dir
        sub_image_data=strcat(image_data, dir_list(i+2).name, '/');
        image_list=dir(sub_image_data);
    
        for j=1:n_train
            image=imread(strcat(sub_image_data, image_list(j+2).name));
            image=mat2gray(image);
            X(:, x_iterator)=image(:);
            x_iterator=x_iterator+1;
        end
    end

    mean_X=mean(X,2);

    for i=1:sub_dir*n_train
        X(:,i)=X(:,i)-mean_X;
    end

%%
    C=cov(X);
    [V,D]=eig(C);
    VX=X*V;
    VX=normc(VX);
    n=sub_dir*n_train;
    
    figure(1);
    for i= n-25+1:n
        subplot(5,5,n-i+1);
        imshow(mat2gray(reshape(VX(:,i),192,168)));
    end
    title('top 25 eigenfaces'); 
    
%%
    l=2;
    for i=Kvec
        Vi=VX(:,n-i+1:n); %top k eignefaces
        test_im=X(:,1); 
        % test_im=test_im-mean_X; since already mean deducted
        eigenCoeff = Vi'*test_im;   %%kyun??????????
        im=mean_X+Vi*eigenCoeff; %%kyun kia??????????????????????????????????????????/
        figure(l);
        l=l+1;
        subplot(1,2,1);
        imshow(mat2gray(reshape(X(:,1),a,b)));
        title('original image');
        subplot(1,2,2);
        imshow(mat2gray(reshape(im,a,b)));
        title(['reconstructed image for k= ', num2str(i)]);
    end 

    
% end
