function [T, W] = euler(f, a, b, N, alpha)
    %     This function approximates soln of IVP
    %     y' = f(t, y), a <= t <= b, y(a) = alpha
    %     at (N + 1) equally spaced numbers in the interval [a, b]
    %     
    %     Input: function f, end points a, b; N intervals; 
    %     initial condition alpha
    %     Output: approximation w to y at the (N + 1) values of t (b)
    
    
    h = (b - a) / N;
    T = a + h * (0 : N)';
    W = zeros((N + 1), 1);
    W(1) = alpha;
    
    for i = 1 : N
        W(i + 1) = W(i) + h * f(T(i), W(i));
    end
end
    
    
    
    
    
    
    
    
    
    