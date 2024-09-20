function eulerModificado

y0=4; t0=0; %valores iniciales
Dt=0.01; %incremento de tiempo
N_Dt=1000; % cantidad de Dt a realizar

%Dimensionamiento
t = zeros(N_Dt,1); %vector para tiempo
y = zeros(N_Dt,1); %vector para y(t)

%Inicialización
t(1)=t0;
y(1)=y0;

w=1; %El euler modificado lleva w=1 y el mejorado lleva w=0.5

for j=1 : N_Dt-1

k1 = Dt*(-(1/2)*y(j) + (1/2)*t(j));
yg = y(j) + k1/(2*w);
tg = t(j) + Dt/(2*w);
k2 = Dt*(-(1/2)*yg + (1/2)*tg);
y(j+1) = y(j)+(1-w)*k1+w*k2;
t(j+1) = t(j)+Dt;
end

% Graficación
figure(1)
plot(t,y(:,1),'b');

endfunction

