function eulerAdelante

t0=0; y0=4;
dt=0.25;
N_dt = 1000;

t = zeros(N_dt,1);
y = zeros(N_dt,1);


y_exact = 6*exp(-t/2)-2+t;

t(1)= t0;
y(1)= y0;



for i=1: N_dt-1

k1 = dt*(-(1/2)*y(i)+(1/2)*t(i));
y(i+1)=y(i)+k1;
t(i+1)= t(i)+dt;

end

figure(1)
plot(t,y(:,1),'b');

endfunction
