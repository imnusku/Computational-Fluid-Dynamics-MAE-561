function [a,b,c,d] = bcCN1_Y3(a,b,c,d,t)

global yc3;

[M,N]=size(a);
M=M-6;
N=N-6;


%left and right are cell centered based
%left

for j =4:N+3
    b(4,j)=a(4,j)+b(4,j);
end

%right
for j =4:N+3
        if yc3(j) > 0.25 &&  yc3(j) < 1.25
            b(M+3,j)=b(M+3,j)-c(M+3,j);
            d(M+3,j)=d(M+3,j)-2*c(M+3,j);
        else
            b(M+3,j)=b(M+3,j)+c(M+3,j);
        end
end

end

