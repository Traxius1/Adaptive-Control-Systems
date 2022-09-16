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

% Closed Loop System.

% Set the integration interval and the initial conditions.
init = zeros(10, 1);
tspan = [0 140];

% flag changes the expression of the reference input.
flag = true;

[t, y] = ode23(@odefun, tspan, init);

% Calculate r and u, using time vector returned from ode.
Theta = [theta3/theta6; theta4/theta6; theta5/theta6];

r = zeros(length(t), 1);
u = zeros(length(t), 1);
Phi = zeros(length(t), 1);

x = y(:, 1:2);
x_ref = y(:, 3:4);
K = y(:, 5:6);
L = y(:, 7);
Theta_est = y(:, 8:10);

for i = 1 : length(t)
   
    r(i) = input_sys(t(i), flag);
    
    Phi = [abs(x(i, 2))*x(i, 1); abs(x(i, 1))*x(i, 1); (x(i, 2))^3];
    u(i) = -K(i, :) * x(i, :)' + L(i) * r(i) - Theta_est(i, :) * Phi;
    
end

%% Figure of phi --> x2.
figure(1)
subplot(3, 1, 1)

plot(t, x(:, 2))
title("Time response of \phi")
xlabel('t')
ylabel('\phi')
set(get(gca,'ylabel'), 'rotation', 0, 'FontWeight', 'bold')
set(get(gca, 'xlabel'), 'FontWeight', 'bold')

%% Figure of r.
subplot(3, 1, 2)

plot(t, r)
title("Time response of r")
xlabel('t')
ylabel('r')
set(get(gca,'ylabel'), 'rotation', 0, 'FontWeight', 'bold')
set(get(gca, 'xlabel'), 'FontWeight', 'bold')

%% Figure of phi_ref --> x2_ref.
subplot(3, 1, 3)

plot(t, x_ref(:, 2))
title("Time response of \phi_{ref}")
xlabel('t')
ylabel('\phi_{ref}')
set(get(gca,'ylabel'), 'rotation', 0, 'FontWeight', 'bold')
set(get(gca, 'xlabel'), 'FontWeight', 'bold')

%% Figure of p --> x1.
figure(2)
subplot(2, 1, 1)

plot(t, x(:, 1))
title("Time response of p")
xlabel('t')
ylabel('p')
set(get(gca,'ylabel'), 'rotation', 0, 'FontWeight', 'bold')
set(get(gca, 'xlabel'), 'FontWeight', 'bold')

%% Figure of p_ref --> x1_ref.
subplot(2, 1, 2)

plot(t, x_ref(:, 2))
title("Time response of p_{ref}")
xlabel('t')
ylabel('p_{ref}')
set(get(gca,'ylabel'), 'rotation', 0, 'FontWeight', 'bold')
set(get(gca, 'xlabel'), 'FontWeight', 'bold')

%% Figure of observation error e.
% Observation Error, e = [x1 - x1_ref, x2 - x2_ref].
e = [x(:, 1) - x_ref(:, 1), x(:, 2) - x_ref(:, 2)];

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


%% Figure of controller u.
figure(4)

plot(t, u)
title("Time response of u")
xlabel('t')
ylabel('u')
set(get(gca,'ylabel'), 'rotation', 0, 'FontWeight', 'bold')
set(get(gca, 'xlabel'), 'FontWeight', 'bold')

%% Figure of K_bar, L_bar and Theta_bar
figure(5)
subplot(3, 1, 1)

plot(t, K)
title('Time response of $\bar{K}$','Interpreter','Latex')
xlabel('t')
ylabel('$\bar{K}$','Interpreter','Latex')
set(get(gca,'ylabel'), 'rotation', 0, 'FontWeight', 'bold')
set(get(gca, 'xlabel'), 'FontWeight', 'bold')

subplot(3, 1, 2)

plot(t, L)
title('Time response of $\bar{L}$','Interpreter','Latex')
xlabel('t')
ylabel('$\bar{L}$','Interpreter','Latex')
set(get(gca,'ylabel'), 'rotation', 0, 'FontWeight', 'bold')
set(get(gca, 'xlabel'), 'FontWeight', 'bold')

subplot(3, 1, 3)

plot(t, Theta_est)
title('Time response of $\bar{\Theta}$','Interpreter','Latex')
xlabel('t')
ylabel('$\bar{\Theta}$','Interpreter','Latex')
set(get(gca,'ylabel'), 'rotation', 0, 'FontWeight', 'bold')
set(get(gca, 'xlabel'), 'FontWeight', 'bold')
