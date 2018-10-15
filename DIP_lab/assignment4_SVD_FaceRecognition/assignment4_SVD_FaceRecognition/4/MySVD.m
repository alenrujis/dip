% A = [1 2 3;3 5 7;7 5 9;8 9 5];
 function[U ,S,V] =MySVD(A)
[ V1,S1] = eig(A'*A);

[m n] = size(A);
    S = zeros(m,n);
    [m1, n1] = size(S1);
[d,ind] = sort(diag(S1));
S2 = S1(ind,ind);

for i = 1:min(m,n)
        S(i,i) = sqrt(S2(m1-i+1,m1-i+1));
end
V = fliplr(V1);

U = zeros(m,m);    
for i = 1:min(n,m)
        if S(i,i)~=0
        U(:,i) = (A*V(:,i))/S(i,i); 
        else
            U(:,i) = (A*V(:,i));
        end    
end

 end
%  Result=U*S*V';