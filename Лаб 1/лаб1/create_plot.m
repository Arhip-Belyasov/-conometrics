function create_plot(data)
    figure('Color', 'w')
   
    hold on

    plot(data, Color='red')

    hold off
    
    grid on
    grid minor

    title('Модель данных');
    xlabel('Номер периода ')
    ylabel('Экспорт, млн руб. ')