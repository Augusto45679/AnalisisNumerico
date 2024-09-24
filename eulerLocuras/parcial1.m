function parcial1

 % Datos
  x1 = 0; x2 = 0;
  t0 = 0; tf = 12.5664;

  N_dt = 3000;
  dt = (tf - t0) / N_dt;

  y = zeros(2, N_dt);
  t = zeros(1, N_dt);

  k1 = zeros(2, N_dt);
  it = 0; it2=0;
  y(1,1) = x1;
  y(2,1) = x2;
  t(1) = t0;
  t(end) = tf;
  derivada = zeros(1, N_dt);

  % Bucle para calcular los valores de y y t
  for j = 1:N_dt-1
    t(j+1) = t(j) + dt;

    k1(1,j+1) = 0.00000*y(1,j)+1.0000*y(2,j)+0*sin(3.00*t(j));
    k2(2, j+1) = -(2.00)^2*y(1,j)-0.02000*y(2,j) -1*sin(3.00*t(j));

    y(1, j+1) = y(1,j) + dt*k1(1,j+1);
    y(2,j+1) = y(2,j) + dt*k2(2,j+1);

    it = it + (dt/2) * (y(1,j)^2+y(1,j+1)^2); %% IT

    for i=2:N_dt-1
      derivada(i) = (y(1,i+1) - y(1,i-1)) / (2 * dt);
    endfor
    it2= it2 + (dt/2)*(derivada(1,i)^2+derivada(1,i+1)^2); %I22
  endfor
   disp("")
   fprintf('%.8f',it2)
  % Graficar x1(t)
  %% figure(1)
  %% plot(t, y(1,:), 'b') % grafica x1(t)
  % Calcular la derivada central

  % Graficar la derivada central
  %% figure(2)
  %% plot(t, derivada(1,:), 'rb'); % graficas

  % Calcular la integral utilizando la regla del trapecio



endfunction

