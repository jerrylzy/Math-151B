function [T, W] = taylor2(f, dfdt, dfdy, a, b, h, alpha)
    %     This function approximates soln of IVP
    %     y' = f(t, y), a <= t <= b, y(a) = alpha
    %     at (N + 1) equally spaced numbers in the interval [a, b]
    %     
    %     Input: function f, end points a, b; h step size; 
    %     initial condition alpha
    %     Output: approximation w to y at the (N + 1) values of t (b)
    
    
    N = (b - a) / h;
    T = a + h * (0 : N)';
    W = zeros((N + 1), 1);
    W(1) = alpha;
    
    for i = 1 : N
        W(i + 1) = W(i) + h * (f(T(i), W(i)) + h * (dfdt(T(i), W(i)) + ...
                               dfdy(T(i), W(i)) * f(T(i), W(i))) / 2);
    end
end
