% Definir la función y su derivada exacta
f = @(x) sin(x);
df_exacta = @(x) cos(x);

% Punto donde se evaluará la derivada
x0 = pi/10;

% Diferencias de x (dx) que se van a usar
dx_values = [0.00001, 0.0001, 0.001, 0.01, 0.1];

% Inicialización de las variables para almacenar los resultados
deriv_adelante = zeros(size(dx_values));
error_adelante = zeros(size(dx_values));
log_dx = log10(dx_values);
log_error_adelante = zeros(size(dx_values));

% Cálculo de la derivada numérica hacia adelante y el error asociado
for i = 1:length(dx_values)
    dx = dx_values(i);
    deriv_adelante(i) = (f(x0 + dx) - f(x0)) / dx;
    error_adelante(i) = abs(deriv_adelante(i) - df_exacta(x0));
    log_error_adelante(i) = log10(error_adelante(i));
end

% Mostrar los resultados en forma de tabla
tabla = [dx_values' deriv_adelante' df_exacta(x0)*ones(size(dx_values')) error_adelante' log_dx' log_error_adelante'];
disp('  dx         deriv1 Adelant   Deriv Exacta   Error adelante   log(dx)   log(ErrorAdelante)');
disp(tabla);

% Calcular la pendiente en la gráfica log-log
pendiente = diff(log_error_adelante) ./ diff(log_dx);
disp('Pendientes:');
disp(pendiente);

% Graficar log(dx) vs log(Error adelante)
figure;
plot(log_dx, log_error_adelante, '-o');
xlabel('log(dx)');
ylabel('log(Error adelante)');
title('log(dx) vs log(Error adelante)');
grid on;

