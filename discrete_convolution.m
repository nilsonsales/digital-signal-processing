%%%           Exemplo 3.15
%   Destertermine c[n] = x[n] * g[n]
%   Onde x[n] = (0.8)^n e g[n] = (0.3)^n

close all
clc

figure(1)

tau = -6:7;

g = inline('((0.8).^t).*(t>=0&t<5)'); % Ordem inversa para que g[n] fique estático
x = inline('((0.3).^t).*(t>=0&t<5)');

ti = 0; tvec = -8:10;
y = NaN*zeros(1,length(tvec)); % Alocação prévia de memória

for t = tvec
    
    ti = ti+1; % índice de tempo
    xh = x(t-tau).*g(tau); lxh = length(xh);
    y(ti) = sum(xh.*1); % aproximação trapezoidal da integral
    subplot(2,1,1), stem(tau,g(tau));
    hold on;
    stem(tau,x(t-tau));
    hold on;
    stem(t, 0);
    hold off;
    
    axis([tau(1) tau(end) -0.3 1.3]);
    patch([tau(1:end-1);tau(1:end-1);tau(2:end);tau(2:end)],...
        [zeros(1,lxh-1);xh(1:end-1);xh(2:end);zeros(1,lxh-1)],...
        [.8 .8 .8],'edgecolor','none');
    xlabel('\tau');
%     legend('h(\tau)','x(t-\tau)','t','h(\tau)x(t-\tau)',3);
    c = get(gca,'children'); set(gca,'children',[c(2);c(3);c(4);c(1)]);
    
    subplot(2,1,2), stem(tvec,y);
    hold on;
    stem(tvec(ti),y(ti));
    hold off;
    axis([tau(1) tau(end) -0.3 1.3]); grid;
    
    drawnow;
    
    pause(0.4) % Temporizador
end