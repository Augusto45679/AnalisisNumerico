function primerCodigoResuelto
    clc, clear;

    % Parámetros iniciales
    Tg = 2 * 5;
    Td = 5;
    A1 = 1; A2 = 0;
    t0 = 0;
    tf = Tg;
    N = 4;
    Dt = (tf - t0) / N;
    Tp = N * Dt;
    w0 = 2 * pi / N;
    dw = w0 / Dt;
    m_max = round(N / 2);
    m = -1 + N / 2;
    Nb = 2 * m + 1;
    compara_g_P = 1;

    % Funciones anónimas
    escalon = @(t) A1 * (t < Td) + A2 * (t >= Td);
    coseno = @(k, w0, j) cos(k * w0 * (j - 1));
    seno = @(k, w0, j) sin(k * w0 * (j - 1));

    % Armado de la función g(t) discreta
    t = t0 + (0:N-1)' * Dt;
    g = arrayfun(escalon, t);
    graficarFuncion(t, g, 'g(t)', 1);

    % Construir base trigonométrica
    FI = construirBaseTrigonometricaAnon(N, m, w0, coseno, seno);

    % Calcular coeficientes mínimos
    [alfa, b] = calcularCoeficientesMin2(FI, g);

    % Comparación de P(t) con g(t)
    P = FI * alfa;
    r = g - P;
    graficarComparacion(t, P, g, r, 2, 3);

    % Respuesta en frecuencia
    [c, fase] = calcularRespuestaFrecuencia(alfa, m, w0);
    kw = dw * (0:m);
    graficarRespuestaFrecuencia(kw, c, fase, 4);

    % Comparación entre versión discreta de g(t) y continua de P(t)
    if compara_g_P == 1
        tcom = linspace(0, 2*Tp, 100);
        P_tc = construirVersionContinuaAnon(alfa, m, dw, tcom, t0);
        graficarComparacionContinua(tcom, P_tc, t, g, 10);
    end
end

function FI = construirBaseTrigonometricaAnon(N, m, w0, coseno, seno)
    FI = ones(N, 2 * m + 1);  % Inicializa la columna para cos(0) = 1
    for k = 1:m
        for j = 1:N
            FI(j, 2*k) = coseno(k, w0, j);
            FI(j, 2*k+1) = seno(k, w0, j);
        end
    end
end

function [alfa, b] = calcularCoeficientesMin2(FI, g)
    D = diag(diag(FI' * FI));
    b = FI' * g;
    alfa = b ./ diag(D);  % Simplifica el cálculo de los coeficientes alfa
    disp('Coeficientes alfa y b:');
    disp(alfa);
end

function [c, fase] = calcularRespuestaFrecuencia(alfa, m, w0)
    c = zeros(1, m + 1);
    fase = zeros(1, m + 1);
    for k = 1:m
        j = (k - 1) * 2;
        c(k+1) = sqrt(alfa(j+1)^2 + alfa(j+2)^2);
        fase(k+1) = atan2(alfa(j+2), alfa(j+1));
    end
    disp('Amplitud y fase para cada frecuencia:');
    disp(c);
    disp(fase);
end

function P_tc = construirVersionContinuaAnon(alfa, m, dw, tcom, t0)
    P_tc = alfa(1) + arrayfun(@(t) sum( ...
        alfa(2:2:2*m).*cos(dw*(1:m)*(t - t0)) + ...
        alfa(3:2:2*m+1).*sin(dw*(1:m)*(t - t0)) ...
    ), tcom);
end

% Funciones gráficas
function graficarFuncion(t, g, titulo, figura)
    figure(figura);
    plot(t, g, '-or');
    grid on;
    title(titulo);
end

function graficarComparacion(t, P, g, r, figura1, figura2)
    figure(figura1);
    plot(t, P, '-xb', t, g, 'or');
    grid on;
    title('g(t); P(t) discretos');

    figure(figura2);
    plot(t, r, '*r');
    grid on;
    title('Residuo r(t)');
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

function graficarComparacionContinua(tcom, P_tc, t, g, figura)
    figure(figura);
    plot(tcom, P_tc, t, g, 'or');
    grid on;
    title('g(t) discreta y Aproximación P(t) continua');
end

