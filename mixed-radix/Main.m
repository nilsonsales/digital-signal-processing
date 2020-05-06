clear; clc; close all;

fh = figure(1);
fh.WindowState = 'maximized';


fs = 2*pi/486; % 486 pontos, sendo fatorável por 2 e 3
t = 0:fs:(2*pi)-fs;

% Sinal de entrada
x = sin(2*pi*t) + cos(3*2*pi*t) + 2*sin(pi*t);
%x = [4 1 6 3 2 7 8 5];
%x = [4 1 6 3 2 7 8 9 5];
%x = 1:432; %486; %162; %324;


figure(1), clf
subplot(2,3,1:3)
plot(x)
title('Original signal')
xlabel('Time')
ylabel('Amplitude')
grid


% Calcula a FFT usando a função nativa do MATLAB
tic
X_matlab = fft(x);
toc

subplot(2,3,4)
plot(abs(X_matlab))
title('Matlab FFT')
xlabel('Ang. frequency')
ylabel('Magnitude')
%axis([0 6.3 -5 35]);
grid


% >>> Usando a minha DFT
tic
X = DFT(x);
toc

subplot(2,3,5)
plot(abs(X))
title('My DFT')
xlabel('Ang. Frequency')
ylabel('Magnitude')
grid

% >>> Minha FFT usando mixed-radix

%X2 = radix3(x).';
%X2 = radix2(x).';

tic
X2 = mixed_radix(x).';
toc


subplot(2,3,6)
plot(abs(X2))
title('My FFT using mixed-radix')
xlabel('Ang. Frequency')
ylabel('Magnitude')
grid

%y = (ifft(X2));

%figure(2)
%plot(t, y)
%title('inverse FFT')
%grid
