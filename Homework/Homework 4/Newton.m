function [R, I] = Newton(F, J, X0, TOL, N)
    G = @(X) inv(J(X)) * F(X);

    X = zeros(length(X0), N + 1);
    I = N + 1;
    for i = 1 : N
        y = - G(X(:, i));
        X(:, i + 1) = X(:, i) + y;
        if norm(y, Inf) < TOL
            disp('The procedure was successful')
            I = i + 1;
            break;
        end
    end
    R = X(:, I);
end