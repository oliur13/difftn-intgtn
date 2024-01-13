function [xint,pint,int] = newsimp13(x,y,pbc,nvals)
% HELP - Computes the integral of y(x) using Simpson's 1/3 rule with Simpson's 3/8 rule in the end if needed

% Inputs:
% x: vector of x values
% y: vector of y values
% pbc: periodic boundary condition value
% nval: number of intervals
%
% Outputs:
% xint: vector of x values at which the function is integrated
% pint: vector of integrated function values at xint
% int: scalar value of the integral
xmin = 0;
xmax = 2*pi;
nvals = 99;
deltax = (xmax -xmin)/nvals;
pbc = xmax;

x = xmin:deltax:xmax-deltax;
y = sin(x);

    % Check that the length of x and y match
    if length(x) ~= length(y)
        error('Error: x and y vectors must be the same length.')
    end

    % Calculate the width of each interval
    dx = (x(end) - x(1)) / (nvals);

    % Determine whether nval is even or odd
    iseven = mod(nvals, 2) == 0;

    % Initialize variables
    xint = zeros(1, nvals);
    pint = [];
    ppint = zeros(1, nvals);

    % Calculate the integrated function value at the first x value
    xint(1) = x(1);
    ppint(1) = 0;
    pint(1) = 0;

    % Calculate the integrated function value at each x value
    for i = 2:nvals
        xint(i) = xint(i-1) + dx;
        
        % If nval is even and we're on the last three intervals, use
        % Simpson's 3/8 rule
        if iseven && i >= nvals-2
            ppint(i) = ppint(i-1) + (dx/8)*(y(i-1) + 3*y(i) + 3*y(i+1) + y(i+2));
        % Otherwise, use Simpson's 1/3 rule
        else
            ppint(i) = ppint(i-1) + (dx/6)*(y(i-1) + 4*y(i) + y(i+1));
            
            
        end
        pint = cat(1,ppint(i));
    end
    ppint = cumsum(ppint);
    xint = x;

    % Calculate the integral using periodic boundary conditions
    if pbc
        int = pint(end) - pint(1) + (pbc/2)*(y(1) + y(end));
    else
        int = pint(end);
    end
end