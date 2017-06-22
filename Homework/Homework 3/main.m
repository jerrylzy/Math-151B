y0 = 1 / 3;
a = 0;
b = 1;

f = @(t, y) -20 * y + 20 * t .^ 2 + 2 * t;
y = @(t) t .^ 2 + 1 / 3 * exp(-20 * t);
H = [0.2; 0.125; 0.1; 0.02];

% Due to requirement I can't factor out the repeated code below.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                        %
%                            Euler's method                              %
%                                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('Euler''s method\n\n')
figure
for i = 1 : length(H)
    [T, W] = euler(f, a, b, H(i), y0);
    % Compute exact solution
    Y = y(T);
    fprintf('step size: h = %f\n', H(i))
    
    [E, I] = max(abs(W - Y));
    fprintf('Maximum error at t = %f: %f\n', T(I), E)
    
    subplot(2, 2, i)
    plot(T, W, 'b')
    hold on
    fplot(y, [a b], 'r')
    legend('Euler''s method', 'Exact solution')
    titleString = sprintf('Euler''s method vs Exact solution, h = %f', H(i));
    title(titleString)
    xlabel('t')
    ylabel('y(t)')
end
fprintf('\n')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                        %
%                      Runge-Kutta method order 4                        %
%                                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('Runge-Kutta method of order 4\n\n')
figure
for i = 1 : length(H)
    [T, W] = rk4(f, a, b, H(i), y0);
    % Compute exact solution
    Y = y(T);
    fprintf('step size: h = %f\n', H(i))
    
    [E, I] = max(abs(W - Y));
    fprintf('Maximum error at t = %f: %f\n', T(I), E)
    
    subplot(2, 2, i)
    plot(T, W, 'b')
    hold on
    fplot(y, [a b], 'r')
    legend('Runge-Kutta method order 4', 'Exact solution')
    titleString = ...
        sprintf('Runge-Kutta method order 4 vs Exact solution, h = %f', H(i));
    title(titleString)
    xlabel('t')
    ylabel('y(t)')
end
fprintf('\n')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                        %
%               Adams 4th order predictor-corrector method               %
%                                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('Adams 4th order predictor-corrector method\n\n')
figure
for i = 1 : length(H)
    [T, W] = abm4(f, a, b, H(i), y0);
    % Compute exact solution
    Y = y(T);
    fprintf('step size: h = %f\n', H(i))
    
    [E, I] = max(abs(W - Y));
    fprintf('Maximum error at t = %f: %f\n', T(I), E)
    
    subplot(2, 2, i)
    plot(T, W, 'b')
    hold on
    fplot(y, [a b], 'r')
    legend('Adams 4th order predictor-corrector', 'Exact solution')
    titleString = ...
        sprintf('Adams 4th order predictor-corrector vs Exact solution, h = %f', H(i));
    title(titleString)
    xlabel('t')
    ylabel('y(t)')
end
fprintf('\n')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                        %
%                Milne-Simpson predictor-corrector method                %
%                                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('Milne-Simpson predictor-corrector method\n\n')
figure
for i = 1 : length(H)
    [T, W] = ms(f, a, b, H(i), y0);
    % Compute exact solution
    Y = y(T);
    fprintf('step size: h = %f\n', H(i))
    
    [E, I] = max(abs(W - Y));
    fprintf('Maximum error at t = %f: %f\n', T(I), E)
    
    subplot(2, 2, i)
    plot(T, W, 'b')
    hold on
    fplot(y, [a b], 'r')
    legend('Milne-Simpson predictor-corrector', 'Exact solution')
    titleString = ...
        sprintf('Milne-Simpson predictor-corrector vs Exact solution, h = %f', H(i));
    title(titleString)
    xlabel('t')
    ylabel('y(t)')
end
