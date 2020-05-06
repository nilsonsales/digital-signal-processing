clc;
close all;
clear;

fh = figure(1);
fh.WindowState = 'maximized';

fs = 1000; % Hz


%%% Exemplo 7.6: Transformação de um Filtro Passa-Baixa para um Filtro Passa-Alta %%%

z = tf('z', -1);

% Criando o filtro passa-baixa
Hlp = (0.001836 * ((1 + z )^(4) )) / ((1 - 1.5548 * z + 0.6493*(z^(2)) )*(1 - 1.4996*z + 0.8482*(z^(2)) ));

%%% Plotando os diagramas de resposta
[h, w] = freqz(Hlp.num{1}, Hlp.den{1}, fs);

figure(1);
subplot(2,2,1);
plot(w/pi, 20*log10(abs(h)))
ylim([-100 20]);
xlim([0 1]);
xlabel('Freq. normalizada (\times\pi rad/amostra)')
ylabel('dB')
title('Resposta em frequência (dB) - FPB');
grid on;
hold off;

subplot(2,2,2)
plot(w/pi, abs(h));
ylim([0 1.2]);
xlabel('Freq. normalizada (\times\pi rad/amostra)')
ylabel('Amplitude')
title('Resposta em frequência (abs) - FPB');
grid on;



%%% Transformando para passa-alta

% Especificações
pass_teta_low = 0;
pass_teta_high = 0.2*pi;

rej_teta_low = 0.3*pi;
rej_teta_high = pi;

% frequência de corte
omega_c = 0.6*pi;

alpha = -cos((pass_teta_high + omega_c*pi)/2) / cos((pass_teta_high - omega_c*pi)/2);


Z = -(z - 0.38197) / (1 - 0.38197*z);

H = (0.001836 * ((1 + Z )^(4)) ) / ((1 - 1.5548 * Z + 0.6493*(Z^(2)) )*(1 - 1.4996*Z + 0.8482*(Z^(2)) ));


%%% Plotando o diagramas de resposta
[h1, w1] = freqz(H.num{1}, H.den{1}, fs);

figure(1);
subplot(2,2,3);
plot(w1/pi, 20*log10(abs(h1)))
ylim([-100 20]);
xlim([0 1]);
xlabel('Freq. normalizada (\times\pi rad/amostra)')
ylabel('dB')
title('Resposta em frequência (dB) - FPA');
grid on;
hold off;

subplot(2,2,4)
plot(w1/pi, abs(h1));
ylim([0 1.2]);
xlabel('Freq. normalizada (\times\pi rad/amostra)')
ylabel('Amplitude')
title('Resposta em frequência (abs) - FPA');
grid on;


%%% reação dos sistemas a uma entrada com ruído
%%% Sinal de entrada
fs = 1000; % Hz
f1 = 3; % Hz
f2 = 480; % Hz

t = 0:1/fs:1;
x = sin(f1*2*pi*t) + 0.3*sin(f2*2*pi*t) + sin(100*pi*t);

x2 = filter(Hlp.num{1}, Hlp.den{1}, x); % sinal filtrado


% Plotando os sinais
figure(2)
subplot(3,1,1);
plot(t,x);
title("Sinal de entrada");
ax = gca;
ax.YLim = [-1.5 1.5];
grid on;

subplot(3,1,2);
plot(t, x2);
title("Sinal filtrado - FPB");
ax = gca;
%ax.YLim = [-2 2];
grid on;

x3 = filter(H.num{1}, H.den{1}, x); % sinal filtrado

subplot(3,1,3);
plot(t, x3);
title("Sinal filtrado - FPA");
ax = gca;
%ax.YLim = [-2 2];
grid on;