function X = DFT(x)
    N = length(x);
    X = zeros(1, N);
    
    for k = 0:N-1
        for n = 0:N-1
            X(k+1) = X(k+1) + x(n+1)*exp(-1j*(2*pi/N)*n*k);
        end
    end

end