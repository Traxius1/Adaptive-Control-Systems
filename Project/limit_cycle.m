% Find if there is a limit cycle.
% Set the integration interval.
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