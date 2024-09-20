function rungeKuttaSistemasLocos

t0=0; tf=5;
deltaT = 6.25e-5;
p=120;
fprintf("%.8f",deltaT);

matriz_central = [0,1,0; -p^2/4,-p,0;1,0,-p];
disp(" ")
disp(matriz_central)
endfunction

