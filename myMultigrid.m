function phi=myMultigrid(phi,f,h)
%global Mfine;
M = size(phi,1)-2; N = size(phi,2)-2;
phi = myGaussSeidel(phi,f,h,1);

if mod(M,2)==0 && mod(N,2)==0
  rh = myResidual(phi,f,h);
  r2h = myRestrict(rh);
  e2h = zeros(M/2+2,N/2+2); %2D cell centered
  e2h = myMultigrid(e2h,r2h,2*h);
  eh = myProlong(e2h);
  phi = phi + eh;
  phi = bcGS(phi);
  phi = myGaussSeidel(phi,f,h,1);
else
  phi = myGaussSeidel(phi,f,h,3);
end
        