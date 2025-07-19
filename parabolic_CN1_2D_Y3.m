function [Y] = parabolic_CN1_2D_Y3(Y, QY, dt)
    global Re;
    global Sc;
    global t;
    global h;
    
    global a b c d;
    

    [M,N]=size(Y);
    M=M-6;
    N=N-6;

    % Initialize coefficient vectors
    a = zeros(M+6, N+6);
    b = zeros(M+6, N+6);
    c = zeros(M+6, N+6);
    d = zeros(M+6, N+6);

    % Calculate coefficients for tridiagonal matrix
    a(4:M+3, 4:N+3) = - dt / (2 * (h^2)*Re*Sc);
    b(4:M+3, 4:N+3) = 1 + (dt / ((h^2)*Re*Sc));
    c(4:M+3, 4:N+3) = - dt / (2 * (h^2)*Re*Sc);
    % Calculate d coefficients using the parabolic CN method
    for j =4:N+3
        for i = 4:M+3
            d(i, j) = (dt / (2 * (h^2)*Re*Sc)) * Y(i, j+1) + (1 - ( dt /(Re *Sc* (h^2)))) * Y(i, j) + (dt / (2 * (h^2)*Re*Sc)) * Y(i, j-1) + (dt/2) * QY(i, j);
        end
    end

    [a, b, c, d] = bcCN1_Y3(a, b, c, d, t + dt/2);

    % Solve the tridiagonal system of equations
    for j=4:N+3
        Y(4:M+3,j) = mySolveTriDiag(a(4:M+3,j), b(4:M+3,j), c(4:M+3,j), d(4:M+3,j));
    end
    Y = bc_Y3(Y, t + dt/2);
end

