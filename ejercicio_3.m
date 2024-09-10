  function ejercicio_3

%Para la parte que nos dice, asumir w=2 y N=6,12,18,24
w=2;
t0=0; tf=6/w;
N_vector=[6,12,18,24];
valor_exacto= (1/w)*(1-exp(-6)); %valor exacto de I
dt_vector =  (tf-t0) ./ N_vector;

Im_vector =[0,0,0,0]; %vector de riemann menor
IT_vector = [0,0,0,0];

I= @(t) exp(-w*t); %esto seria la funcion anonima

%Discretizar
    for i=1: length(N_vector)
      N = N_vector(i);
      dt = dt_vector(i);
      t = linspace(t0,tf,N+1);
      yg = I(t);

       Im=0;
      for j=1:N %Riemman
          Im= Im + dt*yg(j);
      end
      Im_vector(i)=Im; %almacenamos los Im en el vector


      IT=0;
      for k=1: N %trapecios
         IT= IT+ dt*(yg(k)+yg(k+1))/2;
      end
      IT_vector(i) =  IT;  %almacenamos los IT en el vector

    end
%Graficar la funcion
 figure;
 N=600;
 T = linspace(t0, tf, N);
    yg = exp(-w * T);
    plot(T, yg, 'b-', 'DisplayName', 'e^{-wt}');
    hold on;

    % Graficar los resultados de Riemann y Trapecios
    plot(N_vector, Im_vector, 'ro-', 'DisplayName', 'Riemann');  % Gráfico para Riemann
    plot(N_vector, IT_vector, 'gx-', 'DisplayName', 'Trapecios');  % Gráfico para Trapecios

  for i=1:length(N_vector)
      printf('Valor exacto: %.8f\n , Riemman: %.8f ,Trapecios: %.8f\n'...
      ,valor_exacto,Im_vector(i),IT_vector(i));
  end

  %Graficar Riemman en funcion de N




    %Graficar Trapecios en funcion de N


  endfunction
