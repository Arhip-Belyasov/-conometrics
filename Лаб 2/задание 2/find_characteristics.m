function [c ,omega, r,a,r_cd,gamma_bp] = find_characteristics(n, y);
    m = 11;
    c = zeros(12, 1);
    r = zeros(12, 1);
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
    %Центрируем данные
    omega=0;
    for i=1:n
        omega(i)=y(i)-y_mean;
    end
    %Найдем коэффициенты a
     B=[c(3),c(4),c(5)];
    A=[c(2),c(1),c(2);c(3),c(2),c(1);c(4),c(3),c(2)];
a=B/A;
%модель для центрированных данных
x=0;
x(1)=omega(1);
x(2)=omega(2)-a(1)*omega(1);
x(3)=omega(3)-a(1)*omega(2)-a(2)*omega(1);
for i=4:n
    x(i)=omega(i)-a(1)*omega(i-1)-a(2)*omega(i-2)-a(3)*omega(i-3);
end
% автокорреляции для центрированных данных
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
        r_cd(i) = c_cd(i) / c_cd(1);
    end 
    r_cd(1)=1;
    % r1>1/2 поэтому модель ARMA(p,1) построить нельзя
    %проверим статистику Бокса-Пирса
    gamma_bp=0;
    for k=1:m-1
        r_ch=0;
        r_zn=0;
        for j=1:n
            r_zn=r_zn+(x(j))^2;
        end

        for i=k+1:n
            r_ch=r_ch+(x(i))*(x(i-k));
        end
        gamma_bp=gamma_bp+(r_ch/r_zn)^2;
    end
gamma_bp=gamma_bp*n;
%Cтатистика Бокса-Пирса больше критического значения, а это значит, что
%гипотеза отвергается. Наш ряд нестационарен!
