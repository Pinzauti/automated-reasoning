%generate
#include "data/input1.lp".

grid(1..D, 1..D) :-boardl(D).



link(X1, Y1, X2, Y2) :- grid(X1,Y1), grid(X2,Y2), |X1 - X2| + |Y1 - Y2| = 1.

connected(X1,Y1,X2,Y2) :- link(X1,Y1,X2,Y2).
connected(X1,Y1,X2,Y2) :- connected(X1,Y1,Z1,Z2), link(Z1,Z2,X2,Y2).


%path(X1, Y1, X2, Y2) :- connected(X1,Y1,X2,Y2), number(X1,Y1, _), goal(X2, Y2).


{path(X1,Y1, X2, Y2) : connected(X1, Y1, X2 , Y2), not number(X2, Y2, _)} = 1 :- number(X1,Y1, _), X2 = 1..D, Y2= 1..D, boardl(D).


%:- path(X1,Y1, X2, Y2), number(X1, Y1).
%:- number(X1,Y1, _), grid(X2, Y2), not path(X1,Y1,X2,Y2).
%1 {position(I, X, Y) : grid(X,Y)} 1 :- step(I).
%define



%:- step(I), step(I+1), grid(X1,Y1), grid(X2,Y2), position(I,X1,Y1), position(I+1,X2,Y2), not link(X1,Y1,X2,Y2).

%:- position(1, X, Y), not number(X, Y, _).
%:- position(I+1, X, Y), number(X, Y, _), step(I).

%:- step(1), step(I1), step(I2), grid(X2,Y2), grid(X3,X4), number(X1,Y1,_), position(1,X1,Y1), position(I1,X2,Y2), position(I2, X3,Y3), not link(X2,Y2,X3,Y3), not link(X1,Y1,X2,Y2).

%:- step(I), step(I+1), grid(X1,Y1), grid(X2,Y2), position(I,X1,Y1), position(I+1,X2,Y2), link(X1,Y1,X2,Y2).

%:- step(I1), step(I2), I1 < I2, grid(X,Y), position(I1,X,Y), position(I2,X,Y).
%display
%#show conn/4.