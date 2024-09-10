% cos()
function John
  %Datos
Im=0; IM=0; IT=0; % Riemman menor;Riemman mayor; Trapecios
N=400; %num,ero de intervalos
t0=0; tf=4; % Rango de las absisas

%datos discretizar
dt=(tf-t0)/N ; %Incremento de la abscisa
dim=N+1; %dimension de los vectores

%Discretizar

for k=1 : dim
  tg(k)=t0+(k-1)*dt;
  yg(k)=cos(pi*tg(k)); %vamo hacer un coseno pa probar
end

%Graficar
figure(1)
plot(tg,yg,'ob')
grid on
legend('N=400')

%Calculos de Riemman y Trapecios

for k=1 : dim-1 % dim-1=N || RIEMANN MENOR
  Im=Im + dt*yg(k);
end

  for k=2 :dim %dim=N+1 (es la dimension del vector) || RIEMANN Mayor
  IM=IM + dt*yg(k);
end

for k=1:dim-1 % TRAPECIOS
  IT=IT+dt*(yg(k)+yg(k+1))/2;
end

%mostramos valores
display(Im)
display(IM)
display(IT)
endfunction

