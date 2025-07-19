function [v] = parabolic_CN1_2D_v(v, Qv, dt)
    global Re;
    global t;
    global h;
    
    global a b c d;
    

    [M,N]=size(v);
    M=M-2;
    N=N-1;

    % Initialize coefficient vectors
    a = zeros(M+2, N+1);
    b = zeros(M+2, N+1);
    c = zeros(M+2, N+1);
    d = zeros(M+2, N+1);

    % Calculate coefficients for tridiagonal matrix
    a(2:M+1, 2:N) = - dt / (2 * (h^2)*Re);
    b(2:M+1, 2:N) = 1 + (dt / ((h^2)*Re));
    c(2:M+1, 2:N) = - dt / (2 * (h^2)*Re);
    % Calculate d coefficients using the parabolic CN method
    for j =2:N
        for i = 2:M+1
            d(i, j) = (dt / (2 * (h^2)*Re)) * v(i, j+1) + (1 - ( dt /(Re * (h^2)))) * v(i, j) + (dt / (2 * (h^2)*Re)) * v(i, j-1) + (dt/2) * Qv(i, j);
        end
    end

    [a, b, c, d] = bcCN1_v(a, b, c, d, t + dt/2);

    % Solve the tridiagonal system of equations
    for j=2:N
        v(2:M+1,j) = mySolveTriDiag(a(2:M+1,j), b(2:M+1,j), c(2:M+1,j), d(2:M+1,j));
    end
    v = bc_v(v, t + dt/2);
end

