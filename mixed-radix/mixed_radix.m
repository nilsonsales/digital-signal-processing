function X = mixed_radix(x)
    
    N = length(x);
    
    % if the vector has only one element, its FFT is the number itself
    if N == 1
        X = x;
    
    % if divisible by 3, uses radix-3
    elseif mod(N, 3) == 0
        x_1 = x(1:3:end);
        x_2 = x(2:3:end);
        x_3 = x(3:3:end);

        X_1 = mixed_radix(x_1);
        X_2 = mixed_radix(x_2);
        X_3 = mixed_radix(x_3);

        X = zeros(1, N);
        n = (0:N-1);
        W0 = exp(-1j*(2*pi*n/N)); % W0 factor
        W1 = exp(-1j*(4*pi*n/N)); % W1 factor
        one_third = uint32(N/3);

        temp1 = X_1 + W0(1:one_third) .* X_2 + W1(1:one_third) .* X_3;
        temp2 = X_1 + W0(one_third+1:2*one_third) .* X_2 + W1(one_third+1:2*one_third) .* X_3;
        temp3 = X_1 + W0((2*one_third)+1:N) .* X_2 + W1((2*one_third)+1:N) .* X_3;

        % return
        X = [temp1 temp2 temp3];
    
    % otherwise, if divisible by 2, uses radix-2
    elseif  mod(N, 2) == 0
        x_even = x(1:2:end);
        x_odd = x(2:2:end);

        X_even = mixed_radix(x_even);
        X_odd = mixed_radix(x_odd);

        X = zeros(1, N);
        n = (0:N-1);
        Wn = exp(-1j*(2*pi*n/N)); % Wn factor
        half = uint32(N/2);

        % return
        X = [(X_even + Wn(1:half) .* X_odd) (X_even + Wn(half+1:end) .* X_odd)];
    end     

end