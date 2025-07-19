function [Y]=bc_Y3(Y,t)

global xc3 yc3;

[M,N]=size(Y);
M=M-6;
N=N-6;

%top and bottom are cell-centered based
%top
Y(4:M+3,N+6)=Y(4:M+3,N+1);
Y(4:M+3,N+5)=Y(4:M+3,N+2);
Y(4:M+3,N+4)=Y(4:M+3,N+3);

%bottom
Y(4:M+3,1)=Y(4:M+3,6);
Y(4:M+3,2)=Y(4:M+3,5);
Y(4:M+3,3)=Y(4:M+3,4);


%left and right are cell centered based
%left
Y(1,4:N+3)=Y(6,4:N+3);
Y(2,4:N+3)=Y(5,4:N+3);
Y(3,4:N+3)=Y(4,4:N+3);

%right
Y(M+6,4:N+3)=Y(M+1,4:N+3);
Y(M+5,4:N+3)=Y(M+2,4:N+3);
Y(M+4,4:N+3)=Y(M+3,4:N+3);


%set inlet2
%bottom
for i =4:M+3
    if xc3(i) > 1.5 && xc3(i) < 2
        Y(i,1)= 2*0-Y(i,6);
        Y(i,2)= 2*0-Y(i,5);
        Y(i,3)= 2*0-Y(i,4);
    end
end

%set inlet3
%top
for i =4:M+3
    if xc3(i) > 2 && xc3(i) < 2.5
        Y(i,N+6)= 2*0-Y(i,N+1);
        Y(i,N+5)= 2*0-Y(i,N+2);
        Y(i,N+4)= 2*0-Y(i,N+3);
    end
end


%set inlet1
%right
for j =4:N+3
        if yc3(j) > 0.25 &&  yc3(j) < 1.25
            Y(M+6,j)= 2*1-Y(M+1,j); 
            Y(M+5,j)= 2*1-Y(M+2,j); 
            Y(M+4,j)= 2*1-Y(M+3,j); 
        end
end


%set outlet
%left boundary 
for j =4:N+3
        if (yc3(j) >= 0.25) &&  (yc3(j) <= 0.75)
            Y(1,j)= Y(6,j); 
            Y(2,j)= Y(5,j);
            Y(3,j)= Y(4,j);
        end
end

end