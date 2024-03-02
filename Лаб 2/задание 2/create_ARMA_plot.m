function create_ARMA_plot(y, y_pred)
    t = 1:length(y);

    figure('Color', 'w')
    
    
    hold on

    plot(t, y, Color='red')
    t(25)=25;
    plot(t, y_pred, Color='blue')

    hold off
    
    grid on
    grid minor
    
    title('Модель ARMA(1,1)');
    legend('Исходные данные', 'модель ARMA(1,1)');

    xlabel('t')
    ylabel('y')

end