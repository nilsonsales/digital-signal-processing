figure(1)
x = inline('1.0*(t>=0 & t<3).*(t/3)');
g = inline('1.0*(t>=0 & t<1).*(t) + 1.0*(t>=1 & t<2)');
dtau = 0.0005; tau = -3.25:dtau:6;
ti = 0; tvec = -2:0.1:5.75;
y = NaN*zeros(1,length(tvec)); % Alocação prévia de memória

for t = tvec,
    ti = ti+1 % índice de tempo
    xh = x(t-tau).*g(tau); lxh = length(xh);
    y(ti) = sum(xh.*dtau); % aproximação trapezoidal da integral
    subplot(2,1,1), plot(tau,g(tau),'k-',tau,x(t-tau),'k--',t,0,'ok');
    axis([tau(1) tau(end) -0.5 1.5]);
    patch([tau(1:end-1);tau(1:end-1);tau(2:end);tau(2:end)],...
        [zeros(1,lxh-1);xh(1:end-1);xh(2:end);zeros(1,lxh-1)],...
        [.8 .8 .8],'edgecolor','none');
    xlabel( '\tau');
%     legend('h(\tau)','x(t-\tau)','t','h(\tau)x(t-\tau)',3);
    c = get(gca,'children'); set(gca,'children',[c(2);c(3);c(4);c(1)]);
    subplot(2,1,2),plot(tvec,y,'k',tvec(ti),y(ti),'ok')
    axis([tau(1) tau(end) -0.5 1.5]); grid;
    drawnow;
%     pause
end