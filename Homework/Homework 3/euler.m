function [T, W] = euler(f, a, b, h, y0)
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
    
    for i = 1 : N
        W(i + 1) = W(i) + h * f(T(i), W(i));
    end
end
