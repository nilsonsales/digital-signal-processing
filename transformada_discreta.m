% Calcule a transformada discreta de Fourier do seguinte sinal
% x = [6 8 5 4 5 6] e compare com a função fft do MATLAB
% Utilize a técnica de zero-padding para 8 e 32 pontos.

clear; clc; close all;

fh = figure(1);
fh.WindowState = 'maximized';


% Sinal de entrada
x = [6 8 5 4 5 6];

% >>> Sem zero-padding
% Calcula a FFT usando a função nativa do MATLAB, com 128 pontos
fs = 2*pi/128;
F = 0:fs:(2*pi)-fs;
X_matlab = fft(x, 128);


figure(1), clf
subplot(231)
stem(x, 'filled', 'MarkerSize', 4)
title('Sinal original')
xlabel('Tempo')
ylabel('Amplitude')
axis([0 32 0 8]);
grid

subplot(234)
plot(F, X_matlab)
title('FFT')
xlabel('Freq. angular')
ylabel('Magnitude')
%axis([0 6.3 -5 35]);
grid


% >>> zero-padding com 8 pontos
x = [6 8 5 4 5 6];

x = [x zeros(1,2)]; % +2 pontos
N = length(x);
X = zeros(N,1);

% frequência angular
fs = 2*pi/N;
freq = 0:fs:(2*pi)-fs;


% Calulando a DFT
for k = 0:N-1
    for n = 0:N-1
        X(k+1) = X(k+1) + x(n+1)*exp(-1j*(2*pi/N)*n*k);
    end
end

figure(1)
subplot(232)
stem([x x x x], 'filled', 'MarkerSize', 4)
title('Zero-padding c/ 8 pontos')
xlabel('Tempo')
ylabel('Amplitude')
axis([0 32 0 8]);
grid

subplot(235)
stem(freq, X, 'filled', 'MarkerSize', 4)
hold on;
plot(F, X_matlab)
title('DFT')
xlabel('Freq. angular')
ylabel('Magnitude')
%axis([0 6.3 -5 40]);
grid



% >>> zero-padding com 32 pontos
x = [6 8 5 4 5 6];

x = [x zeros(1,26)]; % +26 pontos
N = length(x);
X = zeros(N,1);


% frequência angular
fs = 2*pi/N;
freq = 0:fs:(2*pi)-fs;


% Calulando a DFT
for k = 0:N-1
    for n = 0:N-1
        X(k+1) = X(k+1) + x(n+1)*exp(-1j*(2*pi/N)*n*k);
    end
end

figure(1)
subplot(233)
stem(x, 'filled', 'MarkerSize', 4)
title('Zero-padding c/ 32 pontos')
xlabel('Tempo')
ylabel('Amplitude')
axis([0 32 0 8]);
grid

subplot(236)
stem(freq, X, 'filled', 'MarkerSize', 4)
hold on;
plot(F, X_matlab)
title('DFT')
xlabel('Freq. angular')
ylabel('Magnitude')
%axis([0 6.3 -5 40]);
grid
