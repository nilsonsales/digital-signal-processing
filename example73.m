%O exemplo começa com um fitro discreto, que possui sua banda passante
%entre 0 e 0.2pi e sua banda de rejeição de 0.3pi a pi.


passante_omegaBaixo = 0;
passante_omegaAlto = 0.2*pi;

rejeicao_omegaBaixo = 0.3*pi;
rejeicao_omegaAlto = pi;

%Usando a transformação bilinear com tempo de amostragem 1
Td = 1;

passante_OmegaBaixo = (2/Td)*tan(passante_omegaBaixo/2);
passante_OmegaAlto = (2/Td)*tan(passante_omegaAlto/2);

rejeicao_OmegaBaixo = (2/Td)*tan(rejeicao_omegaBaixo/2);
rejeicao_OmegaAlto = (2/Td)*tan(rejeicao_omegaAlto/2); %inf

%Usando a forma da magnitude do filtro de butterworth, encontramos o valor
%de N (ordem do filtro) e a frequência de corte.

N = (log10( ((1/0.178)^2 -1)/((1/0.89)^2-1)))/(2*log10(tan(0.15*pi)/tan(0.1*pi)));
N = ceil(N);

omega_c = (2*tan(0.15*pi))/((1/0.175)^2-1 )^(1/(2*N));

%Usando os parâmetros encontrados, vamos construir o filtro de butterworth
%passa baixa continuo.
[num,den] = butter(N,omega_c,'s');
H = tf(num,den);

Hzss = bilin(ss(H),1,'S_Tust',[Td 1]);
Hz = tf(Hzss);

figure;
subplot(2,1,1);
[h,w] = freqz(Hz.num{1},Hz.den{1});
plot(w/pi,20*log10(abs(h)))
ax = gca;
ax.YLim = [-100 20];
ax.XTick = 0:.2:1;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
title('Frequency response (dB)');
grid on;

subplot(2,1,2)
[h,w] = freqz(Hz.num{1},Hz.den{1});
plot(w/pi,abs(h));
ax = gca;
ax.YLim = [0 1.2];
ax.XTick = 0:.2:1;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (abs)')
title('Frequency response (abs)');
grid on;

%%

%Agora vamos testar o filtro.


N = 300; %Quantidade de amostras do sinal de entrada
tam_intervalo = 2*pi;

fs = tam_intervalo/N;

t = 0:fs:tam_intervalo-fs;

f1 = 1; %1Hz
f2 = 5000; %5kHz

x = sin(f1*2*pi*t)+sin(f2*2*pi*t); 

figure;
subplot(2,1,1);
plot(t,x);
title("Sinal de entrada");

x_filtered = filter(Hz.num{1},Hz.den{1},x);

subplot(2,1,2);
plot(t,x_filtered);
title("Sinal final filtrado");
ax = gca;
ax.YLim = [-2 2];


