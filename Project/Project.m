clear
clc
clf
close all

global theta1
global theta2
global theta3
global theta4
global theta5
global theta6

theta1 = -0.018;
theta2 = 0.015;
theta3 = -0.062;
theta4 = 0.009;
theta5 = 0.021;
theta6 = 0.75;


% Set the integration interval and the initial conditions.
tspan = [0, 100];
init_cond = [0.0001 : 0.001: 0.01; 0.01 : -0.001 : 0.0001];
%{
for i = 1:size(init_cond, 2)
    [t, y] = ode45(@odefun_open_loop, tspan, init_cond(:, i));
    plot(y(:, 1), y(:, 2))
    title("Phase Portrait")
    xlabel('x_1 = p')
    ylabel('x_2 = \phi')
    set(get(gca,'ylabel'),'rotation',0)
    hold on
    plot(init_cond(1, i), init_cond(2, i), 'blacko')
end

 plot(0, 0, 'r*')
%}


for i = -3*(pi/180) : 1.5*(pi/180) : 3*(pi/180)
    for j = -3*(pi/180) : 1.5*(pi/180) : 3*(pi/180)
        [t, y] = ode45(@odefun_open_loop, tspan, [i, j]);
        plot(y(:, 1), y(:, 2))
        title("Phase Portrait")
        xlabel('x_1 = p')
        ylabel('x_2 = \phi')
        set(get(gca,'ylabel'),'rotation',0)
        hold on
        plot(i, j, 'blacko')
    end
end

 plot(0, 0, 'r*')

% Find if there is a limit cycle.
% Set the integration interval and the initial conditions.

%{
tspan = [0, 1000];
figure

for i = -pi : pi/10 : pi
    for j = -pi : pi/10 : pi
        [t, y] = ode45(@odefun_open_loop, tspan, [i, j]);
        plot(y(:, 1), y(:, 2))
        title("Limit Cycle")
        xlabel('x_1')
        ylabel('x_2')
        hold on
        plot(i, j, 'blacko')
        set(get(gca,'ylabel'), 'rotation', 0)
    end
end

xlim([-2*pi 2*pi])
ylim([-2*pi 2*pi])
%}

%   Closed Loop System.

%{
init = zeros(10, 1);
tspan = [0 140];
flag = true;

[t, y] = ode23(@odefun, tspan, init);

% Calculate r and u with t vector returned from ode.
Theta = [theta3/theta6; theta4/theta6; theta5/theta6];

r = zeros(length(t), 1);
u = zeros(length(t), 1);
Phi = zeros(length(t), 1);

for i = 1: length(t)
   
    r(i) = input_sys(t(i), flag);
    
    Phi = [abs(y(i, 2))*y(i, 1); abs(y(i, 1))*y(i, 1); (y(i, 2))^3];
    u(i) = -[y(i, 5), y(i, 6)]*[y(i, 1); y(i, 2)] + y(i, 7)*r(i) - [y(i, 8), y(i, 9), y(i, 10)]* Phi;
    
end

% Figure of phi --> x2.
figure(1)
subplot(3, 1, 1)

plot(t, y(:, 2))
title("Time response of \phi")
xlabel('t')
ylabel('\phi')
set(get(gca,'ylabel'), 'rotation', 0, 'FontWeight', 'bold')
set(get(gca, 'xlabel'), 'FontWeight', 'bold')

% Figure of r.
subplot(3, 1, 2)

plot(t, r)
title("Time response of r")
xlabel('t')
ylabel('r')
set(get(gca,'ylabel'), 'rotation', 0, 'FontWeight', 'bold')
set(get(gca, 'xlabel'), 'FontWeight', 'bold')

% Figure of phi_ref --> x2_ref.
subplot(3, 1, 3)

plot(t, y(:, 4))
title("Time response of \phi_{ref}")
xlabel('t')
ylabel('\phi_{ref}')
set(get(gca,'ylabel'), 'rotation', 0, 'FontWeight', 'bold')
set(get(gca, 'xlabel'), 'FontWeight', 'bold')

% Figure of p --> x1.
figure(2)
subplot(2, 1, 1)

plot(t, y(:, 1))
title("Time response of p")
xlabel('t')
ylabel('p')
set(get(gca,'ylabel'), 'rotation', 0, 'FontWeight', 'bold')
set(get(gca, 'xlabel'), 'FontWeight', 'bold')

% Figure of p_ref --> x1_ref.
subplot(2, 1, 2)

plot(t, y(:, 3))
title("Time response of p_{ref}")
xlabel('t')
ylabel('p_{ref}')
set(get(gca,'ylabel'), 'rotation', 0, 'FontWeight', 'bold')
set(get(gca, 'xlabel'), 'FontWeight', 'bold')

% Figure of observation error e.
% Observation Error, e = [x1 - x1_ref, x2 - x2_ref].
e = [y(:, 1) - y(:, 3), y(:, 2) - y(:, 4)];

figure(3)
horiz_line = 0;
subplot(2, 1, 1)

plot(t, e(:, 1))
hold on
line(tspan, [horiz_line, horiz_line], 'LineStyle', '--', 'Color', 'r')

title("Observation Error of p")
xlabel('t')
ylabel('e_p')
set(get(gca,'ylabel'), 'rotation', 0, 'FontWeight', 'bold')
set(get(gca, 'xlabel'), 'FontWeight', 'bold')

subplot(2, 1, 2)

plot(t, e(:, 2))
hold on
line(tspan, [horiz_line, horiz_line], 'LineStyle', '--', 'Color', 'r')

title("Observation Error of \phi")
xlabel('t')
ylabel('e_\phi')
set(get(gca,'ylabel'), 'rotation', 0, 'FontWeight', 'bold')
set(get(gca, 'xlabel'), 'FontWeight', 'bold')


% Figure of controller u.
figure(4)

plot(t, u)
title("Time response of u")
xlabel('t')
ylabel('u')
set(get(gca,'ylabel'), 'rotation', 0, 'FontWeight', 'bold')
set(get(gca, 'xlabel'), 'FontWeight', 'bold')

% Figure of K_bar, L_bar and Theta_bar
figure(5)
subplot(3, 1, 1)

plot(t, y(:, 8))
title('Time response of $\bar{K}$','Interpreter','Latex')
xlabel('t')
ylabel('$\bar{K}$','Interpreter','Latex')
set(get(gca,'ylabel'), 'rotation', 0, 'FontWeight', 'bold')
set(get(gca, 'xlabel'), 'FontWeight', 'bold')

subplot(3, 1, 2)

plot(t, y(:, 9))
title('Time response of $\bar{L}$','Interpreter','Latex')
xlabel('t')
ylabel('$\bar{L}$','Interpreter','Latex')
set(get(gca,'ylabel'), 'rotation', 0, 'FontWeight', 'bold')
set(get(gca, 'xlabel'), 'FontWeight', 'bold')

subplot(3, 1, 3)

plot(t, y(:, 10))
title('Time response of $\bar{\Theta}$','Interpreter','Latex')
xlabel('t')
ylabel('$\bar{\Theta}$','Interpreter','Latex')
set(get(gca,'ylabel'), 'rotation', 0, 'FontWeight', 'bold')
set(get(gca, 'xlabel'), 'FontWeight', 'bold')
%}
