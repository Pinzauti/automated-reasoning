par int: dimension; set of int: D = 1..dimension; % Dimension of the board
par int: N; %Number of starting points
array[1..N, 1..3] of par 0..N: number; %These are the starting point, first two element are the coordinates X and Y and the last element is the number of turn that the starting point have to make to arrive to the intersection.


array[D, D] of var D: Board;

%var 1..dimension*dimension: step; %Numbers of step can't be greater than the number of cells in the board.

%predicate next(int: x1, int: y1, int: x2, int: y2) =
% |X1 - X2| + |Y1 - Y2| = 1;


predicate connection_check(par int: X1, par int: Y1, par int: X2, par int: Y2, par int: dim) =
abs(X1 - X2) + abs(Y1 - Y2) = 1 \/ %not sure if it is redundant, should think about it
exists(Z1, Z2 in dim..dim+1 where abs(Z1 - X2) + abs(Z2 - Y2) = 1 /\ dim < dimension)(
connected(X1,Y1,Z1,Z2)
) \/
connection_check(X1, Y1, X2, Y2, dim+1)
;


predicate connected(par int: X1, par int: Y1, par int: X2, par int: Y2) =
abs(X1 - X2) + abs(Y1 - Y2) = 1 \/
connection_check(X1,Y1,X2,Y2,1)
;

constraint(

connected(1, 1, 3, 3)

);
%constraint forall (i,j in D)(
%  abs(i - BoardX[i, j]) + abs(j - BoardY[i, j] ) = 1 \/ (i=GoalX /\ j=GoalY)
%);

%predicate connected(int: i, int: j) = 
%  abs(i - BoardX[i, j]) + abs(j - BoardY[i, j] ) = 1 \/ (i=GoalX /\ j=GoalY)
%;

%constraint forall(n in 1..N)(
%    connected(number[n,1], number[n,2])
%);

%constraint forall (s in step) (
 % exists(i,j in D) (
  %  connected(
 % );
%);
%prdicate 
 
%constraint input[x,y] < 0;

%constraint forall(i,j in D where input[i,j] >=0)(exists(k in 0..input[i,j], s in 0..input[i,j] where k+s = input[i,j])(abs(i-x) = k \/ abs(j-y) = s));

%constraint forall(i,j in D where input[i,j] >=0)(
%exists(s in -abs(i-x)..abs(i-x), k in -abs(j-y)..abs(j-y) where s + i <= dimension /\ k + j <= dimension)(input[i + s, j + k] = input[x,y])
%);

solve satisfy;

