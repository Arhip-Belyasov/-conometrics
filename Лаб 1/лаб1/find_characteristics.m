function [disp, c , r, gamma,Q] = find_characteristics(n, y, t, params)
    model = @(x) params(1) + params(2) * x;
    m = 5;
    Y = ones(n, 1); disp = 0;
    c = zeros(6, 1);
    r = zeros(6, 1);
    e = zeros(n, 1);
   
    for i = 1:n
        disp = disp + (model(t(i)) - y(i))^2;
        Y(i) = model(t(i));
    end 
    
    disp = disp / (n-2);
    y_mean = mean(Y);

    for i = 1:m+1
        sum = 0;
        for j = 1:n-(i-1)
            sum = sum + (Y(j) - y_mean) * (Y(j+(i-1)) - y_mean);
        end
        
    c(i) = sum / n;
    end

    for i = 2:m+1
        r(i) = c(i) / c(1);
    end 
    
    for i = 1:n
        e(i) = model(t(i)) - y(i);
    end
    
    gamma = 0;
    sum_gamma = 0;
    for i = 2:n
     gamma = gamma + (e(i) - e(i-1))^2;
     sum_gamma = sum_gamma + e(i)^2;
    end

    gamma = gamma / sum_gamma;
    Q=0;
    for i=1:6
        Q=Q+r(i)*r(i)*n*(n+2)/(n-i+1);
    end