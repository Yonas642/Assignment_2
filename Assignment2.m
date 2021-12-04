% x = [theta_dot; d_dot];
a = 0.1;
b = 0.2;
w = 1;
d  = 0.28;
phi = -1;
phi_1 = deg2rad(30);
t=linspace(0,1,101);
phi = -1;
theta  = deg2rad(14.4775);

phi_2 = (pi/6)+w*t;

% set a reasonable starting point
x0 = [0; b + a];

% create function handles
F = @(x) constraint(a, b, phi_1,d,theta);
Jt = @(x,t) jacobian(x,a,b,theta,phi_1,phi);

eps = 1e-9;
[x, iteration_counter] = NR_method(F,J, x0, eps);

fprintf('\n\tMechanism valid position is for d_dot = %.3g m and theta_dot = %g deg\n\n', ...
    x(2), rad2deg(x(1)));

function f = constraint(a, b, phi_1,d,theta)

f = [a * cos(phi_1) + b * cos(theta) - d
    a * sin(phi_1) - b * sin(theta) ];
end

function f = jacobian(x,a,b,theta,phi_2,phi)
theta_dot = x(1);
d_dot = x(2);

f = [-a *phi*sin(phi_2), -b*theta_dot*sin(theta), -d_dot
    a *phi*cos(phi_2), -b*theta_dot*cos(theta), 0];
for t = t +dt,t < t(n)
    f(x,t) = [-a *phi_dot*sin(phi_1), -b*theta_dot*sin(theta), -d_dot
    a *phi_dot*cos(phi_1), -b*theta_dot*cos(theta), 0];
    
    x0 = x + dt*x
end

end  
