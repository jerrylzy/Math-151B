function [T, W] = ms(f, a, b, h, y0)
    %     This function approximates soln of IVP
    %     y' = f(t, y), a <= t <= b, y(a) = y0
    %     at (N + 1) equally spaced numbers in the interval [a, b]
    %     
    %     Input: function f, end points a, b; h step size; 
    %     initial condition y0
    %     Output: approximation w to y at the (N + 1) values of t (b)
    
    
    N = (b - a) / h;
    T = a + h * (0 : N)';
    W = zeros((N + 1), 1);
    W(1) = y0;
    
    for i = 1 : 3
        k1 = h * f(T(i), W(i));
        k2 = h * f(T(i) + h / 2, W(i) + k1 / 2);
        k3 = h * f(T(i) + h / 2, W(i) + k2 / 2);
        k4 = h * f(T(i) + h, W(i) + k3);
        W(i + 1) = W(i) + (k1 + 2 * k2 + 2 * k3 + k4) / 6;
    end
    
    for i = 4 : N
        w = W(i-3) + 4 * h / 3 * (2 * f(T(i), W(i)) - f(T(i-1), W(i-1)) + ...
            2 * f(T(i-2), W(i-2)));
        W(i+1) = W(i-1) + h / 3 * (f(T(i+1), w) + 4 * f(T(i), W(i)) + ...
            f(T(i-1), W(i-1)));
    end
end
