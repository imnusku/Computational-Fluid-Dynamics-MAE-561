function [a,b,c,d] = bcCN2_Y3(a,b,c,d,t)

global xc3;

[M,N]=size(a);
M=M-6;
N=N-6;


%top and bottom are cell centered based
%top

for i =4:M+3
    if xc3(i) > 2 && xc3(i) < 2.5
       b(i,N+3)=b(i,N+3)-c(i,N+3);
    else
        b(i,N+3)=b(i,N+3)+c(i,N+3);
    end
end

%bottom
for i =4:M+3
    if xc3(i) > 1.5 && xc3(i) < 2
       b(i,4)=b(i,4)-a(i,4);
    else
       b(i,4)=b(i,4)+a(i,4);  
    end
end

end
