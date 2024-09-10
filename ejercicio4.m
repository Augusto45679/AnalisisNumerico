function ejercicio4
    w = 2;
    t0 = 0; tf = 2 * pi; % rango del intervalo
    N_vector = [10, 20, 30, 40];
    dt_vector = (tf - t0) ./ N_vector;

    Im_vector = zeros(length(N_vector), 2); % matriz para almacenar resultados de Riemann
    IT_vector = zeros(length(N_vector), 2); % matriz para almacenar resultados de Trapecios

    % Valores de k y m
    k = 1;
    m = 1;

    % Bucle para calcular las integrales
    for func_type = 1:2
        for i = 1:length(N_vector)
            N = N_vector(i);
            dt = dt_vector(i);
            t = linspace(t0, tf, N + 1);

            % Selección de la función según el tipo
            if func_type == 1
                f = @(theta) sin(k * theta) .* sin(m * theta);
            else
                f = @(theta) cos(k * theta) .* cos(m * theta);
            end

            % Evaluación de la función en los puntos
            yg = f(t);

            % Suma de Riemann
            Im = 0;
            for j = 1:N
                Im = Im + dt * yg(j);
            end
            Im_vector(i, func_type) = Im; % almacenamos los Im en la matriz

            % Método de los Trapecios
            IT = 0;
            for k = 1:N
                IT = IT + dt * (yg(k) + yg(k + 1)) / 2;
            end
            IT_vector(i, func_type) = IT; % almacenamos los IT en la matriz
        end
    end

    % Mostrar los resultados
    disp('Resultados para la integral de sin(kθ)sin(mθ):');
    disp('N    Riemann      Trapecios');
    disp([N_vector', Im_vector(:,1), IT_vector(:,1)]);

    disp('Resultados para la integral de cos(kθ)cos(mθ):');
    disp('N    Riemann      Trapecios');
    disp([N_vector', Im_vector(:,2), IT_vector(:,2)]);
endfunction

