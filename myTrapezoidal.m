function I = myTrapezoidal(x, y)

    % Number of data points
    N = numel(x);
    
    % Initialize integral
    I = 0;
    
    % Calculate integral using composite trapezoidal rule
    for i = 1:N-1
        % Interval width
        h = x(i+1) - x(i);
        
        % Trapezoidal rule for this interval
        I = I + 0.5 * h * (y(i) + y(i+1));
    end
end