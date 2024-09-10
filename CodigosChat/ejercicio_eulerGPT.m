function ejercicio_eulerGPT
    % Parámetros iniciales
    x0 = 0;        % Condición inicial x(0) = 0
    t0 = 0;        % Tiempo inicial
    Dt = 0.0001;      % Paso de tiempo (discretización) este es el muestreo osea Dt = 1/fs
    Ndt = 1000;       % Número de pasos (correspondiente a los 5 puntos de la tabla)
    p = -1.2;        % Valor de p según el problema

    % Inicialización de vectores
    t = zeros(Ndt, 1);
    x = zeros(Ndt, 1);

    % Condiciones iniciales
    t(1) = t0;
    x(1) = x0;

    % Método de Euler
    for j = 1:Ndt-1
        g_tk = 1; % Entrada escalón (g(t) = u_s(t) = 1)
        u_tk = x(j);
        k1 = Dt * (g_tk - p * u_tk);
        x(j+1) = x(j) + k1;
        t(j+1) = t(j) + Dt;
    end

    % Mostrar resultados
    disp('t       x');
    disp([t, x]);

    % Graficar resultados
    figure;
    plot(5, 1, '-o');
    title('Solución de la EDO usando el Método de Euler');
    xlabel('t (segundos)');
    ylabel('x(t)');
    grid on;
endfunction

