function ejercicio1_vectores

vector_N = [10,20,40,80]; % numero de intervalos
t0=0; tf=0.5; %rango abscisas

vector_dt = [0,0,0,0]; %este es el vector que almacena todos los delta t
vector_dt = (tf- t0) ./ vector_N ; % dt= (t0-tf)/N, el ./ se hace para la division con vectores
Log_dt_vector = [0,0,0,0]; %este es el vector que almacena los logaritmos de delta t


yg = @(t) sin(pi*t);

valor_exacto= 1/pi; % valor de sin(pi*t)

Pendiente_vector = [0,0,0,0]; %este es el vector de todas las pendientes
Er_vector = [0,0,0,0]; %este es el vector de Er (errores)
Log_Er_vector = [0,0,0,0]; %este es el vector del logaritmo de Er
Im_vector = [0,0,0,0]; %vector que va a tener los valores de Riemman menor
IM_vector = [0,0,0,0]; %vector que va a tener los valores de Riemman MAYOR
IT_vector = [0,0,0,0]; %vector que va a tener los valores de Trapecios
Er_vector_IT= [0,0,0,0];
Pendiente_vector_IT = [0,0,0,0];

for i=1:length(vector_N)
  N = vector_N(i);
  dt = vector_dt(i);

   % Discretización del intervalo
    t = linspace(t0, tf, N+1);
    yk = yg(t);

  Im=0;
  for j=1: N
        Im = Im + dt*yk(j);
  end
Im_vector(i) = Im;

  IM=0;
  for j=2:N+1
      IM = IM + dt*yk(j);
  end

  IT=0;
  for j=1:N
    IT= IT+ dt*(yk(j)+yk(j+1))/2;
  end
IT_vector(i) = IT;

%Calculo de errores
Er = abs((Im-valor_exacto));
Er_vector(i) = Er; %almacenamos los errores dentro del vector

%Logaritmos de dt y Er
Log_Er_vector(i) = log10(Er); % acá lo mismo para dt y Er almacenamos los logaritmos de dt y Er en los vectores
Log_dt_vector(i) = log10(dt);


%CALCULO DE ERRORES DE TRAPECIOS MULTIPLES
Er_IT = abs((IT-valor_exacto));
Er_vector_IT(i) = Er_IT;

end

  %Calculo de la pendiente RIEMMAN
  for i=2:length(vector_N)
      Pendiente_vector(i)= (Log_Er_vector(i)-Log_Er_vector(i-1)) ./ (Log_dt_vector(i)-Log_dt_vector(i-1));
  end

  %Mostramos los valores
  display("Tabla de Riemman menor")
  for i=1: length(vector_N)

   printf('N = %d, Δt = %.8f, Im(Δt) = %.8f, Er = %.8f, Log(Δt) = %.8f, Log(Er) = %.8f, Pendiente = %.8f\n', ...
        vector_N(i), vector_dt (i), Im_vector(i),Er_vector(i), Log_dt_vector(i), Log_Er_vector(i), Pendiente_vector(i));
  end
  printf('');

   %Calculo de la pendiente TRAPECIO
  for i=2:length(vector_N)
      Pendiente_vector_IT(i)= (Er_vector_IT(i)-Er_vector_IT(i-1)) ./ (Log_dt_vector(i)-Log_dt_vector(i-1));
  end

  %Mostramos los valores del TRAPECIO MULTIPLE
  display("Tabla de Trapecios Multiples")
    for i=1: length(vector_N)

         printf('N = %d, Δt = %.8f, IT(Δt) = %.8f, Er = %.8f, Log(Δt) = %.8f, Log(Er) = %.8f, Pendiente = %.8f\n', ...
           vector_N(i), vector_dt (i), IT_vector(i),Er_vector_IT(i), Log_dt_vector(i), Log_Er_vector(i), Pendiente_vector_IT(i));
    end


endfunction

