function senoDeLaClase
   t0=0;tf=1; %rango de absisas
  N=800;%numero de intervalos para el rango de absisas
  dim=N+1 % dimension de los vectores
  dt=(tf-t0)/N ;%incremento de la absisas
Im=0; IM=0; IT=0;
  %Discretizar
for k=1: dim
  tg(k)=t0+(k-1)*dt;
  yg(k)=exp(-5*tg(k))*sin(15*tg(k));
  end
%Graficar
figure(1)
plot(tg,yg,'ob')
grid on
  legend('N=90')

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
display(Im);
display(IM);
display(IT);
  endfunction
