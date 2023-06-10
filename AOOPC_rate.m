%%%%%%%%%%%%SF-STIM
%%%%不可行时，为0
%%%%%SNR设置


%%%%SF-STIM
clear all;
monte_carlo=5000;

Nt=2;
Nr=2;%三组通信对两两之间都是2-2
r=10;%%Bob所需最低信噪比
rd=10^(r/10);
a=0.5;%%%%当方案不可行时的功率分配因子，我们的方案一般取0.5

SNR=[0:1:20];
noise=1;
Pt1=[];
Pt0=[];
Pt1=10.^(SNR./10); % Pt1/noise=SNR dB
Pt0=1.*Pt1; %
Pt2=zeros(size(SNR));%AD-OPC所需Bob功率
ber=1e-5%目标误码率
SNR_target = 10;%误码率所需信噪比
pp=0.5

for j=1:length(SNR)
    j
    for i=1:monte_carlo
        %初始化信道
        
        HAB=sqrt(0.5)*randn(Nr,Nt)+sqrt(-0.5)*randn(Nr,Nt);
        HBC=sqrt(0.5)*randn(Nr,Nt)+sqrt(-0.5)*randn(Nr,Nt);
        HAC=sqrt(0.5)*randn(Nr,Nt)+sqrt(-0.5)*randn(Nr,Nt);

        HBE=sqrt(0.5)*randn(Nr,Nt)+sqrt(-0.5)*randn(Nr,Nt);
        HAE=sqrt(0.5)*randn(Nr,Nt)+sqrt(-0.5)*randn(Nr,Nt);
        
        [u1 s1 v1]=svd(HAB);%pa
        [u0 s0 v0]=svd(HBC);%pb
        pa=v1(:,1);
        pb=v0(:,1);
        f0=u1(:,1);
        f3=u0(:,1);%IN时Carol滤波
        
        
        %%%%IN
       
        HBCeq=HBC*pb;
        g1=inv(HBC)*HAC*pa
        ds=(HBC*pb)/norm(HBC*pb,'fro')
        dh=(HAC*pa)/norm(HAC*pa,'fro')
        Pin=Pt1(j)*norm(g1,'fro')^2;
        
        pin=-g1/norm(g1)
        if (Pt0(j)-Pin)>0   
          r11=log2(1+(Pt0(j)-Pin)*(norm(f3'*HBC*pb))^2/noise)
        else 
         r11=0;
        end
        
        %%%%IS
        
        P=ds*inv(ds'*ds)*ds';%期望信号方向
        g2=inv(HBC)*P*HAC*pa;%%%%%导向预编码，未归一化
        pis=-g2/norm(g2);%%IS的预编码
        Pis=Pt1(j)*norm(g2,'fro')^2;
        if (Pt0(j)-Pis)>0   
         r13=log2(1+(Pt0(j)-Pis)*(norm(f3'*HBC*pb))^2/(norm(f3'*(sqrt(Pt1(j))*HAC*pa+sqrt(Pis)*HBC*pis),'fro')^2+noise));
        else 
         r13=0;
        end

        fc1=dh-(ds*((ds'*dh)/(ds'*dh)))
        fc2=ds-(dh*((dh'*ds)/(dh'*ds)))
        fc = [fc1 fc2]
        
        r12=pp*log2(1+(Pt1(j))*((norm(fc'*HAC*pa))^2/noise));%Carol数据速率
        
        %计算Bob满足误码率所需功率
        Pt2(j)=(SNR_target*noise)/((norm(fc'*HBC*pb))^2)

       
        
        if i==1
            
            sum_R11(j)=r11 ;
            sum_R12(j)=r12 ;
            sum_R13(j)=r13 ;

        else
            %             sum_gamma(j)=sum_gamma(j)+gamma_x0;
            sum_R11(j)=sum_R11(j)+r11;
            sum_R12(j)=sum_R12(j)+r12 ;
            sum_R13(j)=sum_R13(j)+r13 ;
           
        end
        
        ave_R11(j)=abs(sum_R11(j))/(monte_carlo);
        ave_R12(j)=abs(sum_R12(j))/(monte_carlo);
        ave_R13(j)=abs(sum_R13(j))/(monte_carlo);

    end
end

figure(11)

plot(SNR,ave_R11,'r-+','LineWidth',1);
hold on;
plot(SNR,ave_R12,'b-s','LineWidth',1);
hold on;
plot(SNR,ave_R13,'m-x','LineWidth',1);
hold on;
legend('R_{IN}','R_{AD-OPC}','R_{IS}');
xlabel('信噪比 (dB)');
ylabel('频谱效率 (bit \cdot s^-^1 \cdot Hz^-^1)');
hold on;
%%\gamma_d=5