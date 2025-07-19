%ONLY CHECKING FOR a0 YESSSSSSS!!!!!


function [HY] =hyperbolic_Y_WENO_2D(Y,u,v,u1,v1,dt)
    global t a0 a1 a2 b0 b1 b2 Y1 Y2 Ys;
    
    [M,N]=size(Y);
    M=M-6;
    N=N-6;
   % Determine the size of the velocity array
    [M1, N1] = size(u);
    M1=M1-1;
    N1=N1-2;
    
    for j=2:N1+1
        for i = 2:M1+1
            % Calculate velocity at cell center (staggered)      
            u_center(i,j)=0.5 * (u(i,j) + u(i-1,j));
            v_center(i,j)=0.5 * (v(i,j) + v(i,j-1));
            
            u1_center(i,j)=0.5 * (u1(i,j) + u1(i-1,j));
            v1_center(i,j)=0.5 * (v1(i,j) + v1(i,j-1));
        end
    end
    
    a0=[zeros(M+1,2) u_center zeros(M+1,3)];
    a0=[zeros(2,N+6); a0; zeros(3,N+6)];
    a1=[zeros(M+1,2) u1_center zeros(M+1,3)];
    a1=[zeros(2,N+6); a1; zeros(3,N+6)];
    a2=(a0+a1)*0.5;

    b0=[zeros(M+1,2) v_center zeros(M+1,3)];
    b0=[zeros(2,N+6); b0; zeros(3,N+6)];
    b1=[zeros(M+1,2) v1_center zeros(M+1,3)];
    b1=[zeros(2,N+6); b1; zeros(3,N+6)];
    b2=(b0+b1)*0.5;
    
  
    
    Y1=zeros(M+6,N+6);
    Y2=zeros(M+6,N+6);
    Ys=zeros(M+6,N+6);
   
    adydx0=calc_adYdx_WENO_2D(Y,a0);
    bdydx0=calc_bdYdy_WENO_2D(Y,b0);
   
    
    % step 1
    for j =4:N+3
        for i =4:M+3
         Y1(i,j)=Y(i,j)-dt*(adydx0(i,j)+bdydx0(i,j));
        end
    end
    Y1=bc_Y3(Y1,t+dt);
    
    adydx1=calc_adYdx_WENO_2D(Y1,a1);
    bdydx1=calc_bdYdy_WENO_2D(Y1,b1);
    %step 2
    for j=4:N+3
        for i =4:M+3
            Y2(i,j)=Y1(i,j)+(3/4)*dt*(adydx0(i,j)+bdydx0(i,j))+-(1/4)*dt*(adydx1(i,j)+bdydx1(i,j));
        end
    end
    Y2=bc_Y3(Y2,t+dt/2);
    
    adydx2=calc_adYdx_WENO_2D(Y2,a2);
    bdydx2=calc_bdYdy_WENO_2D(Y2,b2);
    %step 3
    for j=4:N+3
        for i =4:M+3
         Ys(i,j)=Y2(i,j)+(1/12)*dt*(adydx0(i,j)+bdydx0(i,j))+(1/12)*dt*(adydx1(i,j)+bdydx1(i,j))-(2/3)*dt*(adydx2(i,j)+bdydx2(i,j));
        end
    end
    Ys=bc_Y3(Ys,t+dt);
    
    HY=(Ys-Y)/dt;

end