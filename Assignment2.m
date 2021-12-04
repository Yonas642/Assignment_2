
clc
close all
a = 0.1;
b = 0.2;
w=-1;
t = linspace(0,1,101) % loop for t 
phi = pi/6+w*t;
y0 = [0; b + a];       % set a reasonable starting point
J = @(y) jacobian(y, b);
eps = 1e-9;
 Y=[];  %array

% create function handles

for i=1:length(phi)
    
F = @(y) constraint(y, a, b, phi(i));
x = NR_method(F, J, y0, eps)
Y=[Y x];
end

theta=(Y(1,:));
d=Y(2,:);
figure  
plot(t, d,'r-')
title('Displacement vs time');
xlabel('Time - t (s)')
ylabel('Displacement (d) (m) ')

figure 
plot(t, rad2deg(theta),'m-.')
title('Theta vs time');
xlabel('Time t (s)')
ylabel('Theta (\theta) (\circ) ')

g = gradient(theta)./gradient(t) ;   

% time derivative of angle theta 
figure
plot(t,g,'r-');
title('Angular velocity vs time');
xlabel('Time t (s)')
ylabel('Angular velocity $\dot{d}$ (rad/s)', 'Interpreter','latex')
g = gradient(d)./gradient(t) ;  

% time derivative of displacement 
figure 
plot(t,g,'m-.');
title('Velocity vs time');
xlabel('Time-t (s)')
ylabel('Velocity $\dot{d}$ (m/s)')
   
function P = constraint(y, a, b, phi)  % constraints

theta = y(1);
d = y(2);
P = [a * cos(phi) + b * cos(theta) - d;
    a * sin(phi) - b * sin(theta)];
end

function P = jacobian(y, b)   % Jacobian matrix
theta = y(1);
P = [-b * sin(theta), -1
    -b * cos(theta), 0];
end