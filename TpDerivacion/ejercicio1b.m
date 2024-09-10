% Definir la función y su derivada exacta
f = @(x) sin(x);
df_exacta = @(x) cos(x);

% Punto donde se evaluará la derivada
x0 = pi/10;

% Diferencias de x (dx) que se van a usar
dx_values = [0.00001, 0.0001, 0.001, 0.01, 0.1];

% Inicialización de las variables para almacenar los resultados
deriv_central = zeros(size(dx_values));
error_central = zeros(size(dx_values));
log_dx = log10(dx_values);
log_error_central = zeros(size(dx_values));

% Cálculo de la derivada numérica central y el error asociado
for i = 1:length(dx_values)
    dx = dx_values(i);
    deriv_central(i) = (f(x0 + dx) - f(x0 - dx)) / (2 * dx); % (-Ys-1 + Ys+1) 2*delta X
    error_central(i) = abs(deriv_central(i) - df_exacta(x0));
    log_error_central(i) = log10(error_central(i));
end

% Mostrar los resultados en forma de tabla
tabla = [dx_values' deriv_central' df_exacta(x0)*ones(size(dx_values')) error_central' log_dx' log_error_central'];
disp('  dx         deriv1 Central   Deriv Exacta   Error Central   log(dx)   log(ErrorCentral)');
disp(tabla);

% Calcular la pendiente en la gráfica log-log
pendiente = diff(log_error_central) ./ diff(log_dx);
disp('Pendientes:');
disp(pendiente);

% Graficar log(dx) vs log(Error central)
figure;
plot(log_dx, log_error_central, '-o');
xlabel('log(dx)');
ylabel('log(Error central)');
title('log(dx) vs log(Error central)');
grid on;

