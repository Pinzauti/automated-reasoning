% Generate

% The generation part is handled by the python script.

% Define

grid(1..D, 1..D) :-boardl(D). % Define the grid.

1 {goal(X,Y): grid(X,Y)} 1. % The intersection point is the goal.

{link(start(X1, Y1), end(X2, Y2)) :  grid(X1,Y1), grid(X2,Y2), |X1 - X2| + |Y1 - Y2| = 1}. % Definition of link between two points of the grid.

connected(start(X1,Y1) ,end(X2,Y2)) :- link(start(X1,Y1), end(X2,Y2)).
connected(start(X1,Y1), end(X2,Y2)) :- connected(start(X1,Y1), end(Z1,Z2)), link(start(Z1,Z2),end(X2,Y2)). %Recursive definition of connection, using the link definition.

% Test

:- #count{grid(X,Y): number(X,Y, _)} < 2. % There can't be only one starting point.

:- goal(X, Y), number(X, Y, _). % The goal point can't be one of the start points.

:- goal(X, Y), not connected(start(X0, Y0), end(X,Y)), number(X0,Y0, _). % The goal must be connected with all the starting points.

:- link(start(X0, Y0), end(X1, Y1)), number(X1, Y1, _). % There can't be a link ending in a starting point.

:- link(start(X1,Y1), _), not link(_, end(X1,Y1)), not number(X1,Y1, _).% A link can only start when another link end or at the starting point.

:- link(_, end(X2,Y2)), not link(start(X2,Y2), _), not goal(X2, Y2). % A link can only end if there is another link starting or at the goal.

:- link(start(X, Y),end(X1, Y1)), link(start(X, Y), end(X2, Y2)), X1 != X2. % No two links from one starting point.

:- link(start(X, Y),end(X1, Y1)), link(start(X, Y), end(X2, Y2)), Y1 != Y2. % No two links from one starting point.

:- link(start(X0, Y0),end(X, Y)), link(start(X1, Y1), end(X, Y)), X0 != X1, not goal(X,Y). % There can't be intersections.

:- link(start(X0, Y0),end(X, Y)), link(start(X1, Y1), end(X, Y)), Y0 != Y1, not goal(X,Y). % There can't be intersections.

:- link(start(X1, Y1), end(X2, Y2)), link(start(X2,Y2), end(X1, Y1)). % Avoid loops.

:- link(_, end(X1,Y1)), not connected(start(X1,Y1), end(X, Y)), goal(X, Y), not goal(X1,Y1). % Links have to be connected to the goal.

:- #count{grid(X2,Y2), grid(X3, Y3): link(start(X1, Y1), end(X2, Y2)), link(start(X2, Y2), end(X3, Y3)), |X1-X3| = 1, |Y1-Y3| = 1, connected(start(X0, Y0), end(X1, Y1));
grid(X2,Y2), grid(X3, Y3): link(start(X0, Y0), end(X2, Y2)), link(start(X2, Y2), end(X3, Y3)), |X0-X3| = 1, |Y0-Y3| = 1} != Z, number(X0, Y0, Z). % Number of turns per each path should be as perscribed in each starting point.

% Display

#show link/2.
#show goal/2.