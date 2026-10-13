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
% O código acima pode ser apagado para evitar duplicação

% --------- Código Real: ----------
erro_angular(Angulo, Xd,Yd, ErroNorm):-
    Angulo2 is atan2(-Xd, -Yd),
    Erro is Angulo2 - Angulo,
    
    arredonda(Erro / (2* pi), Arr),
    ErroNorm is Erro - (2 * pi) * Arr.
    
    