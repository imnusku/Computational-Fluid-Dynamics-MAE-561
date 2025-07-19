function r2h=myRestrict(rh)
[M,N] = size(rh);
M=M-2;                              %size of fine values, x
N=N-2;                              %size of fine values, y

r2h=zeros(M/2+2,N/2+2);
for j=2:N/2+1                       %loop over size of coarse mesh mid values
    for i =2:M/2+1
        r2h(i,j)=0.25*(rh(2*i-2,2*j-2)+rh(2*i-1,2*j-2)+rh(2*i-2,2*j-1)+rh(2*i-1,2*j-1));
    end
end

end