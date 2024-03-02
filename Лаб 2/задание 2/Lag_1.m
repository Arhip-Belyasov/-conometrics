function[r_cd1,gamma_bp1,LB,y_pred]=Lag_1(n,omega,a_AIC,y)
m=11;
    %модель для центрированных данных
x=0;
x(1)=omega(1);
for i=2:n
    x(i)=omega(i)-a_AIC(1,1)*omega(i-1);
end

%%%%%%%%%%%% автокорреляции для центрированных данных
x_mean=0;  
for i=1:n
    x_mean=x_mean+x(i);
end
x_mean=x_mean/n;
%Нахождение автокорелляций и автоковариаций    
for i = 1:m+1
        sum = 0;
        for j = 1:n-(i-1)
            sum = sum + (x(j) - x_mean) * (x(j+(i-1)) - x_mean);
        end
        
    c_cd(i) = sum / n;
    end

    for i = 2:m+1
        r_cd1(i) = c_cd(i) / c_cd(1);
    end 
    r_cd1(1)=1;
    % r1<1/2 поэтому модель ARMA(p,1) статистически значима
     %проверим статистику Бокса-Пирса
    gamma_bp1=0;
    for k=1:m-1
        r_ch=0;
        r_zn=0;
        for j=1:n
            r_zn=r_zn+(x(j))^2;
        end

        for i=k+1:n
            r_ch=r_ch+(x(i))*(x(i-k));
        end
        gamma_bp1=gamma_bp1+(r_ch/r_zn)^2;
    end
gamma_bp1=gamma_bp1*n;
%по статистике Бокса-Пирса ряд стационарен, но проверим еще и
%статистику Льюнга-Бокса
sum=0;
for i=1:m-1
    sum=sum+(r_cd1(i+1)^2)/(n-i);
end
LB=n*(n+2)*sum
%По статистике Льюнга_Бокса ряд тоже стационарен
% Построим прогноз на 25 день торгов
teta=(-1+sqrt(1-4*(r_cd1(2))^2))/(2*r_cd1(2))
y_pred=0;
for i=2:n+1
    y_pred(i) =  a_AIC(1,1)*x(i-1)+mean(y)-teta;
end
y_pred(1)=y(1);
