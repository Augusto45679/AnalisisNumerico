function ejercicio4TPMin2

% importar el registro
g = load('Registro_240901.txt');
% == Datos ==

fs =16000;
Dt = 1/fs;
t0=0; tf=1;
N= length(g);
w0= 2*pi/N;
dw = w0/Dt;
Tp = N*Dt;
m = floor((N-1)/2); % floor se usa para rendondear hacia abajo
% ==========

t = t0 + (0:N-1)'*Dt; % discretizar el tiempo
 % f = arrayfun(g,t);
  graficarRegistro(t,g,1);
disp(['Dimensiones del registro g: ', num2str(size(g))]);
disp(['Número de muestras N: ', num2str(N)]);
disp(['Frecuencia de muestreo fs: ', num2str(fs)]);
disp(['Tamaño de g: ', num2str(length(g))]);
disp(['Tamaño de t: ', num2str(length(t))]);

coseno = @(k, w0, j) cos(k * w0 * (j - 1));
seno = @(k, w0, j) sin(k * w0 * (j - 1));

% Hacemos la base de senos y cosenos
   [Fi,kw0,kw] = construirBaseTrigonometrica(N,m,w0,dw,coseno,seno);
disp("H")
% Buscamos los coeficientes
   [alfa,b] = calcularCoeficientes(Fi,g);

% Comparamos P con g
 [P,r]= compararP_G(Fi,alfa,g);
  disp(['Tamaño de P: ', num2str(length(P))]);
  disp(['Tamaño de r: ', num2str(length(r))]);
    graficarcomparacionPyG(t, P, g, r)


% Calcular frecuencias TDF
  [c, fase, kw0, kw] = calcularAmplitudFase(alfa, m, kw0, kw);
  graficarAmplitudFase(kw, c, fase);


% Aplicar FFT y comparar con los resultados de Mínimos Cuadrados
G_fft = fft(g);
freqs = (0:N/2)*(fs/N); % Crear vector de frecuencias correcto
c_fft = abs(G_fft(1:N/2+1)) / (N/2);
c_fft(1) = c_fft(1) / 2;

figure(5);
subplot(2, 1, 1);
% Asegúrate de que los vectores tengan la misma longitud
kw_plot = kw(1:min(length(kw), length(c_fft)));
c_plot = c(1:length(kw_plot));
c_fft_plot = c_fft(1:length(kw_plot));

stem(kw_plot, c_plot, 'b');
hold on;
stem(kw_plot, c_fft_plot, 'r');
grid on;
title('Amplitud para cada Frecuencia (Min2 vs FFT)');
legend('Min2', 'FFT');

subplot(2, 1, 2);
plot(kw_plot, fase(1:length(kw_plot)), '-ob');
grid on;
title('Fase para cada Frecuencia');

% Recuperar la función original usando IFFT
 g_recuperado = ifft(G_fft);
 figure(6);
plot(t, g, 'b', t, real(g_recuperado), 'r');
grid on;
title('Registro original vs Recuperado con IFFT');
legend('Original', 'Recuperado');

end

function graficarRegistro(t,g,figuree)
  figure(figuree);
  grid on;
  plot(t,g,'or');
  title('Registro sin modificacion');
end

function [Fi,kw0,kw] = construirBaseTrigonometrica(N,m,w0,dw,coseno,seno)
     Fi = ones(N, 2*m + 1); %inicializa en 1 cos(0)=1
      kw0 = zeros(1,m+1);
      kw = zeros(1,m+1);
      for k=1:m
        kw0(k+1) = k*w0;
        kw(k+1) = k*dw;
        for j=1:N
            Fi(j, 2*k) = coseno(k, w0, j); % En los pares coloca cosenos
            Fi(j, 2*k+1) = seno(k, w0, j); % En los impares coloca senos
        endfor
      endfor
end

function [alfa,b] = calcularCoeficientes(Fi,g)
      D = diag(diag(Fi' * Fi)); % Esto calcula la diagonal
    b = Fi' * g;
    alfa = b ./ diag(D);
    disp(['Tamaño de alfa: ', num2str(length(alfa))]);
    disp(['Tamaño de b: ', num2str(length(b))]);
end

function [P,r] = compararP_G(Fi,alfa,g)
    P = Fi * alfa;
    r = g - P;
    disp("La norma del residuo es: ");
    disp(norm(r, 2));

    disp("La norma de g(t) es: ");
    disp(norm(g, 2));
end

function graficarcomparacionPyG(t, P, g, r)
    if length(t) ~= length(P) || length(t) ~= length(g) || length(t) ~= length(r)
        disp('Error: Los vectores tienen diferentes longitudes');
        disp(['t: ', num2str(length(t)), ', P: ', num2str(length(P)), ...
              ', g: ', num2str(length(g)), ', r: ', num2str(length(r))]);
        return;
    end

    figure(2);
    title('P(t) y g(t) discretos');
    grid on;
    plot(t, P, 'b', t, g, 'r');

    figure(3);
    title('P, g y el residuo r');
    grid on;
    plot(t, P, 'r', t, g, 'b', t, r, 'g');
end

function [c, fase, kw0, kw] = calcularAmplitudFase(alfa, m, kw0, kw);
      c = zeros(size(kw));
      fase = zeros(size(kw));
    c(1) = abs(alfa(1));
    fase(1) = 0;

   for k = 2:length(kw)
        j = (k-1) * 2;
        if j+1 <= length(alfa)
            c(k) = sqrt(alfa(j)^2 + alfa(j+1)^2);
            fase(k) = atan2(alfa(j+1), alfa(j));
        end
    end
end

function graficarAmplitudFase(kw, c, fase)
    if length(kw) ~= length(c) || length(kw) ~= length(fase)
        disp('Error: Los vectores tienen diferentes longitudes');
        disp(['kw: ', num2str(length(kw)), ', c: ', num2str(length(c)), ...
              ', fase: ', num2str(length(fase))]);
        return;
    end

    figure(4);
    subplot(2, 1, 1);
    stem(kw, c, 'b');
    grid on;
    title('Amplitud para cada Frecuencia');

    subplot(2, 1, 2);
    plot(kw, fase, '-ob');
    grid on;
    title('Fase para cada Frecuencia');
end
