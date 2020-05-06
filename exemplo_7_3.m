clc;
close all;
clear;

fh = figure(1);
fh.WindowState = 'maximized';


%%% Construindo o filtro

% Definindo os limites
pass_omega_low = 0;
pass_omega_high = 0.2*pi;

rej_omega_low = 0.3*pi;
rej_omega_high = pi;


%%% Aplicando a Tranformação Bilinear
% Tempo de amostragem = 1
Td = 1;

% Encontrando a ordem do filtro (N) e a frequencia de corte.
N = (log10( ((1/0.178)^2 -1)/((1/0.89)^2-1)))/(2*log10(tan(0.15*pi)/tan(0.1*pi)));
N = ceil(N);
omega_c = (2*tan(0.15*pi))/((1/0.175)^2-1 )^(1/(2*N)); % freq. de corte

% Construindo o filtro passa-baixa de Butterworth (contínuo)
[num, den] = butter(N, omega_c, 's');
H = tf(num,den);

Hzss = bilin(ss(H),1,'S_Tust',[Td 1]);
Hz = tf(Hzss); % crinado a função de tranferência

[h, w] = freqz(Hz.num{1}, Hz.den{1});

figure(1);
subplot(2,2,2);
plot(w/pi, 20*log10(abs(h)))
ylim([-100 20]);
xlim([0 1]);
xlabel('Frequencia normalizada (\times\pi rad/amostra)')
ylabel('dB')
title('Resposta em frequencia (dB)');
grid on;
hold off;

subplot(2,2,4)
[h,w] = freqz(Hz.num{1},Hz.den{1});
plot(w/pi, abs(h));
ylim([0 1.2]);
xlabel('Frequencia normalizada (\times\pi rad/amostra)')
ylabel('Amplitude')
title('Resposta em frequencia (abs)');
grid on;


%%% Sinal de entrada
fs = 1000; % Hz
f1 = 3; % Hz
f2 = 400; % Hz

t = 0:1/fs:1;
x = sin(f1*2*pi*t) + 0.3*sin(f2*2*pi*t);

x2 = filter(Hz.num{1},Hz.den{1},x); % sinal filtrado


% Plotando os sinais
subplot(2,2,1);
plot(t,x);
title("Sinal de entrada");
ax = gca;
ax.YLim = [-1.5 1.5];
grid on;

subplot(2,2,3);
plot(t,x2);
title("Sinal filtrado");
ax = gca;
ax.YLim = [-1.5 1.5];
grid on;
