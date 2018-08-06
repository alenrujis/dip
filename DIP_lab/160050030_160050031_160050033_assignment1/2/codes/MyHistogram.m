function cdf = MyHistogram(matrix)
%-------------------------------------------------------------------
%it take input Matrix and compute CDF of its intensity on 0-1 scale
%--------------------------------------------------------------------
%[r, c] = size(matrix);
%counts = zeros(1, 256);
%newcount=zeros(1,256);

% for i = 1 : c
% 	for j = 1 : r
% 		grayLevel = matrix(j, i)+1;
% 		counts(grayLevel) = counts(grayLevel) + 1;
% 	end
% end

%----------------------------------------------------------
%computes frequency at each intensity(stored in counts)
%---------------------------------------------------------
K=0:256;
newcount=histcounts(matrix,K);
%total sum of intensity
%total=sum(newcount);
%-------------------------------------------------------
%cumulative sum
%-------------------------------------------------------
cdf = zeros(1,256);
cum =cumsum(newcount);

%cal=zeros(1,256);

% cal(1)=counts(1);
% for k=2:256
%     cal(k)=counts(k)+cal(k-1);
% end

%---------------------
%final cdf
%---------------------
cdf=cum/cum(end);

%histogram equalising
%cdf= cdf*255;
%new_im=cdf(matrix+1);

end