function [Hu Hv]= hyperbolic_uv_2D(u,v)
    
    global h;
    [M,N]=size(u);
    M=M-1;
    N=N-2;
    Hu=zeros(M+1,N+2);
   
    %for u
    for j=2:N+1
        for i=2:M
            u_ij=0.5*(u(i,j)+u(i-1,j)); %chnaged
            u_ihalfjhalf=0.5*(u(i,j)+u(i,j+1));
            v_ihalfjhalf=0.5*(v(i,j)+v(i+1,j)); 
            
      
            u_ihalfjhalfneg=0.5*(u(i,j)+u(i,j-1));
            v_ihalfjhalfneg=0.5*(v(i,j-1)+v(i+1,j-1)); 
            
            
            duu_dx(i,j)=((0.5*(u(i+1,j)+u(i,j))).^2-u_ij.^2)/h;
            duv_dy(i,j)=(u_ihalfjhalf*v_ihalfjhalf-u_ihalfjhalfneg*v_ihalfjhalfneg)/h;
            
            Hu(i,j)=-duu_dx(i,j)-duv_dy(i,j); %MISSED THE TAKE TO RHS SIDE
            
        end
    end
    
    %for v
    [M,N]=size(v);
    M=M-2;
    N=N-1;
    Hv=zeros(M+2,N+1);
    
    for j=2:N
        for i=2:M+1
            v_ij(i,j)=0.5*(v(i,j)+v(i,j-1));
            
            u_ihalfjhalf_V(i,j)=0.5*(u(i,j)+u(i,j+1));
            v_ihalfjhalf_V(i,j)= 0.5*(v(i,j)+v(i+1,j));
            
            u_ihalfjhalfneg_V(i,j)=0.5*(u(i-1,j)+u(i-1,j+1));
            v_ihalfjhalfneg_V(i,j)=0.5*(v(i,j)+v(i-1,j)); 
            
            
            dvv_dy(i,j)=((0.5*(v(i,j+1)+v(i,j))).^2-v_ij(i,j).^2)/h;
            duv_dx(i,j)=(u_ihalfjhalf_V(i,j)*v_ihalfjhalf_V(i,j)-u_ihalfjhalfneg_V(i,j)*v_ihalfjhalfneg_V(i,j))/h;
            
            Hv(i,j)=-dvv_dy(i,j)-duv_dx(i,j);
            
        end
    end
    

end