function diff = fdiff(x,y,order,pbc)
%HELP - This is forward difference method
arguments
       x (1,:)
       y (1,:)
       order =1
       pbc = 2*pi;
end
   hvals = circshift(x,-1) - x ;
   hvals(end) = hvals(end) + pbc;
   diff = (circshift(y,-1) - y)./hvals ;
end
