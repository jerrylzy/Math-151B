function [X] = homotopy(F, J, X0, N, type)
    if (type == "midpoint")
        %F0 = F(X0);
        %Phi = @(X) - inv(J(X)) * F0;
        h = 1 / N;
        b = - h * F(X0);
        W = zeros(length(X0), N + 1);
        for i = 1 : N + 1
            k1 = J(W(:, i)) \ b;
            k2 = J(W(:, i) + k1 / 2) \ b;
            W(:, i + 1) = W(:, i) + k2;
        end
        X = W(:, N + 1);
    else
        h = 1 / N;
        W = zeros(length(X0), N + 1);
        b = - h * F(X0);
        for i = 1 : N + 1
            k1 = J(W(:, i)) \ b;
            k2 = J(W(:, i) + k1 / 2) \ b;
            k3 = J(W(:, i) + k2 / 2) \ b;
            k4 = J(W(:, i) + k3) \ b;
            W(:, i + 1) = W(:, i) + ...
                (k1 + 2 * k2 + 2 * k3 + k4) / 6;
        end
        X = W(:, N + 1);
    end
end
