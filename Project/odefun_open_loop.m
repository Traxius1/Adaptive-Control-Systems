function dxdt = odefun_open_loop(t, x)

% Set the parameters.
global theta1
global theta2
global theta3
global theta4
global theta5

dxdt = zeros(2, 1);
dxdt(1) = theta1*x(2) + theta2*x(1) + (theta3*abs(x(2)) + theta4*abs(x(1)))*x(1) + theta5*(x(2))^3;
dxdt(2) = x(1);