function kx = calck(u,v)
    global h; 
    
    % Determine the size of the velocity array
    [M, N] = size(u);
    M=M-1;
    N=N-2;
   
    
    %dx=Lx/h;
    %dy=Ly/h;
    % Initialize kx
    kx = 0;
    
    % Calculate kx using composite 2D midpoint integration rule
    for j=2:N+1
        for i = 2:M+1
            % Calculate velocity at cell center (staggered)      
            u_center=0.5 * (u(i,j) + u(i-1,j));
            v_center=0.5 * (v(i,j) + v(i,j-1));
            % Calculate kinetic energy for this time step using midpoint rule
            kx = kx+0.5 * (u_center.^2+v_center.^2) * h * h; 
        end
    end

end