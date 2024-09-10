function juanGPT
    % Definir parámetros
    p = 2;  % Valor de p según el enunciado
    N = 10; % Número de intervalos
    t0 = 0; tf = 2.5; % Rango de tiempo

    % Calcular el incremento de tiempo
    dt = (tf - t0) / N;
    t = linspace(t0, tf, N+1); % Vector de tiempo con N+1 puntos

    % Calcular y(t) y G(t)
    y_t = exp(-p * t); % Función y(t) = exp(-p*t)
    G_t = (1/p) * (1 - exp(-p * t)); % Función G(t) = (1/p)(1 - exp(-p*t))

    % Graficar las funciones
    figure;
    plot(t, y_t, 'ob', t, G_t, 'or');
    grid on;
    legend('y(t) = e^{-pt}', 'G(t) = (1/p)(1 - e^{-pt})');
    xlabel('t');
    ylabel('y(t) y G(t)');
    title('Discretización de y(t) y su integral G(t)');
endfunction
