function [v] = parabolic_CN2_2D_v(v, Qv, dt)
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
    for i =2:M+1
        for j = 2:N
            d(i, j) = (dt / (2 * (h^2)*Re)) * v(i+1, j) + (1 - ( dt /(Re * (h^2)))) * v(i, j) + (dt / (2 * (h^2)*Re)) * v(i-1, j) + (dt/2) * Qv(i, j);
        end
    end
    [a, b, c, d] = bcCN2_v(a, b, c, d, t+dt);

    % Solve the tridiagonal system of equations
    for i=2:M+1
        v(i,2:N) = mySolveTriDiag(a(i,2:N), b(i,2:N), c(i,2:N), d(i,2:N));
    end
    v = bc_v(v, t+dt);
end