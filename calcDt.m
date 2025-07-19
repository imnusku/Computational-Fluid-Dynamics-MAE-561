function [dt, outputFlag] = calcDt(t, outputTime, u,v)
    global h;
    global CFL;
 
    % Initialize output flag
    outputFlag = 0;

    %Hyperbolic: from end of module 7 LOOK AT THE MODULESSS DONT GUESS!!!
    %ends of becoming the same for both 1-2
    dt_hyper=CFL * h/ (max(abs(u),[],"all")+ max(abs(v),[],"all"));
    
    %parabolic
    %assumin nu to be 1
    dt_para=CFL *h^2;    %this is for crank nicolson you had it for FTCS!!!
    
    dt=min(dt_hyper,dt_para);

    % Check if the next time step exceeds the output time
        if (t < outputTime) && (t + dt >= outputTime)
            % Adjust time step for last step to match output time
            dt = outputTime - t;
          
            % Set output flag to indicate reaching output time
            outputFlag = 1;
        end   
       
end