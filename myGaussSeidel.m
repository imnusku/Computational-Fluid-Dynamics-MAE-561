function phi=myGaussSeidel(phi,f,h,niter)
[M,N] = size(phi);
M=M-2;
N=N-2;
for k=1:niter
    for j =2:N+1
        for i=2:M+1
           phi(i,j)=(phi(i-1,j)+phi(i+1,j)+phi(i,j-1)+phi(i,j+1))/4-h^2*f(i,j)/4; %copied exact
        end
    end
    phi=bcGS(phi);
end
end