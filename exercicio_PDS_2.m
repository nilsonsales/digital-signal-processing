clear all
close all
clc


%%% Resolução dos exemplos 5.15-18 %%%

% Usaremos o mesmo s sinal do exercício anterior

M = 60;
n_samples = 300;
n = 1:n_samples;
w = zeros(1, n_samples); % signal

for N = 1:M
    w(N) = 0.54 - (0.46 .* cos(2*pi*N/M));
end

x1 = w .* cos(0.4*pi*n);
x2 = w .* cos(0.6*pi*n - pi/2);
x3 = w .* cos(0.8*pi*n + pi/5);

x = zeros(1, n_samples);

for N = 1:n_samples 
    if (N-M-1 > 0) && (N-2*M-2 > 0)
        x(N) = x3(N) + x1(N - M - 1) + x2(N - 2*M - 2);
    elseif (N-M-1 > 0)
        x(N) = x3(N) + x1(N - M - 1);
    elseif (N-2*M-2 > 0)
        x(N) = x3(N) + x2(N - 2*M - 2);
    else
        x(N) = x3(N);
    end
end


X = fft(x);
Y = fftshift(X);

figure(1)
subplot(2, 1, 1);
plot(x)
grid
title("Sinal original e sua FFT")

figure(1)
subplot(2,1,2);
plot(abs(Y))
xticks([30, 90, 150, 210, 270])
xticklabels({'-0.8\pi','-0.4\pi','0','0.4\pi','0.8\pi'})
grid


%%% Examplo 5.15 Sistema de Fase Linear - Tipo I 

% Criando o filtro digital

w = 0:0.01:2*pi;

d = (1 - exp(-1j.*w.*5))./(1 - exp(-1j.*w));

figure(2)
subplot(3, 1, 1);
plot(abs(d));
xticks([0, 157.5, 315, 472.5, 629]) % intervalo: 0 - 630
xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
grid;
title("Ex 5.15: Ganho, fase e atraso de grupo da resposta ao impulso")

subplot(3, 1, 2)
plot(phase(d));
xticks([0, 157.5, 315, 472.5, 629]) % 0 - 630
xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
grid;

% Tranformando para o plano Z: Z^5 - Z^0 / Z^5 - Z^4
num = [1, 0, 0, 0, 0, 1];
den = [1, 1, 0, 0, 0, 0];

subplot(3, 1, 3)
plot(grpdelay(num, den, 629)); % Imprimindo o atraso de grupo
xticks([0, 157.5, 315, 472.5, 629]) % 0 - 630
xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
grid;

H = tf(num, den);

figure(3)
subplot(1, 1, 1);
plot(filter(num, den, x))
grid
title("Ex 5.15: Saída do sinal")


%%% Examplo 5.16 Sistema de Fase Linear - Tipo II

% Criando o filtro digital

d2 = exp(-1j.*w.*5/2) .* (sin(3.*w)./sin(w./2));

figure(4)
subplot(3, 1, 1);
plot(abs(d2));
xticks([0, 157.5, 315, 472.5, 629]) % intervalo: 0 - 630
xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
grid;
title("Ex 5.16: Ganho, fase e atraso de grupo da resposta ao impulso")

subplot(3, 1, 2)
plot(phase(d2));
xticks([0, 157.5, 315, 472.5, 629]) % 0 - 630
xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
grid;

% Tranformando para o plano Z: Z^5 - Z^0 / Z^5
num = [1, 0, 0, 0, 0, 1];
den = [1, 0, 0, 0, 0, 0];

subplot(3, 1, 3)
plot(grpdelay(num, den, 629)); % Imprimindo o atraso de grupo
xticks([0, 157.5, 315, 472.5, 629]) % 0 - 630
xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
grid;

H = tf(num, 1);

figure(5)
subplot(1, 1, 1);
plot(filter(num, den, x))
grid
title("Ex 5.16: Saída do sinal")


%%% Examplo 5.17 Sistema de Fase Linear - Tipo III

% Criando o filtro digital

d3 = (1 - exp(-1j.*w.*2));

figure(6)
subplot(3, 1, 1);
plot(abs(d3));
xticks([0, 157.5, 315, 472.5, 629]) % intervalo: 0 - 630
xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
grid;
title("Ex 5.17: Ganho, fase e atraso de grupo da resposta ao impulso")

subplot(3, 1, 2)
plot(phase(d3));
xticks([0, 157.5, 315, 472.5, 629]) % 0 - 630
xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
grid;

% Tranformando para o plano Z: Z^2 - Z^0
num = [1, 0, 1];

subplot(3, 1, 3)
plot(grpdelay(num, den, 629)); % Imprimindo o atraso de grupo
xticks([0, 157.5, 315, 472.5, 629]) % 0 - 630
xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
grid;

H = tf(num, 1);

figure(7)
subplot(1, 1, 1);
plot(filter(num, den, x))
grid
title("Ex 5.17: Saída do sinal")


%%% Examplo 5.18 Sistema de Fase Linear - Tipo IV

% Criando o filtro digital

d4 = (1 - exp(-1j.*w));

figure(8)
subplot(3, 1, 1);
plot(abs(d4));
xticks([0, 157.5, 315, 472.5, 629]) % intervalo: 0 - 630
xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
grid;
title("Ex 5.18: Ganho, fase e atraso de grupo da resposta ao impulso")

subplot(3, 1, 2)
plot(phase(d4));
xticks([0, 157.5, 315, 472.5, 629]) % 0 - 630
xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
grid;

% Tranformando para o plano Z: Z - Z^0
num = [1, 1];

subplot(3, 1, 3)
plot(grpdelay(num, den, 629)); % Imprimindo o atraso de grupo
xticks([0, 157.5, 315, 472.5, 629]) % 0 - 630
xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
grid;

H = tf(num, 1);

% sinal filtrado
figure(9)
subplot(1, 1, 1);
plot(filter(num, den, x))
grid
title("Ex 5.18: Saída do sinal")

