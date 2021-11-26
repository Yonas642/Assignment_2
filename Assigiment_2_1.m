 
% x = [phi_2; d];
a = 0.1;
b = 0.2;
phi = deg2rad(30);

% set a reasonable starting point
x0 = [0; b + a];

% create function handles
F = @(x) constraint(x, a, b, phi);
J = @(x) jacobian(x, b);

eps = 1e-9;
[x, iteration_counter] = NR_method(F, J, x0, eps);

fprintf('\n\tMechanism valid position is for d = %.3g m and theta = %g deg\n\n', ...
    x(2), rad2deg(x(1)));

function f = constraint(x, a, b, phi)
theta = x(1);
d = x(2);
f = [a * cos(phi) + b * cos(theta) - d
    a * sin(phi) - b * sin(theta) ];
end

function f = jacobian(x, b)
theta = x(1);
f = [-b * sin(theta), -1
    -b * cos(theta), 0];
end
