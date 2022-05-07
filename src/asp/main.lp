% Generate
#include "data/input1.lp".

% Define

grid(1..D, 1..D) :-boardl(D).

1 {goal(X,Y): grid(X,Y)} 1.

{link(start(X1, Y1), end(X2, Y2)) :  grid(X1,Y1), grid(X2,Y2), |X1 - X2| + |Y1 - Y2| = 1}.

connected(start(X1,Y1) ,end(X2,Y2)) :- link(start(X1,Y1), end(X2,Y2)).
connected(start(X1,Y1), end(X2,Y2)) :- connected(start(X1,Y1), end(Z1,Z2)), link(start(Z1,Z2),end(X2,Y2)).

% Test

:- goal(X, Y), number(X, Y, _). %the goal point can't be one of the start points 

:- goal(X, Y), not connected(start(X0, Y0), end(X,Y)), number(X0,Y0, _). %the goal must be connected with the starting points.

:- link(start(X0, Y0), end(X1, Y1)), number(X1, Y1, _). %there can't be a link ending in a starting point

:- link(start(X1,Y1), _), not link(_, end(X1,Y1)), not number(X1,Y1, _).% a link can only start when another link end or at the starting point

:- link(_, end(X2,Y2)), not link(start(X2,Y2), _), not goal(X2, Y2). %a link can only end if there is another link starting or in the goal

:- link(start(X, Y),end(X1, Y1)), link(start(X, Y), end(X2, Y2)), X1 != X2. %no two links from one starting point

:- link(start(X, Y),end(X1, Y1)), link(start(X, Y), end(X2, Y2)), Y1 != Y2. %no two links from one starting point

:- link(start(X0, Y0),end(X, Y)), link(start(X1, Y1), end(X, Y)), X0 != X1, not goal(X,Y). %there can't be intersections

:- link(start(X0, Y0),end(X, Y)), link(start(X1, Y1), end(X, Y)), Y0 != Y1, not goal(X,Y). %there can't be intersections

:- link(start(X1, Y1), end(X2, Y2)), link(start(X2,Y2), end(X1, Y1)). % don't really like loops

 c(X0, Y0, Z, S1) :-  S1 = #count{link(start(X1, Y1), end(X2, Y2)): connected(start(X0, Y0), end(X1, Y1)), link(start(X2, Y2), end(X3, Y3)), X1 = X2, X2 != X3, Y1!= Y2, Y2 = Y3}, number(X0, Y0, Z).
 
 a(X0, Y0, Z, S2) :- S2 = #count{link(start(X1, Y1), end(X2, Y2)): connected(start(X0, Y0), end(X1, Y1)), link(start(X2, Y2), end(X3, Y3)), Y1 = Y2, Y2 != Y3, X1!= X2, X2 = X3}, number(X0, Y0, Z).

 :- a(X, Y, Z, S1), c(X, Y, Z, S2), S1 + S2 != Z.

% Display

#show link/2.
#show goal/2.