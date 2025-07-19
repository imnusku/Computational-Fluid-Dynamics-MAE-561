function phi= bcGS(phi)
    [M,N] = size(phi);
    M=M-2;
    N=N-2;
    
    %Neumann boundary conditions
    phi(1, 2:N+1) = phi(2, 2:N+1);      %left boundary
    phi(M+2, 2:N+1) = phi(M+1, 2:N+1);   %right boundary
    phi(2:M+1, 1) = phi(2:M+1, 2);       %bottom boundary
    phi(2:M+1, N+2)=phi(2:M+1, N+1);      %top boundary

end