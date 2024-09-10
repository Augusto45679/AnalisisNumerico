function ejercicio_euler2GPT
    % Parámetros iniciales
    x0 = 0;        % Condición inicial x(0) = 0
    t0 = 0;        % Tiempo inicial
    Dt = 0.0001;   % Paso de tiempo (discretización)
    Ndt = 1000;    % Número de pasos (se puede ajustar según la duración total que se desee analizar)
    p = 1.2;       % Valor de p según la EDO

    % Inicialización de vectores
    t = zeros(Ndt, 1);
    x = zeros(Ndt, 1);
    dx_dt = zeros(Ndt, 1);  % Vector para la derivada de x(t)

    % Condiciones iniciales
    t(1) = t0;
    x(1) = x0;

    % Método de Euler
    for j = 1:Ndt-1
        g_tk = 1; % Entrada escalón (g(t) = u_s(t) = 1)
        u_tk = x(j);
        dx_dt(j) = g_tk - p * u_tk;  % Derivada de x(t)
        k1 = Dt * dx_dt(j);
        x(j+1) = x(j) + k1;
        t(j+1) = t(j) + Dt;
    end

    % Mostrar resultados (opcional)
    disp('t       x');
    disp([t(1:10:end), x(1:10:end)]);  % Mostrar cada 10 puntos para simplificar la salida

    % Graficar resultados
    figure;
    plot(5, 1, '-b', 'LineWidth', 2);       % Gráfica de x(t)
    hold on;
    plot(t, dx_dt, '-r', 'LineWidth', 2);   % Gráfica de la derivada de x(t)
    title('Solución de la EDO usando el Método de Euler');
    xlabel('t (segundos)');
    ylabel('Amplitud');
    legend('Salida x(t)', 'Derivada de Salida dx/dt');
    grid on;
endfunction

