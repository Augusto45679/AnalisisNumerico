## Author: AugustoPC <AugustoPC@AUGUSTO-NOTE>
## Created: 2024-08-20
%calcular primero los valores del intervalo; luego los valores de la ordenada; luego graficar

function retval = cossin (input1, input2)
  Im=0;IM=0;IT=0;
   % frecuencia de PI
  t0=0;tf=2*pi; %rango de absisas
  N=8; %numero de intervalos para el rango de absisas
  dim=N+1; % dimension de los vectores
  dt=(tf-t0)/N ;%incremento de la absisas
  %DISCRETIZACIÓN
 for k=1: dim
  tg(k)=t0+(k-1)*dt;
  yg(k)=sin(tg(k))*cos(tg(k));
  end

 %Graficar
figure(1)
plot(tg,yg,'ob')
grid on
legend('N=8')
%Calculos de RIemman y Trapecios
for k=1:dim-1 % dim=N+1
  Im=Im+dt*yg(k);
end

for k=1:dim %dim=N+1
  IM=IM+dt*yg(k);
end

for k=1:dim-1 %Trapecio
  IT= IT+dt*(yg(k)+yg(k+1))/2;
end
disp(Im);
disp(IM);
disp(IT);
endfunction
