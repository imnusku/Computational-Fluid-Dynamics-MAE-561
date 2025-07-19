function [u,v] = projectV(u,v, phi, dt)
    global h t;

    % Calculate grid dimensions
    [M1, N1] = size(u);
    M1 = M1 - 1; 
    N1 = N1 - 2; 
    
    [M2, N2] = size(v);
    M2 = M2 - 2; 
    N2 = N2 - 1; 
    
   

    % Project u onto the subspace of divergence-free fields
    % Find grad phi at the nodes i.e. 1 to M+1, it is currently cell centered values
    gradphi1=zeros(M1+1,N1+2);
    gradphi2=zeros(M2+2,N2+1);
    
    
    % grad of phi1 
    for j =2:N1+1
        for i = 2:M1
            gradphi1(i, j) = (phi(i+1, j) - phi(i, j)) / (h);
        end
    end
    
     % grad of phi2
    for i =2:M2+1
        for j = 2:N2
            gradphi2(i, j) = (phi(i, j+1) - phi(i, j)) / (h);
        end
    end
    
 
    u = u - dt * gradphi1;
    v = v - dt * gradphi2;
    

    for i = 2:M1
        u=bcGhost_u(u,t);
    end
    
    for i = 2:N2
        v=bcGhost_v(v,t);
    end
    
    
    
    
    
end