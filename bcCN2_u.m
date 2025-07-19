function [a,b,c,d] = bcCN2_u(a,b,c,d,t)

global xf;

[M,N]=size(a);
M=M-1;
N=N-2;

U1=3/4;
U2=2;
U3=3;
alpha1=pi;
alpha2=pi/3;
alpha3= pi/6;

%top and bottom are cell center-based

%top boundary
%top
b(2:M,N+1)=b(2:M,N+1)-c(2:M,N+1);
%top boundary inlet changes:
%set inlet values: only b and d changed
%inlet3 
for i =2:M
    if xf(i) > 2 && xf(i) < 2.5
%        b(i,N+1)= b(i,N+1)-c(i,N+1);
        d(i,N+1)=d(i,N+1)-2*c(i,N+1)*U3 * cos(alpha3)* (6*(xf(i) - 2) / 0.5)*(1-((xf(i) - 2) / 0.5));
    end
end


%bottom boundary
%bottom wall
b(2:M,2)= b(2:M,2)-a(2:M,2);

%bottom boundary inlet changes: 
%inlet2
for i =2:M
    if xf(i) > 1.5 && xf(i) < 2
%         b(i,2)= b(i,2)-a(i,2);
         d(i,2)= d(i,2)-2*a(i,2)*U2 * cos(alpha2)* (6*(xf(i) - 1.5) / 0.5)*(1-((xf(i) - 1.5) / 0.5));
    end
end


end