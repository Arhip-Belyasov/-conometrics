function [a_AIC,AIC_c,A1,B1] = AIC(n, y);
%найдем все коэффициенты а
[cov,omega]=find_characteristics(n,y);
B1=0;
for i=1:10 
    for j=1:i
        for k=1:i
            if k-j>0
                A1(j,k,i)=cov(k-j);
            else
                if k-j<0
                    A1(j,k,i)=cov(j-k+2);
                else
                    A1(j,k,i)=cov(2);
                end
            end
        end
    end
B1(i)=cov(i+2);    
%A1=A1(:,:,i);

%a1(i)=squeeze(A1([1:i],[1:i],i))/B1([1:i]);
end
    a1= B1([1:1])/squeeze(A1([1:1],[1:1],1));
    a2= B1([1:2])/squeeze(A1([1:2],[1:2],2));
    a3= B1([1:3])/squeeze(A1([1:3],[1:3],3));
    a4= B1([1:4])/squeeze(A1([1:4],[1:4],4));
    a5= B1([1:5])/squeeze(A1([1:5],[1:5],5));
    a6= B1([1:6])/squeeze(A1([1:6],[1:6],6));
    a7= B1([1:7])/squeeze(A1([1:7],[1:7],7));
    a8= B1([1:8])/squeeze(A1([1:8],[1:8],8));
    a9= B1([1:9])/squeeze(A1([1:9],[1:9],9));
    a10= B1([1:10])/squeeze(A1([1:10],[1:10],10));
    
    a=0;
    a1(2:10)=0;
    a2(3:10)=0;
    a3(4:10)=0;
    a4(5:10)=0;
    a5(6:10)=0;
    a6(7:10)=0;
    a7(8:10)=0;
    a8(9:10)=0;
    a9(10:10)=0;
   
    a1=transpose(a1);
    a2=transpose(a2);
    a3=transpose(a3);
    a4=transpose(a4);
    a5=transpose(a5);
    a6=transpose(a6);
    a7=transpose(a7);
    a8=transpose(a8);
    a9=transpose(a9);
    a10=transpose(a10);
   
    a_AIC=horzcat(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10);
    a_AIC=transpose(a_AIC);
    %Нахождение самих коэффициентов AIK
     AIC_c=0;
     sum=0;
    for p=1:10
        SUM=0;
        for i=1:n
            sum=y(i);
            for j=1:p
                if i-j>0
                    sum=sum-a_AIC(p,j)*y(i-j);
                end
            end
            SUM=SUM+sum^2;
            sum=0;
        end
        AIC_c(p)=2*(p+1)/n+log(SUM/n);
    end


