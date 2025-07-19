function divV = calcDivV(u,v)
    global h;

    % Initialize du with zeros
    [M,N]=size(u);
    M=M-1;
    N=N-2;
    du = zeros(M+2,N+2);
    dv = zeros(M+2,N+2);
    divV=zeros(M+2,N+2);

    % Calculate du, dv and divV in the interior cells
    for j =2:N+1
        for i = 2:M+1
            du(i, j) = (u(i, j) - u(i-1, j)) / (h);
            dv(i, j) = (v(i, j) - v(i, j-1)) / (h);
            divV(i,j)= du(i,j)+dv(i,j);
        end
    end

end