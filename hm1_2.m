function hm1_2(x,y,l)
%
%
%
indx = randperm(length(x));
[xlen,xhei] = size(x);
[ylen,yhei] = size(y);
err = zeros(l,1);
errT = zeros(l,1);
xerr = zeros(l,1);
xerrT =zeros(l,1);
allerr = zeros(l,1);
allerrT = zeros(l,1);
for i=1:l
    [err(i),model,errT(i)] = multireg(x(1:xlen/2,:),y(1:ylen/2),i,x(xlen/2+1:xlen,:),y(ylen/2+1:ylen));
    [xerr(i),model,xerrT(i)] = multireg(x(xlen/2+1:xlen,:),y(ylen/2+1:ylen),i,x(1:xlen/2,:),y(1:ylen/2));
end

allerr = (err+xerr)./2;
allerrT= (errT+xerrT)./2;

figure
plot(1./[1:l],allerr,1./[1:l],allerrT)

