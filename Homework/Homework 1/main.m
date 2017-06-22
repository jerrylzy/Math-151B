y0 = 1000;
r = 0.2;
K = 4000;
a = 0;
b = 50;
M = 15;
L = 0.2;

f = @(t, y) r * (1 - y / K) * y;
y = @(t) (y0 * K) ./ (y0 + (K - y0) * exp(-r * t));
e = @(t, h) h * M * (exp(L * (t - a)) - 1) / (2 * L);

%%% Step size 10
h = 10;
N = (b - a) / h;

[T, W] = euler(f, a, b, N, y0);

% Compute exact solution
Y = y(T);
E10 = Y - W;
[maxErr, IdxMaxErr] = max(abs(E10));
E = e(T, h);
fprintf('step size: h = %f\n', h);
fprintf('Maximum error: %f, time is: %f, error bound: %f\n', maxErr, T(IdxMaxErr), E(IdxMaxErr));


figure
plot(T, W, 'b')
hold on
plot(T, Y, 'r')
legend('Euler''s method', 'Exact solution')
title('Euler''s method vs Exact solution, h = 10')
xlabel('t')
ylabel('y(t)')

%%% Step size 1
h = 1;
N = (b - a) / h;

[T, W] = euler(f, a, b, N, y0);

% Compute exact solution
Y = y(T);
E1 = Y - W;
[maxErr, IdxMaxErr] = max(abs(E1));
E = e(T, h);
fprintf('step size: h = %f\n', h);
fprintf('Maximum error: %f, time is: %f, error bound: %f\n', maxErr, T(IdxMaxErr), E(IdxMaxErr));


figure
plot(T, W, 'b')
hold on
plot(T, Y, 'r')
legend('Euler''s method', 'Exact solution')
title('Euler''s method vs Exact solution, h = 1')
xlabel('t')
ylabel('y(t)')

%%% Step size 0.1
h = 0.1;
N = (b - a) / h;

[T, W] = euler(f, a, b, N, y0);

% Compute exact solution
Y = y(T);

E01 = Y - W;
[maxErr, IdxMaxErr] = max(abs(E01));
E = e(T, h);
fprintf('step size: h = %f\n', h);
fprintf('Maximum error: %f, time is: %f, error bound: %f\n', maxErr, T(IdxMaxErr), E(IdxMaxErr));

figure
plot(T, W, 'b')
hold on
plot(T, Y, 'r')
legend('Euler''s method', 'Exact solution')
title('Euler''s method vs Exact solution, h = 0.1')
xlabel('t')
ylabel('y(t)')
