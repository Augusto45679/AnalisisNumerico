function minimos_cuadrados
clc,clear
% === DATOS ===
N=256;
a=3;
Tp=20*5/a;
t0=0;
dt = Tp/N; % dt = (tf-t0)/N;s
w0 = 2*pi/N; % Frecuencia fundamental para Min2
dw = w0/dt; % incremento de la frecuencia  para Min2

m = -1 + N / 2; % se eligen para senos y cosenos desde 1 a m , Múltiplo de la frecuencia utilizado

% === Funciones ===
f = @(t) exp(-a*t);
coseno = @(k, w0, j) cos(k * w0 * (j - 1));
seno = @(k, w0, j) sin(k * w0 * (j - 1));



  %=== Discretizar g(t) ===
  t = t0 +(0:N-1)'*dt;
  g = arrayfun(f,t); % lo que hace arrayfun es que el primer parametro se le aplica al segundo (la f exponencial se la aplica al intervalo t)
  graficarPrimerFuncion(t,g,1);


  % === Base trigonometrica ===
  [Fi,kw0,kw] = construirBaseTrigonometrica(N,m,w0,dw,coseno,seno);


  % === Calcular coeficientes para Min2 ===
  [alfa,b] = calcularCoeficientesMin2(Fi,g);



  % === Comparar g con P(t) ===
  [P,r]= comparar_P_con_G(Fi,alfa,g);
  graficarcomparacionPyG(t,P,g,r);



  % === Calcular las frecuencias === (transformada de fourier)

  [c,fase,kw0,kw]  = calcularAmplitudFase(alfa,m,kw0,kw);
  graficarAmplitudFase(kw,c,fase);

% === A ===
disp("Hola Mundo!" )
end

function graficarPrimerFuncion(t,g,figura)
      figure(figura)
      grid on
      plot(t,g,'or')
end

%esta funcion lo que hace es construirnos la matriz phi
function [Fi,kw0,kw] = construirBaseTrigonometrica(N,m,w0,dw,coseno,seno)
      Fi = ones(N, 2*m + 1); %inicializa en 1 cos(0)=1
      kw0 = zeros(1,m+1);
      kw = zeros(1,m+1);
      for k=1:m
        kw0(k+1)=k*w0;  %
        kw(k+1) = k*dw; % estas son las frecuencias utilizadas en la base trigonometrica para Min2, definen la frecuencia de cada termino coseno y seno
        for j=1:N
              Fi(j,2*k) =coseno(k,w0,j); %en los pares coloca cosenos
              Fi(j,2*k+1) = seno(k,w0,j); %en los impares coloca senos
          endfor
      endfor
end

% esta funcion calcula los coeficientes que quedan en la diagonal N/4 N/2 N/2
function [alfa,b] = calcularCoeficientesMin2(Fi,g)
  D = diag(diag(Fi'*Fi)); % esto calcula la diagonal
  b = Fi'*g;
  alfa = b ./ diag(D);
  disp('Coeficientes alfa y b:');
end

function [P,r] = comparar_P_con_G(Fi,alfa,g)
  P = Fi*alfa;
  r = g-P;
  disp("La norma del residuo es: ");
  disp(norm(r,2));

  disp("La norma de g(t) es: ");
  disp(norm(g,2));
end


function graficarcomparacionPyG(t,P,g,r)
  figure(2);
  title('P(t) y g(t) discretos');
  grid on;
  plot(t,P,'b',t,g,'r');


  figure(3);
  title('P,g y el residuo r')
  grid on;
  plot(t,P,'r',t,g,'b',t,r,'g')
end


function [c,fase,kw0,kw]= calcularAmplitudFase(alfa,m,kw0,kw)
   c = zeros(1,m+1);
   fase = zeros(1,m+1);

   c(1) = abs(alfa(1));
   fase(1)= 0;

   for k=2:m+1
     j = (k-1)*2;
     c(k) = sqrt(alfa(j)^2+ alfa(j+1)^2); % Formula para la amplitud
     fase(k) = atan(alfa(j+1)/alfa(j)); % Formula para la fase
   endfor
end

function graficarAmplitudFase(kw,c,fase)
figure(4);
    subplot(2, 1, 1);
    stem(kw, c, 'b');
    grid on;
    title('Amplitud para cada Frecuencia');
    subplot(2, 1, 2);
    plot(kw, fase, '-ob');
    grid on;
    title('Fase para cada Frecuencia');

end


