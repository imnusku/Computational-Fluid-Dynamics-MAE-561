function [u]=bc_u(u,t)

global xf yc;

[M,N]=size(u);
M=M-1;
N=N-2;

U1=3/4;
U2=2;
U3=3;
alpha1=pi;
alpha2=pi/3;
alpha3= pi/6;


%wall no-slip bc are dirichlet boundary 
% applied directly in node
%not in cell centered based

%top and bottom are cell centered based
%top
u(2:M,N+2)=-u(2:M,N+1);

%bottom
u(2:M,1)=-u(2:M, 2);

%left and right are node center based
%left
u(1,2:N+1)=0;
%right
u(M+1,2:N+1)=0;


%set inlet1
%right
for j =2:N+1
        if yc(j) > 0.25 &&  yc(j) < 1.25
            u(M+1,j)= U1 * cos(alpha1)* (6*(yc(j) - 0.25) / 1)*(1-((yc(j) - 0.25) / 1)); 
        end
end

%set inlet2
%bottom
for i =2:M
    if xf(i) > 1.5 && xf(i) < 2
        u(i,1)= 2*U2 * cos(alpha2)* (6*(xf(i) - 1.5) / 0.5)*(1-((xf(i) - 1.5) / 0.5))-u(i,2);
    end
end

%set inlet3
%top
for i =2:M
    if xf(i) > 2 && xf(i) < 2.5
        u(i,N+2)= 2*U3 * cos(alpha3)* (6*(xf(i) - 2) / 0.5)*(1-((xf(i) - 2) / 0.5))-u(i,N+1);;
    end
end

%set outlet
%left boundary %IS NEUMANN %check %CALCULATE  %second order node based, use that from last hoemwork
for j =2:N+1
        if yc(j) > 0.25 &&  yc(j) < 0.75
            u(1,j)=   -(1/3)*u(3,j)+(4/3)*u(2,j); 
        end
end

end