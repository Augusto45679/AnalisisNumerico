function EDO_CuadroGrande
% Datos

y1 = 5; y2 = 3; w=1;
t0=0;
dt = 0.02;
N_dt = 100;

t = zeros(1, N_dt); %esta matriz tiene una fila
y = zeros(2, N_dt); %esta matriz tiene dos filas
k1 = zeros(2,N_dt);

tg = zeros(1,N_dt);

yg = zeros(2,N_dt);

k2 = zeros(2,N_dt);

Y_grande = zeros(2,N_dt);


t(1)=t0;
y(1,1)=y1;
y(2,1)=y2;

for i=1: N_dt-1

  k1(1,1) = dt*(-10*y(1,i)+4*y(2,i));
  k1(2,1) = dt*(-4*y(1,i)+0*y(2,i));

  %actualizacion del k1
  k1(1,1+i)= k1(1,1);
  k1(2,1+i)= k1(2,1); % aca dejo guardado todos los k1 en la matriz

  tg(1,i)= t(i) + dt/2*w;
  %actualizamos los tg
  tg(1,i+1)= tg(1,i);

  yg(1,1) = y(1,1)+ k1(1,1)*1/2*w;
  yg(2,1) = y(2,1)+ k1(2,1)*1/2*w;

  %actualizamos los yg
  yg(1,i+1)= yg(1,1);
  yg(2,1+i)= yg(2,1);

  k2(1,1)= dt*(-10*yg(1,1)+4*y(2,1));
  k2(2,1)= dt*(-4*yg(1,1)+0*y(2,1));

  %actualizacion k2
  k2(1,1+i)= k2(1,1);
  k2(2,1+i)= k2(2,1);

  Y_grande(1,1) = y(1,1) + k2(1,1); %estos serian los y1(n+1) e y2(n+1)
  Y_grande(2,1) = y(2,1) + k2(2,1);

  %actualizar los y grande
  Y_grande(1,1+i)= Y_grande(1,1);
  Y_grande(2,1+i)= Y_grande(2,1);

  %guardamos todos los Y
  y(1,i+1) = y(1,i)+ k1(1,1);
  y(2,i+1) = y(2,i)+ k1(2,1);

  t(i+1) = dt + t(i);

end

disp(" ")
% Graficar las soluciones aproximadas
 figure(1)
plot(t,y(:,:),'b')
legend show;
grid on;


endfunction

