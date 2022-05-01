boardl(dimension).
number(1,1,1).
number(2,1,1).
number(3,3,0).

grid(1..dimension, 1..dimension) :-boardl(dimension).

%transitions(1..dimension).
%coord(1..2).

{link(X1, Y1, X2, Y2)} :- grid(X1, Y1), grid(X2, Y2), |X1-Y1| <= 1, |X2-Y2| <= 1.
:- link(X1, Y1, X2, Y2), X1=X2, Y1=Y2.
:- link(X1, Y1, X2, Y2), number(X2,Y2, N).
:- link(X0,Y0,X1,Y1), link(X2,Y2,X3,Y3), X1=X2, Y1=Y2, X3=X0, Y3=Y0.

%turn(X0, Y0): - link(X1, Y1, X2, Y2), link(X0, Y0, X1, Y1), not X0 = X1, X1=X2.
% :- link(X1, Y1, X2, Y2), link(X0, Y0, X1, Y1), Y0 \= Y1, Y1=Y2

%:- turn(X,Y) > Z, number(X,Y,Z).


