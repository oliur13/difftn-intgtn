function diff = bdiff(x,y,order,pbc)
%HELP: this is modifed bdiff
arguments
       x (1,:)
       y (1,:)
       order =1
       pbc = 2*pi;
end
   hvals = circshift(x,-1) - x ;
   hvals(1) = hvals(1) + pbc;
   % diff = (circshift(y,-1) - y)./hvals ;
   diff = (y - circshift(y,1))./hvals ; % backward difference formula
end
