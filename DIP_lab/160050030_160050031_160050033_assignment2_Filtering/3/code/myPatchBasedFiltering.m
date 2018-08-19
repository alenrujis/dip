function [RMSD] = myPatchBasedFiltering(filename,s, ss,i)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% outputArg1 = inputArg1;
% outputArg2 = inputArg2;
load(filename)
% im1 = imageOrig;
if i == 1
   im1 = imageOrig;
elseif i == 2
    im1 = imgCorrupt;
end
%calculate range
im1=im1(1:2:end, 1:2:end);
max1 = max(max(im1));
min1 = min(min(im1));
range1 = max1 - min1;

%size
[row1,col1] = size(im1);

%corrupting image with gaussian noise with std dev = 5% of range
corrupt_im1 = normrnd(im1,0.05*range1);

%initialize new image
new_im1 = zeros(row1,col1);

windows=25;
patchs=9;

w=(windows-1)/2;
p=(patchs-1)/2;

for i=1:row1
    if((i-w)>=1)
        iwmin=i-w;
    else
        iwmin=1;
    end
    if((i+w)<=row1)
        iwmax=i+w;
    else
        iwmax=row1; 
    end
    
    if((i-p)>=1)
        ipmin=i-p;
    else
        ipmin=1;
    end
    if((i+p)<=row1)
        ipmax=i+p;
    else
        ipmax=row1;
    end
    
    for j=1:col1
        if((j-w)>=1)
            jwmin=j-w;
        else
            jwmin=1;
        end
        if((j+w)<=col1)
            jwmax=j+w;
        else
            jwmax=col1; 
        end
    
        if((j-p)>=1)
            jpmin=j-p;
        else
            jpmin=1;
        end
        if((j+p)<=col1)
            jpmax=j+p;
        else
            jpmax=col1;
        end
        
        % patch((ipmin))=im1(ipmin:ipmax, jpmin:jpmax);

        % for ip1=ipmin:ipmax
        %     for jp1=jpmin:jpmax
        %         patch((ip1-ipmin+1),(jp1-jpmin+1))=im1(ip1,jp1);

        %     end
        % end
        wt = zeros(iwmax-iwmin+1,jwmax-jwmin+1);
%         sum_wt=0;
%         numerator=0;
        for iw=iwmin:iwmax
            if((iw-p)>=1)
                ipmin1=iw-p;
            else
                ipmin1=1;
            end
            if((iw+p)<=row1)
                ipmax1=iw+p;
            else
                ipmax1=row1;
            end
             
            for jw=jwmin:jwmax
                if((jw-p)>=1)
                    jpmin1=jw-p;
                else
                    jpmin1=1;
                end
                if((jw+p)<=col1)
                    jpmax1=jw+p;
                else
                    jpmax1=col1;
                end
                % (1:ipmax-ipmin+1, 1:jpmax-ipmin+1)
                % (1:ipmax1-ipmin1+1,1:jpmax1-jpmin1+1)
                if ipmax-ipmin==9 && jpmax-jpmin==9
                    %display(i);
                    %display(iw);
                    %display(ipmin1);
                    %display(ipmax1);
                    %display
                	patch1=corrupt_im1(i-(iw-ipmin1):i+(ipmax1-iw), j-(jw-jpmin1):j+(jpmax1-jw));
                	patch2=corrupt_im1(ipmin1:ipmax1,jpmin1:jpmax1);
                else
                	a=ipmax-ipmin;
                	a1=ipmax1-ipmin1;
                	b=jpmax-jpmin;
                	b1=jpmax1-jpmin1;
                    if a>a1
                        if b>b1
                			patch1=corrupt_im1(i-(iw-ipmin1):i+(ipmax1-iw), j-(jw-jpmin1):j+(jpmax1-jw));
                			patch2=corrupt_im1(ipmin1:ipmax1, jpmin1:jpmax1);
                		else
                			patch1=corrupt_im1(i-(iw-ipmin1):i+(ipmax1-iw), jpmin:jpmax);
                			patch2=corrupt_im1(ipmin1:ipmax1, jw-(j-jpmin):jw+(jpmax-j));
                        end
                    else
                        if b>b1
                			patch1=corrupt_im1(ipmin:ipmax,	j-(jw-jpmin1):j+(jpmax1-jw));
                			patch2=corrupt_im1(iw-(i-ipmin):iw+(ipmax-i),jpmin1:jpmax1);
                        else
                			patch1=corrupt_im1(ipmin:ipmax, jpmin:jpmax);
                			patch2=corrupt_im1(iw-(i-ipmin):iw+(ipmax-i), jw-(j-jpmin):jw+(jpmax-j));
                        end
                    end
                end

                % for ip2=ipmin1:ipmax1
                %     for jp2=jpmin1:jpmax1
                %         patch2((ip2-ipmin1+1),(jp2-jpmin2+1))=im1(ip2,jp2);
                %     end
                % end

                patch3=patch1-patch2;
                wt(iw,jw)=exp(-(sumsqr(patch3)/s*s));
%                 sum_wt=sum_wt+wt;
%                 numerator()=numerator+wt*corrupt_im1(iw,jw);
             end
        end
        sp_r = jwmin:jwmax;
        sp_r = sp_r';
        sp_r = repmat(sp_r,1,iwmax-iwmin+1);
        sp_c = jwmin:jwmax;
        sp_c = repmat(sp_c,iwmax-iwmin+1,1);
        sp_r = sp_r - i;
        sp_c = sp_c - j;
        sp_r = sp_r.*sp_r;
        sp_c = sp_c.*sp_c;
        sp = sp_r + sp_c;
        sp = sqrt(sp);
        sp = exp((-0.5/ss^2)*(sp.*sp));
        n_wt = sp.*wt;
        new_im1(i,j)=sum(sum(n_wt.*corrupt_im1(iwmin:iwmax,jwmin:jwmax)))/sum(sum(n_wt));
        
    end
    fprintf('%d of %d \n', i,row1);
end

RMSD = sqrt(mean(mean((new_im1 - im1).^2)));
myNumOfColors=200;
myColorScale = [(0:1/(myNumOfColors-1):1)',(0:1/(myNumOfColors-1):1)',(0:1/(myNumOfColors-1):1)'];


subplot(1,3,1)
imshow(mat2gray(im1))
colormap(myColorScale);
colormap gray;
colorbar
subplot(1,3,2)
imshow(mat2gray(corrupt_im1))
colormap(myColorScale);
colormap gray;
colorbar
subplot(1,3,3)
imshow(mat2gray(new_im1))
colormap(myColorScale);
colormap gray;
colorbar
                

                
        
end