%% MyMainScript

tic;
%% Your code here
p='../../att_faces';
% p = uigetdir();
a=dir('../../att_faces');
% a=dir(p);
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
    
%         disp(l(1).folder);
% disp(im);
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
%   k=20;
for j= 1:sz
  Vk=V(:,n-K(j)+1:n);
  alphaA=Vk'*A;
  alphaB=Vk'*B;
  
  min = knnsearch(alphaA', alphaB');
        for i=1:b
%             disp(min(j));
            if(ceil(min(i)/6)==ceil(i/4)) 
                counter(j)=counter(j)+1;
            end
        end
  
 
  
%   for i=1:128
%     probe=alphaB(i);
%     temp = alphaA-probe;
%     temp2=temp.^2;
%     temp3=sum(temp2,1);
% %     temp3=temp2.^(2);
%     [M,min_i]=min(temp3);
% %     disp(min_i);
%     if(ceil(i/4) == ceil(min_i/6))
%         counter(j)=counter(j)+1;
% %         disp(counter(j));
%     end   
%   end    
end
  counter=counter./b;
  
  
  
 
toc;
