%let j/N be as it is

function f = calc_adYdx_WENO_2D(Y, a)
    global h;

    [M, N] = size(Y); 
    M = M - 6;
    N = N - 6;
    f = zeros(M + 6, N + 6); 

    % Define local functions for dp and dmdp
    function dp = dpf(Y, i, j)
        dp = Y(i+1, j) - Y(i, j);
    end

    function dmdp = dmdpf(Y, i, j)
        dmdp = Y(i+1, j) - 2 * Y(i, j) + Y(i-1, j);
    end

    % Implement WENO-5 method
    for j = 4:N+3
        for i = 4:M+3
                if a(i, j) >= 0
                    f(i, j) = (1/(12 * h)) * (-dpf(Y, i-2, j) + 7 * dpf(Y, i-1, j) + 7 * dpf(Y, i, j) - dpf(Y, i+1, j)) - psiWENO(dmdpf(Y, i-2, j)/h, dmdpf(Y, i-1, j)/h, dmdpf(Y, i, j)/h, dmdpf(Y, i+1, j)/h);
                else
                    f(i, j) = (1/(12 * h)) * (-dpf(Y, i-2, j) + 7 * dpf(Y, i-1, j) + 7 * dpf(Y, i, j) - dpf(Y, i+1, j)) + psiWENO(dmdpf(Y, i+2, j)/h, dmdpf(Y, i+1, j)/h, dmdpf(Y, i, j)/h, dmdpf(Y, i-1, j)/h);
                end
                f(i, j) = a(i, j) * f(i, j);
            end
        end
    end

