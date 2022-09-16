% x(1) --> p and x(2) --> phi
function dVode = odefun(t, Vode)

x = [Vode(1); Vode(2)];
x_ref = [Vode(3); Vode(4)];
K_est = [Vode(5), Vode(6)];
L_est = Vode(7);
Theta_est = [Vode(8), Vode(9), Vode(10)];

% Set the parameters.
global theta1
global theta2
global theta3
global theta4
global theta5
global theta6

% System.
A = [theta2 theta1; 1 0];
B = [1; 0];
Lambda = theta6;
Theta = [theta3/theta6; theta4/theta6; theta5/theta6];
Phi = [abs(x(2))*x(1); abs(x(1))*x(1); (x(2))^3];

% Reference Model.
A_ref = [-1.4 1; -1 0];
B_ref = [1; 0];

% Input.
flag = true;
r = input_sys(t, flag);

% Control input.
u = -K_est*x + L_est*r - Theta_est*Phi;

% Observation Error.
e = x - x_ref;

% Calculate matrix P, solution of Lyapunov's equation.
Q = [1 0; 0 1];
P = lyap(A_ref, Q);

dVode = zeros(size(Vode, 1), 1);

% System.
dVode(1:2) = A*x + B*Lambda*(Theta'*Phi + u);

% Reference Model.
dVode(3:4) = A_ref*x_ref + B_ref*r;

% K_est dot.
dVode(5:6) = B'*P*e*x';

% L_est dot.
dVode(7) = -B'*P*e*r';

% Theta_est dot.
dVode(8:10) = B'*P*e*Phi';

end
