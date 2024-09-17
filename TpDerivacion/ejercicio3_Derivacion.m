pkg load symbolic;

function ejercicio3_Derivacion
pkg load symbolic;
x0=0; xf=2;

N_vector = [5,10,20];

dx_vector = (xf-x0) ./ N_vector;

syms t;
y = 1/2 * (1 -exp(-2*t));

%vamos a ver como hacer la deriva simbolica de esto
dy_dt = diff(y,t);

dy2_dt2 = diff(dy_dt,t);

disp(dy_dt)
disp(dy2_dt2)


 endfunction
