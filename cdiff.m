function diff = cdiff(x,y,order,pbc)
%HELP: this is modified cdiff for 2nd order cdiff
arguments
       x (1,:)
       y (1,:)
       order =2;
       pbc = 2*pi;
end
   %hvals = circshift(x,-1) - x ;
   hvals = circshift(x,-1) - circshift(x,1);
   hvals(1) = hvals(1) + pbc;
   %diff = (circshift(y,-1) - y)./hvals ;
   diff = (circshift(y,-1) - order*y + circshift(y,1))./(hvals.^order); % 2nd order central difference formula
end
