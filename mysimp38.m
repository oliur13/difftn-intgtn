function [xint, pint, int] = mysimp38(x, y, pbc, nvals)
% Help - Computes the integral of y(x) using Simpson's 3/8 rule with Simpson's 1/3 rule in the end if needed
%% nvals should parse with the script when calling the function!!!!!!

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

arguments
    x (1,:) 
    y (1,:)
    pbc {mustBeNumeric} = 2*pi;
    nvals {mustBePositive, mustBeInteger} = 1;
end
    % Calculate the width of each interval
    dx = (x(end) - x(1)) / (nvals-1);

    % Determine the modulus of nval
    mod2 = mod(nvals, 3) == 2;
    mod1 = mod(nvals, 3) == 1;

    % Initialize variables
    xint = zeros(1, nvals);
    pint = zeros(1, nvals);

    % Calculate the integrated function value at the first x value
    xint(1) = x(1);
    pint(1) = 0;

    % Calculate the integrated function value at each x value
    for i = 2:nvals-2
        xint(i) = xint(i-1) + dx;
        
        % If mod(nval,3) == 2 and we're on the last two intervals, use
        % Simpson's 1/3 rule
        if mod2 && i >= nvals-1
            pint(i) = pint(i-1) + (dx/6)*(y(i) + 4*y(i+1) + y(i+2));
            % If mod(nval,3) == 1 and we're on the last four intervals, use
            % Simpson's 1/3 rule twice
        elseif mod1 && i >=nvals-3
                pint(i) = pint(i-1) + (dx/6)*(y(i-2) + 4*y(i-1) +2*y(i) + 4*y(i+1) + y(i+2));
        % Otherwise, use Simpson's 3/8 rule
        else
            pint(i) = pint(i-1) + (dx/8)*(y(i-1) + 3*y(i) + 3*y(i+1) + y(i+2));
        end
    end

    % Calculate the integral using periodic boundary conditions
    if pbc
        int = pint(end) - pint(1) + (pbc/2)*(y(1) + y(end));
    else
        int = pint(end);
    end
end
