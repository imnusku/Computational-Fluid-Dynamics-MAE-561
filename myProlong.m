function eh=myProlong(e2h)
[M,N] = size(e2h);
M=M-2;                              %size of coarse values, x
N=N-2;                              %size of coare values, y

eh=zeros(2*M+2,2*N+2);
for j=2:N+1                       %loop over size of coarse mesh mid values
    for i =2:M+1
        eh(2*i-2,2*j-2)=e2h(i,j);
        eh(2*i-1,2*j-2)=e2h(i,j);
        eh(2*i-2,2*j-1)=e2h(i,j);
        eh(2*i-1,2*j-1)=e2h(i,j);
    end
end
eh = bcGS(eh);
end
            

