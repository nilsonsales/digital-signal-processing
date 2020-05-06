function X = radix2(x)

N = length(x);

if N >= 2
    x_even = x(1:2:end);
    x_odd = x(2:2:end);
    
    %{
    disp(["x_e = ", num2str(x_even)]);
    disp(["x_o = ", num2str(x_odd)]);
    %}
    
    X_even = radix2(x_even);
    X_odd = radix2(x_odd);
    
    X = zeros(1, N);
    n = (0:N-1); % row vector for n
    Wn = exp(-1j*(2*pi*n/N)); % Wn factor
    half = uint8(N/2);
    
    %{
    disp("------------------")
    disp(Wn)
    disp("----")
    disp(Wn((uint8(N/2)+1:end)))
    disp("*")
    disp(x_odd)
    disp("Transformada")
    disp(X_odd)
    disp("=")
    disp(Wn((uint8(N/2))+1:end) .* X_odd)
    %}
    
    % return
    X = [(X_even + Wn(1:half) .* X_odd) (X_even + Wn(half+1:end) .* X_odd)];
    
    
elseif N <= 1
    X = x; %DFT(x);
end