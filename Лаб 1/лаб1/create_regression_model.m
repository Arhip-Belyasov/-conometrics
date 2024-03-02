function create_regression_model(t, y, params, flag)
    if flag == 1
        f = @(x) params(1) + params(2)*x;
    else
        f = @(x) params(1) + params(2)*x + params(3)*x.^2+params(4)*x.^3; 
    end
    
    figure('Color', 'w')
   
    hold on

    plot(t, f(t), Color='red')
    plot(t, y, 'bo')

    hold off
    
    grid on
    grid minor

    title('Модель регрессии');
    xlabel('t')
    ylabel('y')



    