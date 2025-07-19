function [u, v]= correctOutlet(u,v)
    global h yc ucorr;
     
    L_out=0.5;
    
    [M1,N1]=size(u);
    M1=M1-1;
    N1=N1-2;
    
    [M2,N2]=size(v);
    M2=M2-2;
    N2=N2-1;
    
    u_asterisk1=0;
    u_asterisk2=0;
    v_asterisk1=0;
    v_asterisk2=0;
    for j =2:N1+1
        u_asterisk1=u_asterisk1+u(1,j)*h;
        u_asterisk2=u_asterisk2+u(M1+1,j)*h;
    end

    for i =2:M2+1
        v_asterisk1=v_asterisk1+v(i,1)*h;
        v_asterisk2=v_asterisk2+v(i,N2+1)*h;
    end
    q_dot_asterisk=u_asterisk1-u_asterisk2+v_asterisk1-v_asterisk2;
    q_corr=q_dot_asterisk;
    ucorr=q_corr/L_out;
    
 
   for j = 2:N1+1
        if yc(j)>=0.25 && yc(j) <=0.75
              u(1,j)=u(1,j)-ucorr;
        end
   end
   
 

end
