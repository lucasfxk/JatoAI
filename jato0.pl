% Jato 0
:- module(jato0, [obter_controles/4]).

%% Explicacao:
% Informacao:
%   X: posição horizontal do jato
%   Y: posiçao vertical do jato
%   ANGLE: angulo de inclinacao do jato: 0 para virado para frente até PI*2 (~6.28)
%   SCORE: inteiro com a "vida" do jato. Em zero, ele perdeu
%   SPEED: velocidade do jato
% Adversarios:
%   vetor com a posicao de todos os adversarios, [ [X1,Y1], [X2,Y2], ... ]
% Misseis:
%   vetor com a posicao de todos os misseis, [ [X1,Y1], [X2,Y2], ... ]
% Controles:
%   FORWARD: 1 para acelerar e 0 para continuar a velocidade atual
%   REVERSE: 1 para desacelerar e 0 para continuar a velocidade atual
%   LEFT: 1 para ir pra esquerda e 0 para não ir
%   RIGHT: 1 para ir pra direita e 0 para não ir
%   BOOM: 1 para tentar disparar (BOOM). Obs.: ele só pode disparar uma bala a cada segundo
%   MSG: mensagem para DEBUG

%%% Faça seu codigo a partir daqui, sendo necessario sempre ter o predicado:
%%%% obter_controles([X,Y,ANGLE,SCORE,SPEED], ADVERSARIOS, MISSEIS, [FORWARD, REVERSE, LEFT, RIGHT, BOOM, MSG]) :- ...

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
    menor_dist(X1, Y1, Resto, Xd, Yd, Dtemp, Xf, Yf). 

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
    menor_dist(X1, Y1, Resto, Xd, Yd, D, Xf, Yf).

erro_angular(Angulo, Xd,Yd, ErroNorm):-
    Angulo2 is atan2(-Xd, -Yd),
    Erro is Angulo2 - Angulo,
    
    arredonda(Erro / (2* pi), Arr),
    ErroNorm is Erro - (2 * pi) * Arr.



direcao(ErroAng, Esq, Dir):-
    ErroAng >= 0,
    DeadAngle is pi / 8, %Intervalo para seguir Reto
    ErroAng > DeadAngle,
    Esq is 1,
    Dir is 0.
    
direcao(ErroAng, Esq, Dir):-
    ErroAng >= 0,
    DeadAngle is pi / 8, %Intervalo para seguir Reto
    ErroAng =< DeadAngle,
    Esq is 0,
    Dir is 0.

direcao(ErroAng, Esq, Dir):-
    ErroAng < 0,
    DeadAngle is -pi / 8, %Intervalo para seguir Reto
    ErroAng < DeadAngle,
    Esq is 0,
    Dir is 1.

direcao(ErroAng, Esq, Dir):-
    ErroAng < 0,
    DeadAngle is -pi / 8, %Intervalo para seguir Reto
    ErroAng >= DeadAngle,
    Esq is 0,
    Dir is 0.


troca(0, 1).
troca(1, 0).

% [FORWARD, REVERSE, LEFT, RIGHT, BOOM, MSG]
obter_controles(INFORMACAO, ADVERSARIOS, MISSEIS, CONTROLES) :-
    INFORMACAO = [X, Y, ANGLE, SCORE, SPEED],
    CONTROLES = [FORWARD, REVERSE, LEFT, RIGHT, BOOM, MSG],
    
    coordenada_proxima(X, Y, ADVERSARIOS, Xf, Yf),
    erro_angular(ANGLE, Xf, Yf, ErroAng),
    direcao(ErroAng, LEFT,RIGHT),

    FORWARD is 1,
    REVERSE is 0,
    BOOM is 1,
    MSG = "Versão 1.0", !.
    %opcao:
    %term_string([ADVERSARIOS| [MISSEIS]], MSG).


% Para evitar erros, o jato para:
obter_controles(_, _, _, [0,0,0,0,0,"nenhuma regra aplicada"]).

% Dica:
% Você pode transformar um vetor com qualquer coisa para string assim:
% term_string(VETOR, MSG).
% Assim, MSG passa a ser uma string do seu vetor
% Ex.:
% ?- term_string([1,2,"teste",oi], MSG.
% MSG = "[1,2,\"teste\",oi]".
