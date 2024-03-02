function [u,E,D,r,r_u,gamma_u,gamma_us]=find_characteristics(n,y)
%%%Переход к относительным приращениям
u=0;
for i=2:n
    u(i-1)=(y(i)-y(i-1))/y(i-1);
end
%%%Найдем выборочные мат ожидание и дисперсию
E(1)=mean(u(19:23));
E(2)=mean(u(14:23));
E(3)=mean(u(9:23));
D(1)=0;D(2)=0;D(3)=0;
for i=1:5
    D(1)=D(1)+(u(i+18)-E(1))^2;
end
D(1)=D(1)/5;
for i=1:10
    D(2)=D(2)+(u(i+13)-E(2))^2;
end
D(2)=D(2)/10;
for i=1:15
    D(3)=D(3)+(u(i+8)-E(3))^2;
end
D(3)=D(3)/15;
%%%%Пункт 3
%%%%model = garch('garchlags',1,'archlags',1); [estM1,H,logL] = estimate(model,u)


%%Пункт четвертый 
%Найдем ряды сигма квадрат и ...
N=8;
sigma_sq(1:N)=0;
k=15;
for i=16:length(u)
    for j=1:k
        sigma_sq(i-k)=sigma_sq(i-k)+(u(i-j)-mean(u(i-k:i)))^2;
    end
    sigma_sq(i-k)=sigma_sq(i-k)/(k-1);
end
u_sq(1:N)=0;
for i=k+1:length(u)
    u_sq(i-k)=u(i)^2;
end
u_sigma_sq(1:N)=0;
for i=1:N
    u_sigma_sq(i)=u_sq(i)/sigma_sq(i);
end
%%%Найдем первых пять автокорреляций
m=5;
for i = 1:m+1
        sum = 0;
        for j = 1:N-(i-1)
            sum = sum + (u_sigma_sq(j) - mean(u_sigma_sq)) * (u_sigma_sq(j+(i-1)) - mean(u_sigma_sq));
        end
        
    c(i) = sum / N;
    end

    for i = 2:m+1
        r(i) = c(i) / c(1);
    end 
    r(1)=1;

    %%%%%% для u_sq
for i = 1:m+1
        sum = 0;
        for j = 1:N-(i-1)
            sum = sum + (u_sq(j) - mean(u_sq)) * (u_sq(j+(i-1)) - mean(u_sq));
        end
        
    c(i) = sum / N;
    end

    for i = 2:m+1
        r_u(i) = c(i) / c(1);
    end 
    r_u(1)=1;

%%%проверим статистику Льюнга-Бокса
gamma_u=0;
sum=0;
for i=1:m
    sum=sum+r_u(i)/(N-i);
end
gamma_u=(N+2)*N*sum;

gamma_us=0;
sum=0;
for i=1:m
    sum=sum+r(i)/(N-i);
end
gamma_us=(N+2)*N*sum;










