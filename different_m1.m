clear all
clc
n=500
x=1:1:n;
y1=0.5;
y2=0.25;
y3=0.125;
y4=0.0625
z1=zeros(1,n)
z2=zeros(1,n)
z3=zeros(1,n)
z4=zeros(1,n)
z11=zeros(1,n)%存储当前发送比特总和
ans1=zeros(1,n)
ans2=zeros(1,n)
ans3=zeros(1,n)
ans4=zeros(1,n)


z22=zeros(1,n)
z33=zeros(1,n)
z44=zeros(1,n)
for i = 1:1:n;
    temp = rand()
    if i == 1
        if temp<y1;
             z1(i)=1
             z11(i)=z1(i)
             ans1(i)=z11(i)/i
             plot(i,z1(i),'.','color',[1 0 0], 'MarkerSize', 5)
             hold on
        else
            z11(i)=z1(i)
            ans1(i)=z11(i)/i
            plot(i,z1(i),'.','color',[1 0 0], 'MarkerSize', 5)
            hold on
        end
        if temp<y2;
             z2(i)=2
             z22(i)=z2(i)
             ans2(i)=z22(i)/i
             plot(i,z2(i),'*','color',[0 1 0], 'MarkerSize', 5)
             hold on
        else
            z22(i)=z2(i)
            ans2(i)=z22(i)/i
            plot(i,z2(i),'*','color',[0 1 0], 'MarkerSize', 5)
            hold on
        end
        if temp<y3;
             z3(i)=3
             z33(i)=z3(i)
             ans3(i)=z33(i)/i
             plot(i,z3(i),'x','color',[0 0 1], 'MarkerSize', 5)
             hold on
        else
            z33(i)=z3(i)
            ans3(i)=z33(i)/i
            plot(i,z3(i),'x','color',[0 0 1], 'MarkerSize', 5)
            hold on
        end
        if temp<y4;
             z4(i)=4
             z44(i)=z4(i)
             ans4(i)=z44(i)/i
             plot(i,z4(i),'+','color',[1 0 1], 'MarkerSize', 5)
             hold on
        else
            z44(i)=z4(i)
            ans4(i)=z44(i)/i
            plot(i,z4(i),'+','color',[1 0 1], 'MarkerSize', 5)
            hold on
        end     

    else
        if temp<y1;
             z1(i)=1
             z11(i)=z11(i-1)+z1(i)
             ans1(i)=z11(i)/i
             plot(i,z1(i),'.','color',[1 0 0], 'MarkerSize', 5)
             hold on
        else
             z11(i)=z11(i-1)
             ans1(i)=z11(i)/i
   
        end
        if temp<y2;
             z2(i)=2
             z22(i)=z22(i-1)+z2(i)
             ans2(i)=z22(i)/i
             plot(i,z2(i),'*','color',[0 1 0], 'MarkerSize', 5)
             hold on
        else
             z22(i)=z22(i-1)
             ans2(i)=z22(i)/i
   
        end
        if temp<y3;
             z3(i)=3
             z33(i)=z33(i-1)+z3(i)
             ans3(i)=z33(i)/i
             plot(i,z3(i),'x','color',[0 0 1], 'MarkerSize', 5)
             hold on
        else
             z33(i)=z33(i-1)
             ans3(i)=z33(i)/i
   
        end
        if temp<y4;
             z4(i)=4
             z44(i)=z44(i-1)+z4(i)
             ans4(i)=z44(i)/i
             plot(i,z4(i),'+','color',[1 0 1], 'MarkerSize', 5)
             hold on
        else
             z44(i)=z44(i-1)
             ans4(i)=z44(i)/i
   
        end
        
    end
    
  
end
axis([0 n 0 5]);
figure(2);
plot(x,ans1,'r')
hold on
plot(x,ans2,'g')
hold on
plot(x,ans3,'b')
hold on
plot(x,ans4,'color',[1 0 1])
hold on
axis([0 n 0 1]);


