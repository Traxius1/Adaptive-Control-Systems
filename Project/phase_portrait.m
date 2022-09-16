clc
clear

% Set the integration interval and the initial conditions.
tspan = [0, 100];
init_cond = [0.0001 : 0.001: 0.01; 0.01 : -0.001 : 0.0001];

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