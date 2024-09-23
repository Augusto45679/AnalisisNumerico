
function ejercicio3_Derivacion

t0=0; tf=2;
N=100;
dt =(tf-t0)/N;

y = @(t) (1/2)*(1-exp(-2*t));


% Discretizar
for i=2: N
  t(i) = t0 + dt(i-1);
  y(i) = (1/2)*(1- exp(-2*t(i)));
end

%




 endfunction
