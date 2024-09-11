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

  yg_y2(i) = y1 + k1_y2_A * 1/2*w;
  yg_y2_A = yg_y2(i); %aux

  %Calculos de K2 de 1 y 2

  k2_y1(i) = deltaT*(-10*yg_y1_A+4*y2);
  k2_y1_A  = k2_y1(i) ; %aux

  k2_y2(i) = deltaT*(-4*yg_y2_A+0*y2);
  k2_y2_A  = k2_y2(i) ; %aux

  Y_y1(i) = y1 + (1-w)*k1_y1_A + w*k2_y1_A ;
  y1 = Y_y1(i); %aux

  Y_y2(i) = y2 + (1-w)*k1_y1_A + w*k2_y1_A ;
  y2 = Y_y2(i); %aux

end

% Mostrar resultados de a tres columnas
  disp('t                    y1                    y2');
  for i=1:length(t)
    fprintf('%.8f         %.8f         %.8f\n', t(i),Y_y1(i), Y_y2(i));
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

  % Graficar los resultados
  figure;
  plot(t, Y_y1, '-o', 'DisplayName', 'y_1(t)');
  hold on;
  plot(t, Y_y2, '-x', 'DisplayName', 'y_2(t)');
  xlabel('t');
  ylabel('y(t)');
  title('Solución aproximada del sistema de EDO');
  legend show;
  grid on;
  hold off;
endfunction

