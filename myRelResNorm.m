function rr= myRelResNorm(phi,f,h)
[M,N] = size(phi);
M=M-2;
N=N-2;

%calling myResidual for residual
r=myResidual(phi,f,h);

%residual inf norm
r_inf= max(max(abs(r(2:M+1,2:N+1))));

%function inf norm
f_inf= max(max(abs(f(2:M+1,2:N+1))));

%relative residual norm
rr=r_inf/f_inf;

end