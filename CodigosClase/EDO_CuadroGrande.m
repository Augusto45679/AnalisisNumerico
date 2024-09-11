function EDO_CuadroGrande
% Datos
t = [0,0.01,0.02,0.03,0.04];

y1 = 5; y2 = 3; w=1;
t0=0;
deltaT = 0.01;

k1_y1 = zeros(length(t));
tg_y1 = zeros(length(t));
yg_y1 = zeros(length(t));
k2_y1 = zeros(length(t));
Y_y1 =  zeros(length(t));

k1_y2 = zeros(length(t));
tg_y2 = zeros(length(t));
yg_y2 = zeros(length(t));
k2_y2 = zeros(length(t));
Y_y2 =  zeros(length(t));

for i=1:length(t) %y1
  t_A = t(i);

  k1_y1(i) = deltaT*(-10*y1+4*y2);
  k1_y1_A = k1_y1(i); %aux

  tg_y1(i) = t_A + deltaT/2*w;
  tg_y1_A = tg_y1(i); %aux

  yg_y1(i) = y1 + k1_y1_A * 1/2*w;
  yg_y1_A = yg_y1(i); %aux

  k2_y1(i) = deltaT * f(tg_y1_A -yg_y1_A);
  k2_y1_A  = k2_y1(i) ; %aux

  Y_y1(i) = y1 + (1-w)*k1_y1_A + w*k2_y1_A ;
  y1 = Y_y1(i); %aux

  for j=1: length(t) %y2

    k1_y2(j) = deltaT*(-10*y1+4*y2);
    k1_y2_A = k1_y2(i); %aux

    tg_y2(j) = t_A + deltaT/2*w;
    tg_y2_A = tg_y2(i); %aux

    yg_y2(j) = y2 + k1_y2_A * 1/2*w;
    yg_y2_A = yg_y1(i); %aux

    k2_y2(j) = deltaT * f(tg_y1_A -yg_y1_A);
    k2_y2_A  = k2_y2(i) ; %aux

    Y_y2(j) = y2 + (1-w)*k1_y2_A + w*k2_y2_A ;
    y2 = Y_y2(i); %aux

  end

end

endfunction

