function [phi,Linf,iter] = myPoisson(phi, f, h, nIterMax, epsilon)
[M,N]=size(phi);
M=M-2;
N=N-2;
residual_norm(1) = myRelResNorm(phi,f,h);
phi=myMultigrid(phi,f,h);
iter=1;
    for i=2:nIterMax
        phi=myMultigrid(phi,f,h);
        residual_norm(i) = myRelResNorm(phi,f,h);
        if residual_norm(i)<epsilon
            break;
        end
        iter=iter+1;
    end
    Linf=myRelResNorm(phi,f,h);
end