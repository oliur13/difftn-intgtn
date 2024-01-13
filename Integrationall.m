clear;

%% change the range discretization of data
%%% as you like
xmin = 0;
xmax = 2*pi;
nvals = 100;
deltax = (xmax -xmin)/nvals;
%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%
%% name the functions to test
ft = {'simp13','simp38'};
order = 1;
pbc = xmax;
%%%%%%%%%%%%%%%%%%%
%%% generate same inputs
%% this calls the functions at the end of this file
%%%% DO NOT CHANGE THESE
x = xmin:deltax:xmax-deltax;
xrd = deltax*.5*(rand(size(x))-1) + x;
y = myfunc(x);  %%% function
yrd = myfunc(xrd);  %% function w/ nonuniform x
fintx = myint(x);
fintxrd = myint(xrd);

figure(3)
title("Integration")
for cnt = 1:length(ft)
 fn = str2func(ft{cnt});
 [xint,pint,int] = fn(x,y,pbc,nvals);
 soln = myint(xint); 
 lpint = length(pint);
 [xintxrd,pintxrd,intxrd] = fn(xrd,yrd,pbc,nvals);
 solnxrd = myint(xintxrd);
 lpintxrd = length(pintxrd);
 subplot(2,2,1)
 title("Integ f(x)")
 hold on
 plot(xint,pint);
 hold off;
 subplot(2,2,2)
  title("Integ f(x+rand(d))")
 hold on;
 plot(xintxrd,pintxrd);
 hold off;

 subplot(2,2,3)
 ErrX =abs(pint-soln);
 hold on; plot(xint,ErrX); hold off;
 title("(Error)") 
 subplot(2,2,4);
ErrXrd =abs(pintxrd-solnxrd);
hold on; plot(xintxrd,ErrXrd); hold off;
title("Log10(Error)")
Estring = sprintf("%7s ERror: %8.3f %8.3f %8.3f %8.3f %8.3f\n",...
     ft{cnt},...
     max(ErrX),min(ErrXrd),...
     max(ErrXrd),min(ErrXrd)); %%%,...
% %  fprintf(fp,"%s\n", Estring);
 disp(Estring)
end
subplot(2,2,1)
 hold on
 plot(xint,myint(xint));
 hold off;
legend(horzcat(ft,{'soln'}))

subplot(2,2,2)
 hold on
 plot(xintxrd,myint(xintxrd));
 hold off;
legend(horzcat(ft,{'soln'}))


%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% TOMS FUNCTIONS for generating data
%%%%%%%%%%%%%%%%%%%%%%%%%

function  fun = myfunc(x)
   fun = sin(x);
end

function derv = myderv(x)
   derv = cos(x);
end

function int = myint(x)
   int = 1-cos(x);
   tmp = 0;
end
