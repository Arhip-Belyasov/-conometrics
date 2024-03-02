function create_AR_plot(y, h1) 
    t = 1:length(y);

    figure('Color', 'w')
    
    
    hold on

    plot(t, y, Color='red')
    t(25)=25;
    plot(t, h1, Color='blue')

    hold off
    
    grid on
    grid minor
    
    title('Модель AR(1)');
    legend('Исходные данные', 'модель AR(1)');

    xlabel('t')
    ylabel('y')

end