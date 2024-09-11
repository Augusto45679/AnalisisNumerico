function EDO_CuadroGrande
% Datos
t = [0,0.01,0.02,0.03,0.04];

y1 = 5; y2 = 3; w=1;
t0=0;
deltaT = 0.01;

k1_y1 = zeros(length(t));
tg_y = zeros(length(t));
yg_y1 = zeros(length(t));
k2_y1 = zeros(length(t));
Y_y1 =  zeros(length(t));

k1_y2 = zeros(length(t));
tg_y2 = zeros(length(t));
yg_y2 = zeros(length(t));
k2_y2 = zeros(length(t));
Y_y2 =  zeros(length(t));

Auxiliar_y1 = zeros(length(t)); % En el cuadro sería y1 (segunda fila)

Auxiliar_y2 = zeros(length(t)); % En el cuadro sería y2 (tercer fila)


for i=1:length(t) %y1
  t_A = t(i);

  %CALCULOS de K1 para y1 e y2
  k1_y1(i) = deltaT*(-10*y1+4*y2);
  k1_y1_A = k1_y1(i); %aux

  k1_y2(i) = deltaT*(-4*y1+0*y2);
  k1_y2_A = k1_y2(i); %aux

  %CALCULOS de TG 1 y 2
  tg_y(i) = t_A + deltaT/2*w;
  tg_y_A = tg_y(i); %aux

  %Calculos de YG 1 y 2
  yg_y1(i) = y1 + k1_y1_A * 1/2*w;
  yg_y1_A = yg_y1(i); %aux

  yg_y2(i) = y2 + k1_y2_A * 1/2*w;
  yg_y2_A = yg_y2(i); %aux

  %Calculos de K2 de 1 y 2

  k2_y1(i) = deltaT*(-10*yg_y1_A+4*y2);
  k2_y1_A  = k2_y1(i) ; %aux

  k2_y2(i) = deltaT*(-4*yg_y2_A+0*y2);
  k2_y2_A  = k2_y2(i) ; %aux

  Y_y1(i) = y1 + (1-w)*k1_y1_A + w*k2_y1_A ;
  y1 = Y_y1(i); %aux pero para el calculo del for

  Auxiliar_y1(i) = y1; % auxiliar pero para la muestra de datos

  Y_y2(i) = y2 + (1-w)*k1_y2_A + w*k2_y2_A ;
  y2 = Y_y2(i); %aux pero para el calculo del for

  Auxiliar_y2(i) = y2; % auxiliar pero para la muestra de datos


end

% Mostrar resultados de a tres columnas
  disp('t                    y1                    y2');
  for i=1:length(t)
    fprintf('%.8f         %.8f         %.8f\n', t(i),Auxiliar_y1(i),  Auxiliar_y2(i));
  end

  disp(" ");
  disp('K1 y1                K1 y2               tg');
  for i=1:length(t)
    fprintf('%.8f         %.8f         %.8f\n', k1_y1(i),  k1_y2(i),  tg_y(i));
  end

  disp(" ");
  disp('YG 1              YG 2                     ');
  for i=1:length(t)
    fprintf('%.8f        %.8f\n',  yg_y1(i), yg_y2(i));
  end

  disp(" ");
  disp('K2 y1              K2 y2');
  for i=1:length(t)
    fprintf('%.8f        %.8f\n',   k2_y1(i),  k2_y2(i));
  end

% Graficar las soluciones aproximadas
figure;
plot(t*10, Auxiliar_y1, '-o', 'DisplayName', 'y1');
hold on;
plot(t*10, Auxiliar_y2, '-s', 'DisplayName', 'y2');
xlabel('t');
ylabel('y');
title('Soluciones Aproximadas');
legend show;
grid on;

% Graficar los errores (si tienes una solución analítica)
% Supongamos que tienes una solución analítica y1_exacto y y2_exacto
% y1_exacto = ...; % Define la solución analítica para y1
% y2_exacto = ...; % Define la solución analítica para y2

% error_y1 = abs(Auxiliar_y1 - y1_exacto);
% error_y2 = abs(Auxiliar_y2 - y2_exacto);

% figure;
% plot(t, error_y1, '-o', 'DisplayName', 'Error y1');
% hold on;
% plot(t, error_y2, '-s', 'DisplayName', 'Error y2');
% xlabel('t');
% ylabel('Error');
% title('Errores');
% legend show;
% grid on;
endfunction

