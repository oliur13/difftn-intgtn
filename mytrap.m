function [xint,pint,int] = mytrap(x,y,pbc,nvals)
% HELP: This is trapaziod rule

arguments
       x (1,:)
       y (1,:)
       pbc = 2*pi;
       nvals = 1;
end
   hvals = circshift(x,-1) - x ;
   hvals(end) = hvals(end) + pbc;

 pint = 1/2 * cumsum( (circshift(y,-1) + y) .* hvals );
 xint = x;
 %% why not 
 %%pint = 1/2 * cumsum( (circshift(y,-1) + y).* (circshift(x,-1) - x)); No
 %%neeed of this as long as hvals are calculated correctly

 tolerance = 1e-6;
if abs(x(1)-x(end+deltax)) < tolerance
    fprintf('Data is periodic.\n');
else
    fprintf('Data is not periodic.\n');
end
 pint = 1-pint;
 int = pint(end);
end