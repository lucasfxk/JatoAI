menor_dist(_, _, [], Xf, Yf, _, Xf, Yf).

menor_dist(X1, Y1, ADVERSARIOS, Xi, Yi, D, Xf, Yf) :-
    [[A, B] | Resto] = ADVERSARIOS,
    Dtemp is ((X1 - A) ** 2 + (Y1 - B) ** 2) ** 0.5,
    Dtemp < D, %Caso MELHOR
    menor_dist(X1, Y1, Resto, A, B, Dtemp, Xf, Yf). 

menor_dist(X1, Y1, ADVERSARIOS, Xi, Yi, D, Xf, Yf) :-
    [[A, B] | Resto] = ADVERSARIOS,
    Dtemp is ((X1 - A) ** 2 + (Y1 - B) ** 2) ** 0.5,
    Dtemp >= D, %Caso PIOR
    menor_dist(X1, Y1, Resto, Xi, Yi, D, Xf, Yf). 

coordenada_proxima(X1, Y1, ADVERSARIOS, Xf, Yf):-
    [[A, B] | Resto] = ADVERSARIOS,
    D is ((X1 - A) ** 2 + (Y1 - B) ** 2) ** 0.5,
    menor_dist(X1, Y1, Resto, A, B, D, Xf, Yf).


