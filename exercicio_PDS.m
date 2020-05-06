clear all
close all
clc

M = 60;
n_samples = 300;
n = 1:n_samples;
w = zeros(1, n_samples); % signal

for N = 1:M
    w(N) = 0.54 - (0.46 .* cos(2*pi*N/M));
end

x1 = w .* cos(0.2*pi*n);
x2 = w .* cos(0.4*pi*n - pi/2);
x3 = w .* cos(0.8*pi*n + pi/5);

x = zeros(1, n_samples);

for N = 1:n_samples  % new_signal
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

figure(1), clf
subplot(1,2,1)
plot(x)
grid

subplot(1,2,2)
plot(abs(Y))
xticks([30, 90, 150, 210, 270])
xticklabels({'-0.8\pi','-0.4\pi','0','0.4\pi','0.8\pi'})
grid

z = tf('z', -1);

H1 = ((1 - 0.98*exp(1j*0.8*pi)*z^(-1))*(1 - 0.98*exp(-1j*0.8*pi)*z^(-1))) / ((1 - 0.8*exp(1j*0.4*pi)*z^(-1))*(1 - 0.8*exp(-1j*0.4*pi)*z^(-1)));

H2 = 1;
for k = 1:4
    ck = 0.95*exp(1j*(0.15*pi+.02*pi*k));
    
    H2 = H2 * ( ((conj(ck) - z^(-1))*(ck - z^(-1))) / ((1 - ck*z^(-1))*(1 - conj(ck)*z^(-1))) )^2;
end

H = H1 * H2;

figure(2)
pzmap(H)
%grid on
%pzplot(H)

%using the filter
[num,den] = tfdata(H,'v')
%figure(3)
%plot(filter(num, den, x))

opts = bodeoptions('cstprefs');
opts.FreqScale = 'linear';
opts.FreqUnits = 'rad/s';
opts.MagUnits = 'abs';
opts.MagScale = 'linear';
opts.PhaseUnits = 'rad';
opts.Grid = 'on';

bodeplot(H, opts)
