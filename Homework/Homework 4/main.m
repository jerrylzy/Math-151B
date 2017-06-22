F = @(X) [
    15 * X(1) + X(2)^2 - 4 * X(3) - 13;
    X(1)^2 + 10 * X(2) - X(3) - 11;
    X(2)^3 - 25 * X(3) + 22];
J = @(X) [
    15, 2 * X(2), -4;
    2 * X(1), 10, -1;
    0, 3 * X(2)^2, -25
];


format long

N = 1000;
X0 = [0; 0; 0];
TOL = 1e-6;
realX = fsolve(F, X0);
tic
[X, I] = Newton(F, J, X0, TOL, N);
toc
X
I
E = norm(X - realX, Inf)

g = @(X) F(X)' * F(X);
gradG = @(X) 2 * J(X)' * F(X);
tic
[X, I] = steep(g, gradG, X0, TOL, N);
toc
X
I
E = norm(X - realX, Inf)

N = [10; 20; 50];
for i = 1 : length(N)
    fprintf('N = %d, time is: ', N(i))
    tic
    X = homotopy(F, J, X0, N(i), "rk4");
    toc
    X
    E = norm(X - realX, Inf)
end

N = [10; 20; 50];
for i = 1 : length(N)
    fprintf('N = %d, time is: ', N(i))
    tic
    X = homotopy(F, J, X0, N(i), "midpoint");
    toc
    X
    E = norm(X - realX, Inf)
end