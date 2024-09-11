function AuxiliarCuadroGrande

w=1;
deltaT = 0.01;

% Datos
    t = [0,0.01,0.02,0.03,0.04]; %valores de t

    y1_vector = [5,0,0,0,0];
    y2_vector = [3,0,0,0,0];

    %K1 para y1 y2
    k1_y1 = [0,0,0,0,0];
    k1_y2 = [0,0,0,0,0];
    %Tg
    tg_y =  [0,0,0,0,0];
    %Yg para y1 y2
    yg_y1 = [0,0,0,0,0];
    yg_y2 = [0,0,0,0,0];
    %K2 para y1 y2
    k2_y1 = [0,0,0,0,0];
    k2_y2 = [0,0,0,0,0];
   % Y1_+1  para y1 y2
    Y_y1 =  [0,0,0,0,0];
    Y_y2 =  [0,0,0,0,0];

    for i=1:length(t)
    y1 = y1_vector(i);
    y2 = y2_vector(i);
    t0 = t(i);

    %calculos para K1
    k1_y1(i) = deltaT*(-10*y1+4*y2);
    k1y1_aux = k1_y1(i);
    k1_y2(i) = deltaT*(-4*y1+0*y2);
    k1y2_aux = k1_y2(i);

    %calculos para Tg
    tg_y(i) = t0 + deltaT*1/2*w

    %calculos para  yg
    yg_y1(i) = y1 + k1y1_aux* 1/2*w;
    ygy1_aux = yg_y1(i);
    yg_y2(i) = y2 + k1y2_aux* 1/2*w;
    ygy2_aux = yg_y2(i);

    %calculos para k2
    k2_y1(i) = deltaT*(-10*ygy1_aux+4*ygy2_aux);
    k2y1_aux = k2_y1(i);
    k2_y2(i) = deltaT*(-4*ygy1_aux+0*ygy2_aux);
    k2y2_aux = k2_y2(i);

    %calculos para los y
    Y_y1(i) = y1 + k2y1_aux;
    Y_y2(i) = y2 + k2y2_aux;

    y1 = Y_y1(i);
    y2 = Y_y2(i);

    end
  disp('k1  y1                   k1 y2 ');
  for i=1:length(t)
    fprintf('%.8f          %.8f\n',k1_y1(i),k1_y2(i));
  end

endfunction

