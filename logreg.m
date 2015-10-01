function [err, pred]= logreg(x,y,theta)
%
%
%err = (1/size(x))*sum(x*(1/((1+exp(-theta.'*x))))-y);
%err = (1/size(x))*(x*(1/((1+exp(-theta.'*x))))-y);
%size((1./((1+exp(-x*theta'))))-y)
err = 0;
for i=1:length(x)
    ppred = 1./(1+exp(-theta'*x(i,:)'));
    if ppred > 0.5
        pred(i) = 1;
    else
        pred(i) = 0;
    end
    err = err +(1/size(x,1))*((1./((1+exp(-theta'*x(i,:)')))-y(i,:))'*x(i,:)');
    %err = err +(1/size(x,1))*((1./ppred)-y(i,:))'*x(i,:)';
end
%size(err)