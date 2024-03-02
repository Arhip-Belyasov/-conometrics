function [c , r,a,Q,a0,h1,gamma,gammaDF,AIK,h2,h_pred] = find_characteristics(n, y);
    m = 10;
    c = zeros(11);
    r = zeros(11);
y_mean=0;
for i=1:n
    y_mean=y_mean+y(i);
end
y_mean=y_mean/n;
%Нахождение автокорелляций и автоковариаций   
for i = 1:m+1
        sum = 0;
        for j = 1:n-(i-1)
            sum = sum + (y(j) - y_mean) * (y(j+(i-1)) - y_mean);
        end
        
    c(i) = sum / n;
    end

    for i = 2:m+1
        r(i) = c(i) / c(1);
    end 
    r(1)=1;
    %Нахождение коэффициентов с помощью критерия Юла-Уокера
    A=[r(2),r(3),r(4)];
    B=[1,r(2),r(3);r(2),1,r(2);r(3),r(2),1];
a=A/B;
%Статистика Льюнга-Бокса
Q=0;
    for i=1:3
        Q=Q+r(i)*r(i)*n*(n+2)/(n-i+1);
    end
 %коэффициент модели а0
    a0=(1-a(1)-a(2)-a(3))*y_mean;
    %создание модели
% % % h1(1)=a0+a(1)*a0;
% % % h1(2)=a0+a(1)*h1(1)+a(2)*a0;
% % % h1(3)=a0+a(1)*h1(2)+a(2)*h1(1)+a(3)*a0;
h1(1)=a0+a(1)*a(1)*a0;
h1(2)=a0+a(1)*y(1)+a(2)*a0;
h1(3)=a0+a(1)*y(2)+a(2)*y(1)+a(3)*a0;
for i=4:n
    h1(i)=a0+a(1)*y(i-1)+a(2)*y(i-2)+a(3)*y(i-3);
% % %     h1(i)=a0+a(1)*h1(i-1)+a(2)*h1(i-2)+a(3)*h1(i-3);
end
    %тест Дарбина-Уотсонa
     for i = 1:n
        e(i) = h1(i) - y(i);
    end 
    gamma = 0;
    sum_gamma = 0;
    for i = 2:n
     gamma = gamma + (e(i) - e(i-1))^2;
     sum_gamma = sum_gamma + e(i)^2;
    end
    gamma = gamma / sum_gamma;
%Тест Дики-Фуллера
h_mean=0;
for i=1:n
    h_mean=h_mean+h1(i);
end
h_mean=h_mean/n;
for i=1:n
    h_cn(i)=h1(i)-h_mean;
end
c1=inv(transpose(h_cn)*h_cn);
s=sqrt(c1(1,1)/(n-1));
gammaDF=(a(1)-1)/s;
%for i=1:n
%    y_cn(i)=y(i)-y_mean;
%end
%c=inv(transpose(y_cn)*y_cn);
%s=sqrt(c(1,1)/(n-1));
%gammaDF=(a(1)-1)/s;

%модель для р=2
h2(1)=a0+a(1)*a0;
h2(2)=a0+a(1)*h2(1)+a(2)*a0;
for i=3:n
    h2(i)=a0+a(1)*h2(i-1)+a(2)*h2(i-2);
end

%Критерий Акаике для р=3
p=3;
sum=0;
for i=1:n
    sum=sum+(y(i)-h1(i))^2;
end
AIK(1)=2*p/n+log(sum/n);

%Критерий Акаике для р=2
p=2;
sum=0;
for i=1:n
    sum=sum+(y(i)-h2(i))^2;
end
AIK(2)=2*p/n+log(sum/n);

%прогноз на 25 день торгов
h_pred=0;
%for i=1:n
    h_pred=a0+a(1)*y(24)+a(2)*y(23)+a(3)*y(22);
    h1(25)=h_pred;