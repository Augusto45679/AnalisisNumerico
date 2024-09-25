function parcial_Berloin

  g = load('p1_3k10_01.txt');

  t0=0; x1=0; x2=0;

  w=1;

  A11=0;A12=1;A21=-25;A22=-2;

b1=0; b2=1;

fs = 2500;

dt=1/fs;

tf = (length(g)-1)*dt;

A = zeros(2,2); %Matriz A
A(1,1)=A11;
A(1,2)=A12;
A(2,1)=A21;
A(2,2)=A22;

y = zeros(2,length(g));

b = zeros(2,1);
b(1,1)= b1;
b(2,1)= b2;

t= t0:dt:tf; %rango de t

y(1,1)=x1; %inicializo y con las condiciones iniciales
y(2,1)=x2;

it=0;
it2=0;
derivada = zeros(1,length(t));
it21=0;
for i=1:length(t)-1

   g_t = g(i);

   t(i+1) = t(i) +dt;

   k1 = dt*(A*y(:,i)+b*g_t);

   k2 = dt*(A*(y(:,i)+k1/2*w)+b*g_t);

   y(:,i+1)= y(:,i)+k2;

   it = it + (dt/2) * (y(1,i)^2+y(1,i+1)^2); % I11

   derivada(1,i+1) = (-y(1,i)+y(1,i+1))/dt; %derivada

   it2= it2 + (dt/2)*(derivada(1,i)^2+derivada(1,i+1)^2); %I22

   it21 = it21 + (dt/2)*( (y(1,i)+y(1,i+1)) *(derivada(1,i)+derivada(1,i+1) ) ); %I21

endfor


figure(1)
plot(t,y(1,:),'b') %grafico de x1

figure(2)
plot(t,y(2,:),'r') %grafico de x2

disp(['x1(t1) = ', num2str(y(1,6251), '%.3f')])
disp(['x2(t1) = ', num2str(y(2,6251), '%.3f')])
disp(['I11 = ', num2str(it, '%.3f')])
disp(['I21 = ', num2str(it21, '%.3f')])
disp(['t = ', num2str(t(6251))])
disp(" ")
endfunction

