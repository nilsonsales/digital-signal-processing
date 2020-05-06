function X = radix3(x)

N = length(x);

if N >= 3
    
    x_1 = x(1:3:end);
    x_2 = x(2:3:end);
    x_3 = x(3:3:end);

    X_1 = radix3(x_1);
    X_2 = radix3(x_2);
    X_3 = radix3(x_3);
    
    X = zeros(1, N);
    n = (0:N-1); % row vector for n
    W0 = exp(-1j*(2*pi*n/N)); % W0 factor
    W1 = exp(-1j*(4*pi*n/N)); % W1 factor
    one_third = uint8(N/3);
    
    temp1 = X_1 + W0(1:one_third) .* X_2 + W1(1:one_third) .* X_3;
    temp2 = X_1 + W0(one_third+1:(2*one_third)) .* X_2 + W1(one_third+1:(2*one_third)) .* X_3;
    temp3 = X_1 + W0((2*one_third)+1:N) .* X_2 + W1((2*one_third)+1:N) .* X_3;
    
    % return
    X = [temp1 temp2 temp3];
    
elseif N == 1
    X = x; %DFT(x);
end