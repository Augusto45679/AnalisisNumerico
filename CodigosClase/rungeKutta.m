function rungeKutta

% Datos
t0=0; y0=4; w=1;

t = [0,0.25,0.5];
deltaT = 0.25;

k1 = zeros(length(t));
tg = zeros(length(t));
yg = zeros(length(t));
k2 = zeros(length(t));
Y = zeros(length(t));
Aux_y = [y0,0,0];

%definir funcion

 f = @(t) t/2;

for i=1: length(t)
 t_A = t(i) ;
 k1(i) = deltaT *f(t_A-y0);
 k_A = k1(i); %aux

 tg(i) = t_A + deltaT /2*w;
 tg_A = tg(i)  ; %aux

 yg(i) = y0 + k_A / 2*w;
  yg_A = yg(i) ; %aux

  k2(i) = deltaT * f(tg_A-yg_A);
  k2_A  = k2(i) ; %aux

 Y(i) = y0 + (1-w)*k_A + w*k2_A;
  y0 = Y(i)  ;
  Aux_y(i) = y0;

end

%Muestra de datos

 disp('t                    y                   k1');
  for i=1:length(t)
    fprintf('%.8f         %.8f         %.8f\n', t(i),Aux_y(i), k1(i));
  end

  disp(" ");
  disp('yg                 xg                k2');
  for i=1:length(t)
    fprintf('%.8f         %.8f         %.8f\n',  yg(i),  tg(i), k2(i));
  end

  disp(" ");
  disp('Y              ');
  display(Y);
  endfunction
