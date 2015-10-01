function hm1_1(x,y,D)
%
%Function that find the best degree from empirical risk
%and form a 2 fold cross validation on our dataset
%
%
%

indx = randperm(length(x));
emp_err=zeros(D,1);
xTr=zeros(length(x)/2,1);
yTr=zeros(length(x)/2,1);
xTe=zeros(length(x)/2,1);
yTe=zeros(length(x)/2,1);
cross_err_1=zeros(D,1);
cross_err_2=zeros(D,1);
cross_errT_1=zeros(D,1);
cross_errT_2=zeros(D,1);

for i=1:length(x)/2
    xTr(i)=x(indx(i));
    yTr(i)=y(indx(i));
end

for i=length(x)/2+1:length(x)
    xTe(i)=x(indx(i));
    yTe(i)=y(indx(i));
end

for i=1:D
    [emp_err(i),emp_mod] = polyreg(x,y,i);
end
emp_err

best_emp_d=find(emp_err==min(emp_err))

for i=1:D
    [cross_err_1(i),cross_mod_1,cross_errT_1(i)] = polyreg(xTr,yTr,i,xTe,yTe);
    [cross_err_2(i),cross_mod_2,cross_errT_2(i)] = polyreg(xTe,yTe,i,xTr,yTr);
end

average_errT=zeros(D,1);
average_err=zeros(D,1);

for i=1:D
    average_err(i)=(cross_err_1(i)+cross_err_2(i))/2;
    average_errT(i)=(cross_errT_1(i)+cross_errT_2(i))/2;
end


best_d=find(average_err==min(average_err))

polyreg(x,y,best_d)

figure(7)
plot((1:50),average_err,(1:50),average_errT)
title('Training and Data error')
xlabel('Degree of Polymomial')
ylabel('Error')
legend('Train Data', 'Test Data')