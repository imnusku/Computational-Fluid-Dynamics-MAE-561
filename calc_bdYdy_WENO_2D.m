function f = calc_bdYdy_WENO_2D(Y, b)
    global h dp dmdp;

    [M, N] = size(Y); 
    M = M - 6;
    N = N - 6;
    f = zeros(M + 6, N + 6); 

    % Define local functions for dp and dmdp
    function dp = dpf(Y, i, j)
        dp = Y(i, j+1) - Y(i, j);
    end

    function dmdp = dmdpf(Y, i, j)
        dmdp = Y(i, j+1) - 2 * Y(i, j) + Y(i, j-1);
    end

    % Implement WENO-5 method
    for j = 4:N+3
        for i = 4:M+3
                if b(i, j) >= 0
                    f(i, j) = (1/(12 * h)) * (-dpf(Y, i, j-2) + 7 * dpf(Y, i, j-1) + 7 * dpf(Y, i, j) - dpf(Y, i, j+1)) - psiWENO(dmdpf(Y, i, j-2)/h, dmdpf(Y, i, j-1)/h, dmdpf(Y, i, j)/h, dmdpf(Y, i, j+1)/h);
                else
                    f(i, j) = (1/(12 * h)) * (-dpf(Y, i, j-2) + 7 * dpf(Y, i, j-1) + 7 * dpf(Y, i, j) - dpf(Y, i, j+1)) + psiWENO(dmdpf(Y, i, j+2)/h, dmdpf(Y, i, j+1)/h, dmdpf(Y, i, j)/h, dmdpf(Y, i, j-1)/h);
                end
                f(i, j) = b(i, j) * f(i, j);
            end
    end
end
