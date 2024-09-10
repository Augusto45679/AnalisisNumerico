function ejercicio1
    %Datos
Im=0; IM=0; IT=0; % Riemman menor;Riemman mayor; Trapecios
N=20; %num,ero de intervalos
t0=0; tf=0.5; % Rango de las absisas

w=2*pi; %Frecuencia
%datos discretizar
dt=(tf-t0)/N ; %Incremento de la abscisa
dim=N+1; %dimension de los vectores

%Discretizar
for k=1 : dim
  tg(k)=t0+(k-1)*dt;
  yg(k)=sin(pi*tg(k)); %vamo hacer un coseno pa probar
end
%Graficar
figure(1)
plot(tg,yg,'ob')
grid on
legend('N=20')

%Calculos de Riemman y Trapecios
for k=1 : dim-1 % |dim-1=N || RIEMANN MENOR
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
fprintf('\n') % Línea en blanco

display(dt)
%Calculo de los errores y Pendiente con la formula del TP
 valor_exacto = -cos(pi*tf)/pi - (-cos(pi*t0)/pi);
 display(valor_exacto)
 fprintf('\n')
 fprintf('Riemann menor: \n ')


%Calculo de errores de Riemman menor
Er_Im= abs(valor_exacto-Im);
display(Er_Im)

%Calculo de los logaritmos

%Calculo de la pendiente
pendiente = (log10(Er_Im))/(log10(dt));
display(pendiente)
%Calculo de Im(delta t)

fprintf('\n') % FINAL DE Riemman menor



%AHORA LOS TRAPECIOS LOCO
fprintf('\n') % Línea en blanco
fprintf('Trapecios: \n ')

Er_IT= abs(valor_exacto-IT); %calculo del error
display(Er_IT)

pendiente_IT = (log10(Er_IT))/(log10(dt)); %calcul de la pendiente
display(pendiente_IT)
fprintf('\n')

endfunction

