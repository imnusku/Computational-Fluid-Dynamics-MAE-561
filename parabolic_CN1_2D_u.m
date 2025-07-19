function [u] = parabolic_CN1_2D_u(u, Qu, dt)
    global Re;
    global t;
    global h;
    
    global a b c d;
    

    [M,N]=size(u);
    M=M-1;
    N=N-2;

    % Initialize coefficient vectors
    a = zeros(M+1, N+2);
    b = zeros(M+1, N+2);
    c = zeros(M+1, N+2);
    d = zeros(M+1, N+2);

    % Calculate coefficients for tridiagonal matrix
    a(2:M, 2:N+1) = - dt / (2 * (h^2)*Re);
    b(2:M, 2:N+1) = 1 + (dt / ((h^2)*Re));
    c(2:M, 2:N+1) = - dt / (2 * (h^2)*Re);
    % Calculate d coefficients using the parabolic CN method
    for j =2:N+1
        for i = 2:M
            d(i, j) = (dt / (2 * (h^2)*Re)) * u(i, j+1) + (1 - ( dt /(Re * (h^2)))) * u(i, j) + (dt / (2 * (h^2)*Re)) * u(i, j-1) + (dt/2) * Qu(i, j);
        end
    end

    [a, b, c, d] = bcCN1_u(a, b, c, d, t + dt/2);

    % Solve the tridiagonal system of equations
    for j=2:N+1
        u(2:M,j) = mySolveTriDiag(a(2:M,j), b(2:M,j), c(2:M,j), d(2:M,j));
    end
    u = bc_u(u, t + dt/2);
end

