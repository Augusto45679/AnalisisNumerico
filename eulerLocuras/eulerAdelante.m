function eulerAdelante

t0=0; y0=4;
dt=0.25;
N_dt = 127;

t = zeros(1,N_dt);
y = zeros(1,N_dt);

k1 = zeros(1,N_dt);


y_exact = 6*exp(-t/2)-2+t;

t(1)= t0;
y(1)= y0;



for i=1: N_dt-1

k1(i)= dt*(-(1/2)*y(i)+(1/2)*t(i));

%actualizamos los y t
y(i+1)=y(i)+k1(i);
t(i+1)= t(i)+dt;

%guardar en el vector todos lo k1
k(i+1)= k1(i);

end

disp(" ")
figure(1)
plot(t,y(1,:),'b');

endfunction
