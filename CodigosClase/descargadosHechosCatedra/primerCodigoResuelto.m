function primerCodigoResuelto
    clc, clear;

    % Parámetros iniciales
    Tg = 2 * 5; % periodo de funcion escalon es
    Td = 5; % 1era duración  del escalon es
    A1 = 1; A2 = 0; %  Amplitudes    de g(t) son:
    t0 = 0; % comienzo del intervalo t
    tf = Tg; % 'el rango de t para g(t) es desde t0 hasta tf'
    N = 4; % N° de intervalos
    Dt = (tf - t0) / N; % incremento de t resulta
    Tp = N * Dt; % periodo (creo que es Periodo Total)
    w0 = 2 * pi / N; % frecuencia  Fundamental para Min 2
    dw = w0 / Dt; % incrmento de frecuencia para Min 2
    m_max = round(N / 2); % multiplo máximo para las frecunecias es
    m = -1 + N / 2; %  se eligen para senos y cosenos desde 1 a m , Múltiplo de la frecuencia utilizado
    Nb = 2 * m + 1; % en la Base para Min 2, se toman 2m+1 elementos Nb (Número de elementos en la base para Min 2)
    compara_g_P = 1;

    % Armado de la función g(t) discreta
    [t, g] = construirFuncionEscalon(t0, tf, N, Dt, Td, A1, A2);
    graficarFuncion(t, g, 'g(t)', 1);

    % Inicialización para Min 2
    [FI, kw0, kw] = construirBaseTrigonometrica(N, m, w0, dw);
    [alfa, b] = calcularCoeficientesMin2(FI, g);

    % Comparación de P(t) con g(t)
    [P, r] = compararPConG(FI, alfa, g);
    graficarComparacion(t, P, g, r, 2, 3);

    % Respuesta en frecuencia
    [c, fase, kw0, kw] = calcularRespuestaFrecuencia(alfa, m, kw0, kw);
    graficarRespuestaFrecuencia(kw, c, fase, 4);

    % Comparación entre versión discreta de g(t) y continua de P(t)
    if compara_g_P == 1
        [tcom, P_tc] = construirVersionContinuaP(alfa, m, dw, t0, Tp);
        graficarComparacionContinua(tcom, P_tc, t, g, 10);
    end
end

function [t, g] = construirFuncionEscalon(t0, tf, N, Dt, Td, A1, A2)
    t = zeros(N, 1);
    g = zeros(N, 1);
    for j = 1:N
        t(j) = t0 + (j - 1) * Dt;
        if t(j) < Td
            g(j) = A1;
        else
            g(j) = A2;
        end
    end
end

function graficarFuncion(t, g, titulo, figura)
    figure(figura);
    plot(t, g, '-or');
    grid on;
    title(titulo);
end

function [FI, kw0, kw] = construirBaseTrigonometrica(N, m, w0, dw)
    FI = zeros(N, 2 * m + 1);
    kw0 = zeros(1, m + 1);
    kw = zeros(1, m + 1);
    FI(:, 1) = 1;
    kw0(1) = 0;
    kw(1) = 0;
    for k = 1:m
        kw0(k + 1) = k * w0;
        kw(k + 1) = k * dw;
        for j = 1:N
            FI(j, 2 * k) = cos(k * w0 * (j - 1));
            FI(j, 2 * k + 1) = sin(k * w0 * (j - 1));
        end
    end
end

function [alfa, b] = calcularCoeficientesMin2(FI, g)
    D = diag(diag(FI' * FI));
    b = FI' * g;
    alfa = zeros(size(b));
    for j = 1:length(b)
        alfa(j) = b(j) / D(j, j);
    end
    disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%:');
    disp('los coeficientes b de MIn 2 son:');
    disp(b);
    disp('los coeficientes alfa de MIn 2 son:');
    disp(alfa);
    disp(' ');
end

function [P, r] = compararPConG(FI, alfa, g)
    P = FI * alfa;
    r = g - P;
    disp('COMPARA P de Min 2 con g(t):');
    disp('la norma del residuo es');
    disp(norm(r, 2));
    disp('la norma de g(t) es');
    disp(norm(g, 2));
end

function graficarComparacion(t, P, g, r, figura1, figura2)
    figure(figura1);
    plot(t, P, '-xb', t, g, 'or');
    grid on;
    title('g(t); P(t) discretos');

    figure(figura2);
    plot(t, P, '-xb', t, g, 'or', t, r, '*r');
    grid on;
    title('g(t); P(t); r(t) discretos');
end

function [c, fase, kw0, kw] = calcularRespuestaFrecuencia(alfa, m, kw0, kw)
    c = zeros(1, m + 1);
    fase = zeros(1, m + 1);
    c(1) = abs(alfa(1));
    fase(1) = 0;
    for k = 2:m + 1
        j = (k - 1) * 2;
        c(k) = sqrt(alfa(j)^2 + alfa(j + 1)^2);
        fase(k) = atan(alfa(j + 1) / alfa(j));
    end
    disp('Rta en Frecuencias');
    fprintf('las frecuencias para cada kw0 son:',kw0);
    disp(' ')
    fprintf('las frecuencias para cada kw son:',kw);
    disp(' ')
    fprintf('la amplitud de c para cada kw0 son:',c);
    disp(' ')
    fprintf('la fase para cada kw0 son:',fase);

end

function graficarRespuestaFrecuencia(kw, c, fase, figura)
    figure(figura);
    subplot(2, 1, 1);
    stem(kw, c, 'b');
    grid on;
    title('Amplitud para cada Frecuencia');
    subplot(2, 1, 2);
    plot(kw, fase, '-ob');
    grid on;
    title('Fase para cada Frecuencia');
end

function [tcom, P_tc] = construirVersionContinuaP(alfa, m, dw, t0, Tp)
    disp('Esta armando la version continua de P(t)');
    tcom = 0:1/100:2*Tp;
    dim_com = length(tcom);
    P_tc = zeros(1, dim_com);
    for j = 1:dim_com
        P_tc(j) = alfa(1);
        for k = 1:m
            P_tc(j) = P_tc(j) + alfa(2 * k) * cos(k * dw * (tcom(j) - t0));
            P_tc(j) = P_tc(j) + alfa(2 * k + 1) * sin(k * dw * (tcom(j) - t0));
        end
    end
end

function graficarComparacionContinua(tcom, P_tc, t, g, figura)
    figure(figura);
    plot(tcom, P_tc, t, g, 'or');
    grid on;
    title('g(t) discreta y Aproximación P(t) continua');
end
