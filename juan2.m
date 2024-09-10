function juan2
    %Datos
Im=0; IM=0; IT=0; % Riemman menor;Riemman mayor; Trapecios
N=50; %num,ero de intervalos
t0=0; tf=2.5; % Rango de las absisas

w=2*pi; %Frecuencia
%datos discretizar
dt=(tf-t0)/N ; %Incremento de la abscisa
dim=N+1; %dimension de los vectores

%Discretizar
for k=1 : dim
  tg(k)=t0+(k-1)*dt;
  yg(k)=exp(-2*tg(k)); %vamo hacer un coseno pa probar
end
for t=1 : dim
  yt(t)=(1/2)*(1-exp(-2*tg(t))); %vamo hacer un coseno pa probar
end
%Graficar
figure(1)
    hold on
    plot(tg, yg, 'ob') % Gráfica de y(t) = exp(-2t)
    plot(tg, yt, 'or') % Gráfica de G(t) = (1/2) * (1 - exp(-2t))
    hold off
    grid on
    legend('y(t) = e^{-2t}', 'G(t) = (1/2)(1 - e^{-2t})')
    xlabel('t')
    ylabel('y(t) y G(t)')
title('y(t) = e^{-2t} y su primitiva G(t)')
display(tg)
display(yt)
%Calculos de Riemman y Trapecios
for k=1 : dim-1 % |dim-1=N || RIEMANN MENOR
  Im=Im + dt*yg(k);
end
  for k=2 :dim %dim=N+1 (es la dimension del vector) || RIEMANN Mayor
  IM=IM + dt*yg(k);
end

for k=1:N   % TRAPECIOS
  IT=IT+dt*(yg(k)+yg(k+1))/2;

end
IT= (dt)*IT;

%mostramos valores
display(Im)
display(IM)
display(IT)
fprintf('\n') % Línea en blanco

valor_exacto = (-1/2)*exp(-2*dt);
display(valor_exacto)

%grafico de la funcion de la integral


%Graficar

endfunction
