clear all;
%grid is varied


% Define global parameters

global Re Sc t h CFL xf yc xc yf xc3 yc3 Lx Ly;


% Parameters

Lx = 3; 
Ly = 2;
M = 96;     %the grid is varied
N= 64;      %the grid is varied
Re = 100; 
Sc = 2;
h = Lx / M; %is the same for both x and y 
CFL = 0.9; 
t = 0; 


% Initialize grid

xf = linspace(0, Lx, M + 1)';
yc = linspace(0-h/2,Ly+h/2, N+2)';

xc = linspace(0-h/2,Lx+h/2,M+2)'; 
yf = linspace(0,2,N+1)';

xc3 = linspace(0-2.5*h,Lx+2.5*h,M+6)'; 
yc3 = linspace(0-2.5*h,Ly+2.5*h,N+6)';



% Initialize solution arrays
phi=ones(M+2,N+2);
u_ini = zeros(M+1, N+2);
Hu= zeros(M+1, N+2);

v_ini = zeros(M+2, N+1);
Hv= zeros(M+2, N+1);

Y_ini = zeros(M+6, N+6);

%BCs
phi=bcGS(phi); 
u = bc_u(u_ini, t);
v = bc_v(v_ini, t);
Y = bc_Y3(Y_ini, t);

%Ghost BCs
u= bcGhost_u(u,t);
v= bcGhost_v(v,t);

%Correct Outlet
[u, v]= correctOutlet(u,v);

%Poisson Equation
f=calcDivV(u,v); 
phi=myPoisson(phi,f,h,10,10e-3);

%Project velocities
[u,v] = projectV(u,v, phi, 1);

%Ghost BCs
u= bcGhost_u(u,t);
v= bcGhost_v(v,t);

counter=1;

vid1=VideoWriter('video1','MPEG-4');
open(vid1);
vid2=VideoWriter('video2','MPEG-4');
open(vid2);
vid3=VideoWriter('video3','MPEG-4');
open(vid3);
time_points = 0:0.0049505:10;
for i = 1:length(time_points)
    t = time_points(i);
    outputTime = t + 0.0049505;

   while (t < outputTime)
   [dt, outputFlag] = calcDt(t, outputTime,u,v);
   

   %for the next loop/for the Y for first loop

    u1=u;
    v1=v;

    [Hu, Hv]=hyperbolic_uv_2D(u,v);
 

    %for the first loop only

    if t==0
    Hu1=Hu;
    Hv1=Hv;
    end
 

    Hu_loop=1.5*Hu-0.5*Hu1;
    Hv_loop=1.5*Hv-0.5*Hv1;
 

    %heat source
    [Qu, Qv, QY] = calcSourceIBFinal(u, v, Y, t, dt); 
 
     %added H to the first ADI step Q 
     Qu=Qu+Hu_loop;
     Qv=Qv+Hv_loop;


     %parabolic part
     u_CN1 = parabolic_CN1_2D_u(u,Qu,dt); 
     v_CN1 = parabolic_CN1_2D_v(v,Qv,dt);

     %for the second ADI
     %calculated at the right time
     [Qu, Qv, QY] = calcSourceIBFinal(u_CN1, v_CN1, Y, t+dt/2, dt);
 
     %Added H values to the new Qs again
     Qu=Qu+Hu_loop;
     Qv=Qv+Hv_loop;

     u = parabolic_CN2_2D_u(u_CN1,Qu,dt);
     v = parabolic_CN2_2D_v(v_CN1,Qv,dt);
 
 
     %hyperbolic and parabolic part for Y

     [Qu, Qv, QY] = calcSourceIBFinal(u1, v1, Y, t, dt); %repeated for u and v but isnt used 
     HY=1.5*hyperbolic_Y_WENO_2D(Y,u1,v1,u,v,dt)-0.5*hyperbolic_Y_WENO_2D(Y,u1,v1,u,v,dt); 
     QY=QY+HY;
     Y = parabolic_CN1_2D_Y3(Y,QY,dt);
     [Qu, Qv, QY] = calcSourceIBFinal(u_CN1, v_CN1, Y, t+dt/2, dt); %repeated for u and v but isnt used
     QY=QY+HY;
     Y = parabolic_CN2_2D_Y3(Y,QY,dt);
 
 
     %for the next loop making current hyperbolic t to t-1
     Hu1=Hu;
     Hv1=Hv;
 
     %time-stepping
     t=t+dt;

     %Ghost BCs
     u= bcGhost_u(u,t);
     v= bcGhost_v(v,t);

      %Correct Outlet
      [u, v]= correctOutlet(u,v);

      %HAVENT CALCULATED func, rhs of poisson equation
      %Poisson Equation
       f=calcDivV(u,v); 
       phi=myPoisson(phi,f,h,10,10e-3);
     
       %Project velocities
       [u,v] = projectV(u,v, phi, 1);

       %Ghost BCs
       u= bcGhost_u(u,t);
       v= bcGhost_v(v,t);

 end 

 %calc k

 k(i) = calck(u,v);

 %calc S

 S(i) = calcS3(Y);

if round(t,3)==4 || round(t,3)==4.252 || round(t,3)==4.5 || round(t,3)==4.752 || round(t,3)==5 || round(t,3)==5.252 || round(t,3)==5.50 || round(t,3)==5.752 || round(t,3)==6
 examFig1 = figure(1);
 subplot(3,3,counter);
 pcolor(xf, yc, u');
 shading interp;
 colormap(jet);
 colorbar;
 xlim([0 Lx]);
 ylim([0 Ly]);
 clim([-2.5, 2.5]);
 title(['u @ t= ', num2str(round(t,2))]);
 xlabel('x');
 ylabel('y'); 
 % Adjusting aspect ratio to make the figure rectangular
 pbaspect([3 2 1]); % Set the aspect ratio to 3:2 (width:height)

 examFig2 = figure(2);
 subplot(3,3,counter);
 pcolor(xc, yf, v');
 shading interp;
 colormap(jet);
 colorbar;
 xlim([0 Lx]);
 ylim([0 Ly]);
 clim([-2.5, 2.5]);
 title(['v @ t= ',  num2str(round(t,2))]);
 xlabel('x');
 ylabel('y'); 
 % Adjusting aspect ratio to make the figure rectangular
 pbaspect([3 2 1]); % Set the aspect ratio to 3:2 (width:height)


 examFig3 = figure(3);
 subplot(3,3,counter);
 pcolor(xc3, yc3, Y');
 shading interp;
 colormap(hot);
 colorbar;
 xlim([0 Lx]);
 ylim([0 Ly]);
 clim([0, 1]);
 title(['Y @ t= ',  num2str(round(t,2))]);
 xlabel('x');
 ylabel('y'); 

  % Adjusting aspect ratio to make the figure rectangular
 pbaspect([3 2 1]); % Set the aspect ratio to 3:2 (width:height)
 counter=counter+1;
end

%FOR PLOTTING VIDEO BONUS PROBLEM varied for each variable
figure(6)
pcolor(xf, yc, u');
 shading interp;
 colormap(jet);
 colorbar;
 xlim([0 Lx]);
 ylim([0 Ly]);
 clim([-2.5, 2.5]);
 title(['u @ t= ', num2str(round(t,2))]);
 xlabel('x');
 ylabel('y'); 
 % Adjusting aspect ratio to make the figure rectangular
 pbaspect([3 2 1]); % Set the aspect ratio to 3:2 (width:height)

   F1=getframe(figure(6));
    writeVideo(vid1, F1);


  figure(7);
 pcolor(xc, yf, v');
 shading interp;
 colormap(jet);
 colorbar;
 xlim([0 Lx]);
 ylim([0 Ly]);
 clim([-2.5, 2.5]);
 title(['v @ t= ',  num2str(round(t,2))]);
 xlabel('x');
 ylabel('y'); 
 % Adjusting aspect ratio to make the figure rectangular
 pbaspect([3 2 1]); % Set the aspect ratio to 3:2 (width:height)
 F2=getframe(figure(7));
    writeVideo(vid2, F2);


 figure(8)
 pcolor(xc3, yc3, Y');
 shading interp;
 colormap(hot);
 colorbar;
 xlim([0 Lx]);
 ylim([0 Ly]);
 clim([0, 1]);
 title(['Y @ t= ',  num2str(round(t,2))]);
 xlabel('x');
 ylabel('y'); 
  % Adjusting aspect ratio to make the figure rectangular
 pbaspect([3 2 1]); % Set the aspect ratio to 3:2 (width:height)
 F3=getframe(figure(8));
    writeVideo(vid3, F3);

end
close(vid1);
close(vid2);
close(vid3);

%plotting k
examFig4 = figure(4);
plot(time_points,k);
title('k(t) with time')
xlabel('t');
ylabel('k(t)');


%plotting S
examFig5 = figure(5);
plot(time_points,S);
title('S(t) with time')
xlabel('t');
ylabel('S(t)');


k_bar= myTrapezoidal(time_points,k);
r_bar= myTrapezoidal(time_points,S);
