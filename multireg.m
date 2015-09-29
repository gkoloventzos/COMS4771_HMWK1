function [err,model,errT] = multireg(x,y,l,xT,yT)
%
% Finds a D-1 order polynomial fit to the data
%
%    function [err,model,errT] = polyreg(x,y,D,xT,yT)
%
% x = vector of input scalars for training
% y = vector of output scalars for training
% D = the order plus one of the polynomial being fit
% xT = vector of input scalars for testing
% yT = vector of output scalars for testing
% err = average squared loss on training
% model = vector of polynomial parameter coefficients
% errT = average squared loss on testing
%
%

model = inv(x'*x+l*eye*(size(x,2)))*x'*y;
err   = (1/(2*length(x)))*sum((y-x*model).^2+(l/(2*length(x)))*norm(model).^2);

if (nargin==5)
    errT  = (1/(2*length(xT)))*sum((yT-xT*model).^2+(l/(2*length(xT)))*norm(model).^2);
end

%clf
%plot(model,1/l,'X');
%hold on
%if (nargin==5)
%plot(xT,yT,'cO');
%end