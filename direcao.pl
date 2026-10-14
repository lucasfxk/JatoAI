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



direcao(ErroAng, Esq, Dir, Par):-
    ErroAng >= 0,
    DeadAngle is pi / 6, %Intervalo para seguir Reto
    ErroAng > DeadAngle,
    Esq is 1,
    Dir is 0,
    Par is 0.
    
direcao(ErroAng, Esq, Dir, Par):-
    ErroAng < 0,
    DeadAngle is -pi / 6, %Intervalo para seguir Reto
    ErroAng < DeadAngle,
    Esq is 0,
    Dir is 1,
    Par is 0.

direcao(ErroAng, Esq, Dir, Par):-
    Esq is 0,
    Dir is 0,
    Par is 1.
    