function [X, I] = steep(g, z, X0, TOL, N)
    
    Xk = X0;
    for i = 1 : N
        G1 = g(Xk);
        Z1 = z(Xk);
        Z0 = norm(Z1)^2;
        if Z0 == 0
            disp('Zero gradient')
            X = Xk;
            I = i - 1;
            return;
        end
        Z = Z1 / Z0;
        alpha1 = 0;
        alpha3 = 1;
        G3 = g(Xk - alpha3 * Z);
        while (G3 >= G1)
           alpha3 = alpha3 / 2;
           G3 = g(Xk - alpha3 * Z);
           if (alpha3 < TOL / 2)
               disp('No likely improvement')
               X = Xk;
               I = i;
               return;
           end
        end
        alpha2 = alpha3 / 2;
        G2 = g(Xk - alpha2 * Z);
        
        h1 = (G2 - G1) / alpha2;
        h2 = (G3 - G2) / (alpha3 - alpha2);
        h3 = (h2 - h1) / alpha3;
        
        alpha0 = 0.5 * (alpha2 - h1 / h3);
        G0 = g(Xk - alpha0 * Z);
        G = [G0; G3];
        A = [alpha0; alpha3];
        [gMin, iMin] = min(G);
        alpha = A(iMin);
        Xk = Xk - alpha * Z;
        
        if abs(gMin - G1) < TOL
            disp('The procedure was successful');
            X = Xk;
            I = i;
            return;
        end
    end
    X = Xk;
    I = N;
end