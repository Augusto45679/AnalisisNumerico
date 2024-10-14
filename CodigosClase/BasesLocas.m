function BasesLocas

%cambio de escala -> nos conviene hacerlo comparando segmentos (el proyectado y el que esta abajo)

%debemos digitalizar N=4, tenemos un periodo.

%Base generica en gris

%Base continua en azul

%--------------- DATOS-------------------
N=4; k=1; %N = numero de intervalos, k es una cte

tg=2*5; %Periodo de la funcion escalon

td = 5; %Primera duracion del escalon

A1 =0 ; A2=0; %Amplitudes de g(t)

t0=0; tf= tg; %rango de t para g(t)

dt = (tf-t0)/N; %incremento de t

dt = tp/N;

tp = N*dt; % El periodo es tp = (tf-to)


n = 1:N;

tn = t1 + dt(n-1)



t1 = 0;
% t es el punto a evaluar
x = @(t) (2*pi/tp)*(t-t1)

%--------- LOS PHI -------------------
phi1 = @(t) 1;
phi2 = @(t) cos( ( 2*pi/(tp) ) *(t-t1));
phi3 = @(t) sin(( 2*pi/(tp) ) *(t-t1));


% ----------------- y -----------------
 y = [1;1;0;0];
% P(t) son todos los phi
P = [ 1 1 0
    ; 1 0 1
    ; 1 -1 0
    ; 1  0 -1
    ];

P_transpuesta = P';
% ----------RESIDUO---------------

 % r = y - P*a;

 % phi^T*phi*a = phi^T*y; T es la transpuesta

% ---------

disp("")

endfunction

