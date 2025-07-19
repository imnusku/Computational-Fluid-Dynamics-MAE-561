function [a,b,c,d] = bcCN1_v(a,b,c,d,t)

global yf;

[M,N]=size(a);
M=M-2;
N=N-1;
U1=3/4;
alpha1=pi;

%left and right are cell center-based

%left boundary: wall


%left boundary outlet changes:
for j =2:N
        if (yf(j) >= 0.25) &&  (yf(j) <= 0.75)
            b(2,j)=b(2,j)+a(2,j);
        else
            b(2,j)=b(2,j)-a(2,j);
        end
end

%right boundary: wall points
b(M+1,2:N)=b(M+1,2:N)-c(M+1,2:N);

%right boundary inlet changes:
for j=2:N
 if yf(j) > 0.25 &&  yf(j) < 1.25
    d(M+1,j)=d(M+1,j)-2*c(M+1,j)*U1 * sin(alpha1)* (6*(yf(j) - 0.25) / 1)*(1-((yf(j) - 0.25) / 1));
 end
end


end