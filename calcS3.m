function S= calcS3(Y)
    global h Lx Ly; 
    
    % Determine the size of the velocity array
    [M, N] = size(Y);
    M=M-6;
    N=N-6;
   
    
    %dx=Lx/h;
    %dy=Ly/h;
    % Initialize S
    S = 0;
    
    % Calculate S using composite 2D midpoint integration rule
    for j=4:N+3
        for i = 4:M+3
            %it is all already cell centered values
            % Calculate kinetic energy for this time step using midpoint rule
            S = S+(Y(i,j)*(1-Y(i,j)) * h * h); 
        end
    end
    S=S/(Lx*Ly);

end