%% MyMainScript

tic;
%% Your code here
p='../../../../../../CroppedYale';
a=dir(p);
A =zeros(192*168,38*40); 
B =zeros(192*168,38*20); 
 
  for i=3:40
        im = cd(strcat(p ,'/', a(i).name));
         l = dir('./');
        [e,~]=size(l);
    for j=3:42
       A(:,40*(i-3)+j-2)= reshape(imread(l(j).name),192*168,1);         
    end  
    
    for j=43:62
    B(:,20*(i-3)+j-42)= reshape(imread(l(j).name),192*168,1);
    end    
    
     cd(im);
  end    
 
 n=38*40;
 K=[1, 2, 3, 5, 10, 15, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000];
% disp(size(B));
 a_bar=sum(A,2)./n;
 b_bar=sum(B,2)./n;
  A=A-a_bar;
  B=B-a_bar;
  [~,b]=size(B);
  
 [W,S,W1]=svds(A,1000);
 
  [~,sz]=size(K);
  counter1=zeros(1,sz);
      counter2=zeros(1,sz);

  
for j= 1:3
    [~,nz]=size(W);
  Vk=W(:,1:K(j));
  
  Vk2=W(:,1:K(j));
  alphaA=Vk'*A;
  alphaB=Vk'*B;
  
  alphaA2=Vk2'*A;
  alphaB2=Vk2'*B;
  
  
  min = knnsearch(alphaA', alphaB');
        for i=1:b
            if(ceil(i/20)==ceil(min(i)/40)) 
                counter1(j)=counter1(j)+1;
            end
        end
  
min2 = knnsearch(alphaA2', alphaB2');
        for i=1:b
            if(ceil(i/20)==ceil(min2(i)/40)) 
                counter2(j)=counter2(j)+1;
            end
        end
   
        
        
  
end  
  
  
  
  
  
  
  
for j= 4:sz
    [~,nz]=size(W);
  Vk=W(:,1:K(j));
  
  Vk2=W(:,4:K(j));
  alphaA=Vk'*A;
  alphaB=Vk'*B;
  
  alphaA2=Vk2'*A;
  alphaB2=Vk2'*B;
  
  
  min = knnsearch(alphaA', alphaB');
        for i=1:b
            if(ceil(i/20)==ceil(min(i)/40)) 
                counter1(j)=counter1(j)+1;
            end
        end
  
min2 = knnsearch(alphaA2', alphaB2');
        for i=1:b
            if(ceil(i/20)==ceil(min2(i)/40)) 
                counter2(j)=counter2(j)+1;
            end
        end
   
        
        
  
end
  counter1=counter1./b;
  counter2=counter2./b;
  
  figure;
  plot(K,counter1);
  title('croppedyale')
xlabel('eigencoefficientwithoutdropping') 
ylabel('recognitionrate') 


figure;
  plot(K,counter2);
  title('croppedyale')
xlabel('eigencoefficientwithdropping') 
ylabel('recognitionrate') 

  
  
  
  
  
  
  
  
  
  
  
 
toc;
