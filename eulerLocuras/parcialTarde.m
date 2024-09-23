function parcialTarde

g = load('p1_3k9_01.txt');

t0=0; x1=0; x2=0;

w=1;

A11=0;A12=1;A21=-14400;A22=-2.4;

b1=0; b2=1;

dt=0.0002;

tf = (length(g)-1)*dt;

A = zeros(2,2);
A(1,1)=A11;
A(1,2)=A12;
A(2,1)=A21;
A(2,2)=A22;

y = zeros(2,length(g));

b = zeros(2,1);
b(1,1)= b1;
b(2,1)= b2;

t= t0:dt:tf;

y(1,1)=x1;
y(2,1)=x2;

it=0;
it2=0;
for i=1:length(t)-1

   g_t = g(i);

   t(i+1) = t(i) +dt;

   k1 = dt*(A*y(:,i)+b*g_t);

   k2 = dt*(A*(y(:,i)+k1/2*w)+b*g_t);

   y(:,i+1)= y(:,i)+k2;

   it = it + (dt/2) * (y(1,i)^2+y(1,i+1)^2); % I11

   derivada = (y(1,i+1)-y(1,i))/dt; %derivada

   it2= it2 + (dt/2)*(derivada^2); %I22
endfor


figure(1)
plot(t,y(1,:),'b')
disp(" ")


endfunction

