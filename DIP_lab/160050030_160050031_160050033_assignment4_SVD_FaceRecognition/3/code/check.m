function [false_positive, false_negative] = check(K, limit, directory)
% p='../../att_faces';
% a=dir('../../att_faces');
p=directory;
a=dir(directory);   
A =zeros(92*112,32*6); 
B =zeros(92*112,32*4); 
C = zeros(92*112, 8*10);

for i=4:35
    im = cd(strcat(p ,'/', a(i).name));
    l = dir('./');
       
    for j=3:8
        A(:,6*(i-4)+j-2)= reshape(imread(l(j).name),92*112,1);         
    end  
   
    for j=9:12
        B(:,4*(i-4)+j-8)= reshape(imread(l(j).name),92*112,1);
    end    
   
    cd(im);
end    
 
for i=36:43
    im = cd(strcat(p ,'/', a(i).name));
    l = dir('./');
    for j=3:12
        C(:,10*(i-36)+j-2) = reshape(imread(l(j).name), 92*112, 1);
    end
    cd(im)
end

[~,n]=size(A);
% K=23;
a_bar=sum(A,2)./n;
b_bar=sum(B,2)./n;
c_bar=sum(C,2)./n;
A=A-a_bar;
B=B-a_bar;
C=C-a_bar;
[~,b]=size(B);
[~,c]=size(C);
L=A'*A;
[W,T]=eig(L);
vk=W(:,n-K+1:n);
Vk=A*vk;
Vk=normc(Vk);

false_positive=0;
false_negative=0;

% limit=1900;
alphaA=Vk'*A;
alphaB=Vk'*B;
alphaC=Vk'*C;

min = knnsearch(alphaA', alphaB');
min_new = knnsearch(alphaA', alphaC');
for i=1:c
    if(norm(alphaA(:,min_new(i)) - alphaC(:,i)) < limit)
        false_positive=+false_positive+1;
    end
end
for i=1:32*4
    if(norm(alphaA(:,min(i)) - alphaB(:,i)) > limit )
        false_negative=false_negative+1;
    end
end