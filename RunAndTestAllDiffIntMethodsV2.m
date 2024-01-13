clear;

%% Script for Assignment 5 Diff-Int
% Reads and Tests three differenciation methods and three integration
% methods
% lla027@latech.edu
% PHYS 540 Winter 2023
%% Works for any range of x and nvals

xmin = 0;
xmax = 6*pi;
nvals = 1000;
deltax = (xmax -xmin)/nvals;
%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%
%% name the functions to test
fs = {'fdiff', 'cdiff', 'bdiff'};
ft = {'mytrap','mysimp13','mysimp38'};
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
fpx = myderv(x);  %%% its derivative
fpxrd = myderv(xrd);%% derivative for nonunif. data
fintx = myint(x);
fintxrd = myint(xrd);

figure(1)
plot(x,y,'-+',xrd,yrd,'-o');
legend("F(x)","F(x+rand(d))")
%%% THE ANALYSIS FOLLOWS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% TEST differencing functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
title('Differences')
%% differences
subplot(2,2,1)
plot(x,fdiff(x,y,order,pbc),'-.b',x,cdiff(x,y,order,pbc),'--r',x,bdiff(x,y,order,pbc),'-.g',x,fpx,"-")
legend("fdiff","cdiff","bdiff","f'(x)")
title("F(x)")

subplot(2,2,2)
plot(xrd,fdiff(xrd,yrd,order,pbc),'-.b',xrd,cdiff(xrd,yrd,order,pbc),'--r',xrd,bdiff(xrd,yrd,order,pbc),'-.g',xrd,fpxrd,'-')
legend("fdiff","cdiff","bdiff","f'(x)")
title("F(x+rand(d))")


subplot(2,2,3)
plot(x,abs((fdiff(x,y)-fpx)),'+',...
    x,abs((cdiff(x,y)-fpx)),'o',...
    x,abs((bdiff(x,y)-fpx)),'x')

legend(fs)
title("Error")

subplot(2,2,4)
plot(xrd,abs((fdiff(xrd,yrd)-fpxrd)),'+',...
    xrd,abs((cdiff(xrd,yrd)-fpxrd)),'o',...
    xrd,abs((bdiff(xrd,yrd)-fpxrd)),'x')

legend(fs)
title("Error2")

%%% test help routines
disp("Help messages:")
disp("  **help fdiff*** " ) 
help fdiff
disp("  **help cdiff*** ")
help cdiff
disp("  **help bdiff*** ")
help bdiff
disp("")
disp("LOG10(ERROR) TABLE: Differencing")
disp("")
for cnt = 1:length(fs)
 fn = str2func(fs{cnt});
 ErrX =log10(abs((fn(x,y)-fpx)));
 ErrXrd = log10(abs((fn(xrd,yrd)-fpxrd)));
 %t = str2func(strcat('@',fs{cnt},'(x,y)')) ;
 Estring = sprintf("%7s error: %8.3f %8.3f %8.3f %8.3f %8.3f\n",...
     fs{cnt},...
     max(ErrX),min(ErrXrd),...
     max(ErrXrd),min(ErrXrd)); %%%,...
     %timeit(t,10));
% %  fprintf(fp,"%s\n",Estring);   
 disp(Estring)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% TEST integration functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp( " ")
disp( " *******   NOW TESTING INTEGRATION **** ")
disp(" ")
%%% test help routines
disp("Help messages:")
disp("  **help mytrap*** " ) 
help mytrap
disp("  **help mysimp13*** ")
help mysimp13
disp("  **help mysimp38*** ")
help mysimp38

disp("LOG10(ERROR) TABLE: Integration")

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
 title("Error")
 subplot(2,2,4);
ErrXrd =abs(pintxrd-solnxrd);
hold on; plot(xintxrd,ErrXrd); hold off;
title("Error of Rand data")
Estring = sprintf("%7s Error: %8.3f %8.3f %8.3f %8.3f %8.3f\n",...
     ft{cnt},...
     max(ErrX),min(ErrX),...
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

subplot(2,2,3)
legend(ft)

subplot(2,2,4)
legend(ft)

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





