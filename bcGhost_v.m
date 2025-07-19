function [v]=bcGhost_v(v,t)

global yf;

[M,N]=size(v);
M=M-2;
N=N-1;

U1=3/4;
U2=2;
U3=3;
alpha1=pi;
alpha2=pi/3;
alpha3= -pi/6;


%left and right are cell centered based
%left
v(1,1:N+1)=-v(2,1:N+1);
%right
v(M+2,1:N+1)=-v(M+1,1:N+1);


%set outlet
%left boundary 
for j =1:N+1
        if (yf(j) >= 0.25) &&  (yf(j) <= 0.75)
            v(1,j)= v(2,j); 
        end
end

%set inlet1
%right
for j =1:N+1
        if yf(j) > 0.25 &&  yf(j) < 1.25
            v(M+2,j)= 2*U1 * sin(alpha1)* (6*(yf(j) - 0.25) / 1)*(1-((yf(j) - 0.25) / 1))-v(M+1,j); 
        end
end


end

