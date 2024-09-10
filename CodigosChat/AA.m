function metodoSinson %Este es el Ejercicio2 del TP

vector_N = [4, 6, 8, 12]; % número de intervalos
t0 = 0; tf = 0.5; % rango abscisas
vector_dt = (tf - t0) ./ vector_N; % dt= (t0-tf)/N
Log_dt_vector = zeros(1, length(vector_N));

% Declarar la función anónima
yg = @(t) sin(pi * t);

valor_exacto = 1/pi; % valor de sin(pi*t)

ISim_vector = zeros(1, length(vector_N));
Pendiente_vector = zeros(1, length(vector_N));
Er_vector = zeros(1, length(vector_N));
Log_Er_vector = zeros(1, length(vector_N));

for i = 1:length(vector_N)

  N = vector_N(i);
  dt = abs(vector_dt(i));

  % Discretización del intervalo
  t = linspace(t0, tf, N+1);
  yk = yg(t);

  ISim = 0;
  for j = 2:2:N
    ISim = ISim + dt * (yk(j-1) + 4 * yk(j) + yk(j+1)) / 3;
  end

  % Calcular el error
  Er = abs(ISim - valor_exacto);
  Er_vector(i) = Er;

  % Ahora los valores de ISim
  ISim_vector(i) = ISim;

  % Valores de los logaritmos
  Log_dt_vector(i) = log10(dt);
  Log_Er_vector(i) = log10(Er);
end

% Cálculo para la pendiente
for i = 2:length(vector_N)
  Pendiente_vector(i) = (Log_Er_vector(i) - Log_Er_vector(i-1)) / (Log_dt_vector(i) - Log_dt_vector(i-1));
end

% Mostrar los valores
for i = 1:length(vector_N)
  printf('N = %d, Δt = %.8f, ISim(Δt) = %.8f, Er = %.8f, Log(Δt) = %.8f, Log(Er) = %.8f, Pendiente = %.8f\n', ...
         vector_N(i), vector_dt(i), ISim_vector(i), Er_vector(i), Log_dt_vector(i), Log_Er_vector(i), Pendiente_vector(i));
end

% Graficar ISim(Δt) para cada N
figure;
plot(vector_N, ISim_vector, '-o', 'LineWidth', 2);
xlabel('N (Número de intervalos)');
ylabel('ISim(Δt)');
title('Valores de ISim(Δt) vs N');
grid on;

% Graficar la función continua
figure;
N = 10;
t_cont = linspace(t0, tf, N);
yg_cont = sin(pi * t_cont); % Evaluación de la función continua
plot(t_cont, yg_cont, 'or');
legend('N=100');
grid on;

endfunction

