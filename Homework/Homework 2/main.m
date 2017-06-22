y0 = 2;
r = 0.2;
a = 1;
b = 2;

f = @(t, y) 1 + y / t;
y = @(t) t .* log(t) + 2 * t;
H = [0.2; 0.1; 0.05];
H2 = H .^ 2;

%%% Taylor's method %%%
fprintf('Taylor''s method:\n\n')

dfdt = @(t, y) - y / t^2;
dfdy = @(t, y) 1 / t;
%e = @(t, h) h * M * (exp(L * (t - a)) - 1) / (2 * L);

%%% Step size 0.2
h = 0.2;
[T, W] = taylor2(f, dfdt, dfdy, a, b, h, y0);

% Compute exact solution
Y = y(T);
fprintf('step size: h = %f\n', h);
lastIdx = length(T);
E02 = abs(W(lastIdx) - Y(lastIdx));
fprintf('Error at t = 2: %f, smaller than 10^-4?: %d\n', E02, E02 < 10^(-3));


figure
plot(T, W, 'b')
hold on
plot(T, Y, 'r')
legend('Taylor''s method', 'Exact solution')
title('Taylor''s method vs Exact solution, h = 0.2')
xlabel('t')
ylabel('y(t)')

%%% Step size 0.1
h = 0.1;
[T, W] = taylor2(f, dfdt, dfdy, a, b, h, y0);

% Compute exact solution
Y = y(T);
fprintf('step size: h = %f\n', h);
lastIdx = length(T);
E01 = abs(W(lastIdx) - Y(lastIdx));
fprintf('Error at t = 2: %f, smaller than 10^-4?: %d\n', E01, E01 < 10^(-3));

figure
plot(T, W, 'b')
hold on
plot(T, Y, 'r')
legend('Taylor''s method', 'Exact solution')
title('Taylor''s method vs Exact solution, h = 0.1')
xlabel('t')
ylabel('y(t)')


%%% Step size 0.05
h = 0.05;
tic;
[T, W] = taylor2(f, dfdt, dfdy, a, b, h, y0);
Tt = toc;

% Compute exact solution
Y = y(T);

fprintf('step size: h = %f\n', h);
lastIdx = length(T);
E005 = abs(W(lastIdx) - Y(lastIdx));
fprintf('Error at t = 2: %f, smaller than 10^-4?: %d\n', E005, E005 < 10^(-3));


figure
plot(T, W, 'b')
hold on
plot(T, Y, 'r')
legend('Taylor''s method', 'Exact solution')
title('Taylor''s method vs Exact solution, h = 0.05')
xlabel('t')
ylabel('y(t)')

% Linear regression to estimate error
Et = [E02; E01; E005];
bRegress = H2 \ Et;
figure
scatter(H2, Et);
hold on
plot(H2, bRegress * H2)
xlabel('step size h^2')
ylabel('error')
title('taylor''s method error vs step size h^2')
grid on

%%% Midpoint method %%%
fprintf('Midpoint method:\n\n')

%e = @(t, h) h * M * (exp(L * (t - a)) - 1) / (2 * L);

%%% Step size 0.2
h = 0.2;
[T, W] = midpt(f, a, b, h, y0);

% Compute exact solution
Y = y(T);

fprintf('step size: h = %f\n', h);
lastIdx = length(T);
E02 = abs(W(lastIdx) - Y(lastIdx));
fprintf('Error at t = 2: %f, smaller than 10^-4?: %d\n', E02, E02 < 10^(-3));


figure
plot(T, W, 'b')
hold on
plot(T, Y, 'r')
legend('Midpoint method', 'Exact solution')
title('Midpoint method vs Exact solution, h = 0.2')
xlabel('t')
ylabel('y(t)')

%%% Step size 0.1
h = 0.1;
[T, W] = midpt(f, a, b, h, y0);

% Compute exact solution
Y = y(T);

fprintf('step size: h = %f\n', h);
lastIdx = length(T);
E01 = abs(W(lastIdx) - Y(lastIdx));
fprintf('Error at t = 2: %f, smaller than 10^-4?: %d\n', E01, E01 < 10^(-3));


figure
plot(T, W, 'b')
hold on
plot(T, Y, 'r')
legend('Midpoint method', 'Exact solution')
title('Midpoint method vs Exact solution, h = 0.1')
xlabel('t')
ylabel('y(t)')


%%% Step size 0.05
h = 0.05;
tic;
[T, W] = midpt(f, a, b, h, y0);
Tm = toc;

% Compute exact solution
Y = y(T);

fprintf('step size: h = %f\n', h);
lastIdx = length(T);
E005 = abs(W(lastIdx) - Y(lastIdx));
fprintf('Error at t = 2: %f, smaller than 10^-4?: %d\n', E005, E005 < 10^(-3));


figure
plot(T, W, 'b')
hold on
plot(T, Y, 'r')
legend('Midpoint method', 'Exact solution')
title('Midpoint method vs Exact solution, h = 0.05')
xlabel('t')
ylabel('y(t)')

% Linear regression to estimate error
Em = [E02; E01; E005];
bRegress = H2 \ Em;
figure
scatter(H2, Em);
hold on
plot(H2, bRegress * H2)
xlabel('step size h^2')
ylabel('error')
title('midpoint method error vs step size h^2')
grid on

fprintf('Step size h = 0.05. Time for taylor: %f; for midpoint: %f\n', Tt, Tm);