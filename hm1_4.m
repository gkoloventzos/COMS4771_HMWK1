function [theta] = hm1_4(x,y,e,eta)
%
%function for logistic regresion
%x:2-d array
%y:1-d array
%e: tolerance
%eta: scalar step size
%
t=1;
theta_now=rand(size(x,2),1).*0.1;
theta_next = theta_now - eta.*logreg(x,y,theta_now);
%norm(theta_now - theta_next)
while norm(theta_next - theta_now) >= e
    theta_now=theta_next;
    [err, pred] = logreg(x,y,theta_now);
    %find how much error we have by finding if we classify correctly
    %If we tranverse y adn pred and find how many pred(i) == y(i)
    %then if we subtract from the size of y we have our error
    mis_clas(t) = length(y')-length(find(pred == y'));
    %empirical risk for each iteration p22, topic 3
    gX = 1./(1+exp(-x*theta_now));
    emp_risk(t) = ((y-1)'*log(1-gX)-y'*log(gX))/length(x);
    theta_next = theta_now - eta*err;
    t=t+1;
end
theta_next;
theta_now
t
figure(1)
plot_logistic_2d(x,y,theta_next,0.1,false)
figure(2)
semilogx([1:length(mis_clas)], mis_clas./length(x));
xlabel('# of iterations');
ylabel('Binary classification error');
least = mis_clas(length(mis_clas))
%figure(3)
%semilogx([1:length(emp_risk)], emp_risk);
%xlabel('# of iterations');
%ylabel('Emperical risk');
end

function plot_logistic_2d(x, y, thetas, delay, keep_all)
    hold all
    exs = x(find(y),:);
    circles = x(setdiff(1:length(y),find(y)),:);
    scatter(exs(:,1),exs(:,2),30,'x');
    scatter(circles(:,1),circles(:,2),30,'o');
    for k=1:size(thetas,2)
        if ~keep_all & exist('p','var')
            delete(p);
        end
        theta = thetas(:,k)
        % Only need 2 points to define a line, so choose two endpoints
        plot_x = [min(x(:,1)),  max(x(:,1))];
        % Calculate the decision boundary line
        plot_y = (-1./theta(2)).*(theta(1).*plot_x + theta(3));
        % Plot, and adjust axes for better viewing
        p = plot(plot_x, plot_y,'k-');
        if k==1
            % Legend, specific for the exercise
            legend('1', '0', 'Decision Boundary')
        end
    end
end