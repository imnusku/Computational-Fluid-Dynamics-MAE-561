function [a,b,c,d] = bcCN2_v(a,b,c,d,t)

global xc;

[M,N]=size(a);
M=M-2;
N=N-1;
U2=2;
U3=3;
alpha2=pi/3;
alpha3=-pi/6;


%top and bottom are node-based
%top wall
%same

%top inlet: node based dirichlet
for i =2:M+1
    if xc(i) > 2 && xc(i) < 2.5
        d(i,N)= d(i,N)-c(i,N)*U3 * sin(alpha3)* (6*(xc(i) - 2) / 0.5)*(1-((xc(i) - 2) / 0.5));
    end
end

%bottom
%same

%bottom inlet: node based dirichlet
for i =2:M+1
    if xc(i) > 1.5 && xc(i) < 2
        d(i,2)= d(i,2)-a(i,2)*U2 * sin(alpha2)* (6*(xc(i) - 1.5) / 0.5)*(1-((xc(i) - 1.5) / 0.5));
    end
end




end