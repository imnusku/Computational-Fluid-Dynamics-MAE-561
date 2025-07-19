function [a,b,c,d] = bcCN1_u(a,b,c,d,t)

global yc;

[M,N]=size(a);
M=M-1;
N=N-2;


U1=3/4;
alpha1=pi;


%left and right are node-based

%left boundary: all wall points are same
%left boundary outlet changes:
%set outlet values: only b and c changed
for j =2:N+1
        if yc(j) >= 0.25 &&  yc(j) <= 0.75
            b(2,j)=4/3*a(2,j)+b(2,j);
            c(2,j)=-a(2,j)/3+c(2,j);
        end
end
a(2,2:N+1)= 0;



%right boundary 
%inlet_1
for j =2:N+1
       if yc(j) > 0.25 &&  yc(j) < 1.25
           
         d(M,j)= d(M,j)-c(M,j)*U1 * cos(alpha1)* (6*(yc(j) - 0.25) / 1)*(1-((yc(j) - 0.25) / 1));
    end
end

%right wall
c(M,2:N+1)=0;

end


