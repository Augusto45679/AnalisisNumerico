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

  Fi = construirBaseTrigonometrica(N,m,w0,coseno,seno);

% === Calcular coeficientes para Min2 ===
  [alfa,b] = calcularCoeficientesMin2(Fi,g);

% === Calcular la FFT === (transformada de fourier)
Gk = fft(g,N);

                                    % aca obtenes las amplitudes y fases de la transformada de fourier
amplitudes_fft = abs(Gk(1:N/2+1));  % Solo la mitad de los coeficientes son útiles (debido a la simetría)
fases_fft = angle(Gk(1:N/2+1));

                                                        % normalizas las amplitudes de fft para que se puedan comparar
amplitudes_fft = amplitudes_fft / max(amplitudes_fft);

% === Comparar amplitudes y fases ===
                                         % Aquí puedes comparar las amplitudes de alfa (de Min2) con las de la FFT
amplitudes_min2 = abs(alfa(2:2:end));    % Solo los términos relevantes de 'alfa'
fases_min2 = angle(alfa(2:2:end));       % Fases de los coeficientes de mínimos cuadrados

graficarComparaciones(amplitudes_min2,amplitudes_fft,fases_min2,fases_fft);
% === A ===
disp("Hola Mundo!" )
end

function graficarPrimerFuncion(t,g,figura)
      figure(figura)
      grid on
      plot(t,g,'or')
end

%esta funcion lo que hace es construirnos la matriz phi
function Fi = construirBaseTrigonometrica(N,m,w0,coseno,seno)
      Fi = ones(N, 2*m + 1); %inicializa en 1 cos(0)=1
      for k=1:m
        for i=1:N
              Fi(i,2*i) =coseno(k,w0,i); %en los pares coloca cosenos
              Fi(i,2*i+1) = seno(k,w0,i); %en los impares coloca senos
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

function graficarComparaciones(amplitudes_min2,amplitudes_fft,fases_min2,fases_fft)
figure;
subplot(2,1,1);
stem(amplitudes_min2, 'r'); hold on;
stem(amplitudes_fft, 'b');
title('Comparación de Amplitudes: Min2 (rojo) vs FFT (azul)');
grid on;

subplot(2,1,2);
plot(fases_min2, 'r'); hold on;
plot(fases_fft, 'b');
title('Comparación de Fases: Min2 (rojo) vs FFT (azul)');
grid on;
end



