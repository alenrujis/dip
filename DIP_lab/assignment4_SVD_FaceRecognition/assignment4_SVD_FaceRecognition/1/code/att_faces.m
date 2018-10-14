%% MyMainScript

tic;
%% Your code here
p='../../att_faces';
a=dir('../../att_faces');
A =zeros(92*112,32*6); 
B =zeros(92*112,32*4); 
 
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
 
 n=32*6;
 K=[1,2,3,5,10,15,20,30,50,75,100,150,170];

 a_bar=sum(A,2)./n;
 b_bar=sum(B,2)./n;
  A=A-a_bar;
  B=B-a_bar;
  [~,b]=size(B);
  L=A'*A;
  [W,T]=eig(L);
  V=A*W;
  V=normc(V);
  [~,sz]=size(K);
  counter=zeros(1,sz);
for j= 1:sz
  Vk=V(:,n-K(j)+1:n);
  alphaA=Vk'*A;
  alphaB=Vk'*B;
  
  min = knnsearch(alphaA', alphaB');
        for i=1:b
            if(ceil(min(i)/6)==ceil(i/4)) 
                counter(j)=counter(j)+1;
            end
        end
  
 
  
end
  counter=counter./b;
  
  figure;
  plot(K,counter);
  title('att_faces')
xlabel('eigencoefficient') 
ylabel('recognitionrate') 

 
toc;
