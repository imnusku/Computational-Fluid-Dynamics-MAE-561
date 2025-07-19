function [u]=bcGhost_u(u,t)

global xf;

[M,N]=size(u);
M=M-1;
N=N-2;



U2=2;
U3=3;

alpha2=pi/3;
alpha3= pi/6;


%wall no-slip bc are dirichlet boundary 
% applied directly in node
%not in cell centered based

%top and bottom are cell centered based
%top
u(1:M+1,N+2)=-u(1:M+1,N+1);



%set inlet3
%top
for i =1:M+1
    if xf(i) > 2 && xf(i) < 2.5
        u(i,N+2)= 2*U3 * cos(alpha3)* (6*(xf(i) - 2) / 0.5)*(1-((xf(i) - 2) / 0.5))-u(i,N+1);;
    end
end


%bottom
u(1:M+1,1)=-u(1:M+1,2);

%set inlet2
%bottom
for i =1:M+1
    if xf(i) > 1.5 && xf(i) < 2
        u(i,1)= 2*U2 * cos(alpha2)* (6*(xf(i) - 1.5) / 0.5)*(1-((xf(i) - 1.5) / 0.5))-u(i,2);
    end
end

end