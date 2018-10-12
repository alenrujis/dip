% A = [1 2 3;3 5 7;7 5 9;8 9 5];
function[U ,S,V] =MySVD(A)
[ V1,S1] = eig(A'*A);

[m n] = size(A);

S = S1.^(.5);
S=fliplr(fliplr(S)');
V = fliplr(V1);

U = zeros(m,n);    
for i = 1:1:n
        U(:,i) = (A*V(:,i))/S(i,i); 
        
end

end
% Result=U*S*V';
