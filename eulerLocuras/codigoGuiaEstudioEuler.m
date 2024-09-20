function codigoGuiaEstudioEuler

t0=0; u0=2;
dt=0.1;
N_dt=300;

t= zeros(1,N_dt);
u = zeros(1,N_dt);

k1 = zeros(1,N_dt);


t(1)=t0;
u(1)=u0;

for i=1:N_dt-1

  k1(i) = dt*(2*u(i)-2*t(i)-1 );
  k1(i+1)=k1(i);

  %actualizamos
  u(i+1)= u(i)+k1(i);
  t(i+1)= dt+t(i);

end

disp("Si llego acá, anduvo")
figure(1)
plot(t,u(1,:),'b')
endfunction


