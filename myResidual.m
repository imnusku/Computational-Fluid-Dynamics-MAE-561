function r = myResidual(phi,f,h)
[M,N] = size(phi);
M=M-2;
N=N-2;
%residual for exterior points/initialization
r=zeros(M+2,N+2);
    for j = 2:N+1
        for i = 2:M+1
            r(i,j) = f(i,j)-(1/h^2)*(phi(i+1,j)-4*phi(i,j)+phi(i-1,j)+phi(i,j+1)+phi(i,j-1));
        end
    end
end