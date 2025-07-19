function [v]=bc_v(v,t)

global xc yf;

[M,N]=size(v);
M=M-2;
N=N-1;

U1=3/4;
U2=2;
U3=3;
alpha1=pi;
alpha2=pi/3;
alpha3= -pi/6;


%wall no-slip bc are dirichlet boundary 
% applied directly in node
%not in cell centered based

%top and bottom are node based
%top
v(2:M+1,N+1)=0;

%bottom
v(2:M+1,1)=0;

%left and right are cell centered based
%left
v(1,2:N)=-v(2,2:N);
%right
v(M+2,2:N)=-v(M+1,2:N);


%set inlet1
%right
for j =2:N
        if yf(j) > 0.25 &&  yf(j) < 1.25
            v(M+2,j)= 2*U1 * sin(alpha1)* (6*(yf(j) - 0.25) / 1)*(1-((yf(j) - 0.25) / 1))-v(M+1,j); 
        end
end

%set inlet2
%bottom
for i =2:M+1
    if xc(i) > 1.5 && xc(i) < 2
        v(i,1)= U2 * sin(alpha2)* (6*(xc(i) - 1.5) / 0.5)*(1-((xc(i) - 1.5) / 0.5));
    end
end

%set inlet3
%top
for i =2:M+1
    if xc(i) > 2 && xc(i) < 2.5
        v(i,N+1)= U3 * sin(alpha3)* (6*(xc(i) - 2) / 0.5)*(1-((xc(i) - 2) / 0.5));
    end
end

%set outlet
%left boundary 
for j =2:N
        if (yf(j) >= 0.25) &&  (yf(j) <= 0.75)
            v(1,j)= v(2,j); 
        end
end

end