clc;
close all;
clear;


% Frequencia de amostragem e de corte: 2*fc/fs = 0.6 * pi rad/sample
fc = 300; % Hz
fs = 1000; % Hz


%--------------------- Filtro Butterworth -----------------------
% 2ª ordem
n = 2;
[num2, den2] = butter(n, fc*2/fs);
%H2 = tf(num2, den2);

figure(1)
freqz(num2, den2);
title("Frequency respose - Butterworth filter");
hold on;
grid on;

% 4ª ordem
n = 4;
[num4, den4] = butter(n, fc*2/fs);
%H4 = tf(num4, den4);
%bode(H4);
freqz(num4, den4);

% 8ª ordem
n = 8;
[num8, den8] = butter(n, fc*2/fs);
%H8 = tf(num8, den8);
%bode(H8);
freqz(num8, den8);


% Adding colours to freqz
lines = findall(gcf,'type','line');

lines(1).Color = 'red';
lines(2).Color = 'green';
lines(3).Color = 'blue';


%-------------------- Chebyshev tipo 1 --------------------------

% 2ª ordem com 0.1 dB de ripple na banda de passagem
[num_c2, den_c2] = cheby1(2, 0.1, fc/(fs/2));
%H_C2 = tf(num_c2, den_c2);

%bode(H_C2);
figure(2)
freqz(num_c2, den_c2);
title("Frequency respose - Chebyshev type 1 filter")
hold on;
grid on;


% 4ª ordem
[num_c4, den_c4] = cheby1(4, 0.1, fc/(fs/2));
freqz(num_c4, den_c4);

% 8ª ordem
[num_c8, den_c8] = cheby1(8, 0.1, fc/(fs/2));
freqz(num_c8, den_c8);

% Adding colours to freqz
lines = findall(gcf,'type','line');

lines(1).Color = 'red';
lines(2).Color = 'green';
lines(3).Color = 'blue';


%--------------------- Criando o Sinal -------------------------
% frequências das componentes do sinal (Hz)
f1 = 3;
f2 = 400;

t = 0:1/fs:1;
x = sin(f1*2*pi*t) + 0.3*sin(f2*2*pi*t);

figure(3);
subplot(4,1,1)
plot(t,x);
ylim([-1.5 1.5])
title("Original signal")
grid

figure(4)
plot(abs(fft(x)));
title("FFT")
grid

% Gerando sinais filtrados com Butterworth
x2 = filter(num2, den2, x);
x4 = filter(num4, den4, x);
x8 = filter(num8, den8, x);

figure(3)
subplot(4,1,2)
plot(t, x2);
ylim([-1.5 1.5])
title("2nd order Butterworth")
grid on;

subplot(4,1,3)
plot(t, x4);
ylim([-1.5 1.5])
title("4th order Butterworth")
grid

subplot(4,1,4)
plot(t, x8);
ylim([-1.5 1.5])
title("8th order Butterworth")
grid


% Gerando sinais filtrados com Chebyshev
x_c2 = filter(num_c2, den_c2, x);
x_c4 = filter(num_c4, den_c4, x);
x_c8 = filter(num_c4, den_c4, x);

figure(5)
subplot(4,1,1)
plot(t,x);
ylim([-1.5 1.5])
title("Original signal")
grid

subplot(4,1,2)
plot(t, x_c2);
ylim([-1.5 1.5])
title("2nd order Chebyshev t.1")
grid

subplot(4,1,3)
plot(t, x_c4);
ylim([-1.5 1.5])
title("4th order Chebyshev t.1")
grid

subplot(4,1,4)
plot(t, x_c8);
ylim([-1.5 1.5])
title("8th order Chebyshev t.1")
grid