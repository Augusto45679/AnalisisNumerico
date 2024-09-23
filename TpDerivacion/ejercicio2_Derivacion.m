function ejercicio2_Derivacion

x0=0; xf=2*pi; % periodo

 f = @(x) cos(x) ; %declaramos la funcion
 df1_exacta = @(x) -sin(x); %derivada primera
 df2_exacta = @(x) -cos(x); %derivada segunda de la funcion

  N_vector = [5,10,20]; % intervalos para discretizar
  dx_vector = (xf-x0) ./ N_vector ;



  for i=1: length(dx_vector)
    dx = dx_vector(i);
    N = N_vector(i);

    x = linspace(x0,xf,N+1); % discretizar la funcion

    df1 = zeros(length(x));
    df2 = zeros(length(x));

    % Derivada primera (central) con orden de error 2
    for j = 2:N %calculamos de esta manera para los valores proximos
      df1(j) = (f(x(j+1)) - f(x(j-1))) / (2*dx);
    end

    % Derivada segunda (central) con orden de error 2
    for j = 2:N
      df2(j) = (f(x(j+1)) - 2*f(x(j)) + f(x(j-1))) / (dx^2);
    end

    % Comparar con las derivadas exactas
    df1_exacta_values = df1_exacta(x);
    df2_exacta_values = df2_exacta(x);

    disp(" ")
     % Gráficas
    figure;
    plot(x,f(x),'b');

  end
  endfunction
