%generate
#include "data/input1.lp".

grid(1..D, 1..D) :-boardl(D).



{link(X1, Y1, X2, Y2) :  grid(X1,Y1), grid(X2,Y2), |X1 - X2| + |Y1 - Y2| = 1}.

1 {goal(X,Y): grid(X,Y)} 1.

connected(X1,Y1,X2,Y2) :- link(X1,Y1,X2,Y2).
connected(X1,Y1,X2,Y2) :- connected(X1,Y1,Z1,Z2), link(Z1,Z2,X2,Y2).


:- goal(X, Y), number(X, Y, _). %the goal point can't be one of the start points.


:- link(X0, Y0, X1, Y1), number(X1, Y1, _). %there can't be a link ending in a starting point

:- connected(X0, Y0, X, Y), connected(X1, Y1, X, Y), X0 != X1, Y0 != Y1, not goal(X,Y). %there can't be intersections

:- goal(X, Y), not connected(X0, Y0, X,Y), number(X0,Y0, _). %the goal must be connected with the starting points.





%:- number(X1, Y1, Z), grid(X2, Y2), not connected(X1, Y1, X2, Y2).


#show goal/2.