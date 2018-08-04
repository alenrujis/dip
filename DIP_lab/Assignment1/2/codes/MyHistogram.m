function cdf = MyHistogram(matrix)

%[r, c] = size(matrix);
%counts = zeros(1, 256);
%newcount=zeros(1,256);
%computes frequency at each intensity(stored in counts)
% for i = 1 : c
% 	for j = 1 : r
% 		grayLevel = matrix(j, i)+1;
% 		counts(grayLevel) = counts(grayLevel) + 1;
% 	end
% end
K=0:256;
newcount=histcounts(matrix,K);
%total sum of intensity
%total=sum(newcount);
%cumulative distributive function. cdf
cdf = zeros(1,256);
cum =cumsum(newcount);
%cal=zeros(1,256);

% cal(1)=counts(1);
% for k=2:256
%     cal(k)=counts(k)+cal(k-1);
% end
%final cdf
cdf=cum/cum(end);
%histogram equalising
%cdf= cdf*255;
%new_im=cdf(matrix+1);

end