function analisisRegistro()
    % Cargar el registro
    g = load('Registro_240901.txt');

    % Parámetros básicos
    fs = 16000;  % Frecuencia de muestreo
    N = length(g);  % Número de muestras
    t = (0:N-1)'/fs;  % Vector de tiempo

    % 1. Graficar el registro original
    figure(1);
    plot(t, g, 'b');
    grid on;
    title('Registro Original');
    xlabel('Tiempo (s)');
    ylabel('Amplitud');

    % 2. Análisis de Fourier usando FFT
    G = fft(g);
    f = fs*(0:(N/2))/N;  % Vector de frecuencias
    P2 = abs(G/N);
    P1 = P2(1:N/2+1);    % Espectro de un solo lado
    P1(2:end-1) = 2*P1(2:end-1);

    % Calcular amplitudes desde la FFT
    amplitudes = 2 * abs(G(1:N/2+1)) / N;
    amplitudes(1) = amplitudes(1) / 2;  % Corregir componente DC

    % Graficar espectro de frecuencias y amplitudes
    figure(2);
    subplot(2,1,1);
    plot(f, P1);
    grid on;
    title('Espectro de Potencia');
    xlabel('Frecuencia (Hz)');
    ylabel('|P1(f)|');

    subplot(2,1,2);
    stem(f, amplitudes);
    grid on;
    title('Amplitudes de Frecuencias');
    xlabel('Frecuencia (Hz)');
    ylabel('Amplitud');

    % 3. Reconstrucción usando IFFT
    g_reconstruido = real(ifft(G));

    % Graficar señal original vs reconstruida
    figure(3);
    plot(t, g, 'b', t, g_reconstruido, 'r--');
    grid on;
    title('Señal Original vs Reconstruida');
    xlabel('Tiempo (s)');
    ylabel('Amplitud');
    legend('Original', 'Reconstruida');

    % 4. Análisis adicional: encontrar frecuencias dominantes
    [picos, locs] = findpeaks(amplitudes, 'MinPeakHeight', max(amplitudes)*0.1);
    frecuencias_dominantes = f(locs);

    disp('Frecuencias dominantes (Hz) y sus amplitudes:');
    for i = 1:length(frecuencias_dominantes)
        fprintf('Frecuencia: %.2f Hz, Amplitud: %.4f\n', frecuencias_dominantes(i), picos(i));
    end

    % Análisis espectral más detallado
    [~, idx] = sort(picos, 'descend');
    freq_principales = frecuencias_dominantes(idx);
    amp_principales = picos(idx);

    disp('Componentes principales (ordenadas por amplitud):');
    for i = 1:min(5, length(freq_principales))
        fprintf('Frecuencia: %.2f Hz, Amplitud: %.4f\n', ...
                freq_principales(i), amp_principales(i));
    end

    % 5. Error de reconstrucción
    error = norm(g - g_reconstruido) / norm(g);
    disp(['Error relativo de reconstrucción: ', num2str(error)]);

    % 6. Análisis en tiempo-frecuencia usando STFT
    window = 256;  % Tamaño de la ventana
    overlap = 128; % Solapamiento
    nfft = 512;    % Número de puntos FFT

    figure(4);
    spectrogram(g, window, overlap, nfft, fs, 'yaxis');
    title('Espectrograma');
    colorbar;

end
