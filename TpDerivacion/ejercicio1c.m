function ejercicio1c
    f = @(x) sin(x); #Definimos la funcion
    df_exacta = @(x) cos(x);
    df_exactaSegunda = @(x) -sin(x);
    x0=pi/10; #punto a evaluar derivadas

    dx_vector =[0.1,0.01,0.001];

    derivida_central = zeros(size(dx_vector));

    error_Absoluto = zeros(size(dx_vector));

    log_dx = log10(dx_vector);
    log_error = zeros(size(dx_vector));

    derivada_centralSegunda = zeros(size(dx_vector));




    for i=1:length(dx_vector)
      dx =  dx_vector(i);

        derivida_central(i) = ( f(dx+x0)- f(dx-x0)) ./ (2*dx);
        derivada_centralSegunda(i) =  (f(dx+x0)+f(dx-x0)-2*f(x0)) ./ (dx^2);

         error_Absoluto(i) = abs(derivada_centralSegunda(i)-df_exactaSegunda(x0));

      log_error(i) = log10(error_Absoluto(i));

    end

    %Calculo de pendientes
    pendientes =  diff(log_error) ./ diff(log_dx);
    display("Pendientes: ")
    display(pendientes)
    display("\n")

   %Mostramos los otros resultados de a tres(meu deus)
  disp('dx_vector               derivada_centralSegunda           df_exactaSegunda');
   for i=1:length(dx_vector)
    fprintf('%.8f                         %.8f            %.8f\n',dx_vector(i),derivada_centralSegunda(i),df_exactaSegunda(x0));
   end

  disp(" ")
  %mostramos los logaritmos
    disp('Error Absoluto               Log(dx)           Log Error');
  for i=1:length(dx_vector)
    fprintf('%.8f            %.8f            %.8f\n',error_Absoluto(i),log_dx(i),log_error(i));

  end

  endfunction
