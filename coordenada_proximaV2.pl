dec(X,Y):-
    X >= 0,
    X < 1, !,
    Y is X.
dec(X,Y):-
    X >= 1,
    Xi is X - 1, !,
    dec(Xi, Y).
dec(X,Y):-
    X < 0,
    X > -1, !,
    Y is X.
dec(X,Y):-
    X < 0,
    Xi is X + 1,
    dec(Xi, Y).

arredonda(X,Y):-
    X >= 0,
    dec(X,D),
    D < 0.5,
    Y is X - D.
arredonda(X,Y):-
    X >= 0,
    dec(X,D),
    D >= 0.5,
    Y is (X + 1) - D.
arredonda(X,Y):-
    X < 0,
    dec(X,D),
    D > -0.5,
    Y is X - D.
arredonda(X,Y):-
    X < 0,
    dec(X,D),
    D =< -0.5,
    Y is (X - 1) - D.

menor_dist(_, _, [], Xf, Yf, _, Xf, Yf).

menor_dist(X1, Y1, ADVERSARIOS, _, _, D, Xf, Yf) :-
    [[A, B] | Resto] = ADVERSARIOS,
    XD is A - X1,
    YD is B - Y1,
    
    arredonda(XD / 1024, Xarr),
    arredonda(YD / 768, Yarr),
    
    Xd is XD - (1024 * Xarr),
    Yd is YD - (768 * Yarr),
    
    Dtemp is (Xd ** 2 + Yd ** 2) ** 0.5,
    Dtemp < D, %Caso MELHOR
    menor_dist(X1, Y1, Resto, A, B, Dtemp, Xf, Yf). 

menor_dist(X1, Y1, ADVERSARIOS, Xi, Yi, D, Xf, Yf) :-
    [[A, B] | Resto] = ADVERSARIOS,
    XD is A - X1,
    YD is B - Y1,
    
    arredonda(XD / 1024, Xarr),
    arredonda(YD / 768, Yarr),
    
    Xd is XD - (1024 * Xarr),
    Yd is YD - (768 * Yarr),
    
    Dtemp is (Xd ** 2 + Yd ** 2) ** 0.5,
    Dtemp >= D, %Caso PIOR
    menor_dist(X1, Y1, Resto, Xi, Yi, D, Xf, Yf). 

coordenada_proxima(X1, Y1, ADVERSARIOS, Xf, Yf):-
    [[A, B] | Resto] = ADVERSARIOS,
    XD is A - X1,
    YD is B - Y1,
    
    arredonda(XD / 1024, Xarr),
    arredonda(YD / 768, Yarr),
    
    Xd is XD - (1024 * Xarr),
    Yd is YD - (768 * Yarr),
    
    D is (Xd ** 2 + Yd ** 2) ** 0.5,
    menor_dist(X1, Y1, Resto, A, B, D, Xf, Yf).