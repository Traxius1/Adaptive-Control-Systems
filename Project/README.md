### Given the system:

$\dot{\varphi} = p$

$\dot{p} = \vartheta_1\varphi + \vartheta_2p + (\vartheta_3|\varphi| + \vartheta_4|p|)p + \vartheta_5\varphi^3 + \vartheta_6u$

Show that:
1. (0, 0) is an unstable equilibrium point of the open loop system.
2. There is a limit cycle for the open loop system. Decide on the stability of limit cycle.
3. Design an adaptive controller that makes all closed loop signals bounded and the closed loop system behaves like the reference model:
$$\varphi_{ref}(s) = \frac{1}{s^2 + 1.4s + 1}r(s)$$
4. Simulate the response of the closed loop system for different reference inputs.

## phase_portrait.m
Plots a phase portrait which show that (0, 0) is unstable, for a couple of initial conditions.

## limit_cycle.m
Plots a $p-\varphi$ graph which shows that there is a semi-stable limit cycle.

## odefun_open_loop.m
Contains the differential equations of the open loop system.

## odefun.m
Contains the differential equations of the closed loop system, reference model and $K, L, \Theta$ estimators.

## input_sys.m
Calculates the reference input.

## closed_loop.m
Uses ode23 solver to simulate the closed loop system. In addition, plots a variety of graphs.
