include "globals.mzn";

par int: dimension; set of int: D = 1..dimension; % Dimension of the board
par int: number; set of int: N = 1..number; % Number of starting points
array[N, 1..3] of par 0..number: starting_points; % These are the starting points, one per row. First two columns are the coordinates X and Y and the last element is the number of turn that the starting points have to make in order to arrive to the intersection.
array[D, D, 1..2] of var 0..12: Board; % This is the DxD board. In the first dimension we have the next move, in the second dimension to which path the move belongs to.

% We assign the starting points, both in the first dimension of the board (next move) and the second dimension (path). Note that there is a change of notation from the input to the standard array indexing of MiniZinc, which is properly handled. 
constraint(
forall(n in N)
(
if starting_points[n,2] = 1 then Board[dimension, starting_points[n,1], 1] = 12 /\ Board[dimension, starting_points[n,1], 2] = n
elseif
starting_points[n,2] = dimension then Board[1, starting_points[n,1], 1] = 12 /\ Board[1, starting_points[n,1], 2] = n
else
Board[dimension - n + 1, starting_points[n,1], 1] = 12 /\ Board[dimension - n + 1, starting_points[n,1], 2] = n
endif
)
);

% We define the allowed moves (top, bottom, left, right)
predicate top(int: i, int: j) =
i-1 > 0 /\ 
(Board[i-1, j, 1] = 2 \/ Board[i-1, j, 1] = 4 \/ Board[i-1, j, 1] = 6 \/ Board[i-1, j, 1] = 8 \/ Board[i-1, j, 1] = 9 \/ Board[i-1, j, 1] = 10 \/ Board[i-1, j, 1] = 11 \/ Board[i-1, j, 1] = 12) /\ 
(Board[i-1, j, 2] != number + 1 -> (Board[i, j, 2] = Board[i-1, j, 2]  \/ Board[i, j, 2] = number + 1));

predicate bottom(int: i, int:j) =
i+1 <= dimension /\ 
(Board[i+1, j, 1] = 1 \/ Board[i+1, j, 1] = 3 \/ Board[i+1, j, 1] = 6 \/ Board[i+1, j, 1] = 7 \/ Board[i+1, j, 1] = 9 \/ Board[i+1, j, 1] = 10 \/ Board[i+1, j, 1] = 11 \/ Board[i+1, j, 1] = 12) /\ 
(Board[i+1, j, 2] != number + 1 -> (Board[i, j, 2] = Board[i+1, j, 2] \/ Board[i, j, 2] = number + 1));

predicate left(int: i, int: j) =
j-1 > 0 /\ 
(Board[i, j-1, 1] = 3 \/ Board[i, j-1, 1] = 4 \/ Board[i, j-1, 1] =  5 \/ Board[i, j-1, 1] = 7 \/ Board[i, j-1, 1] = 8 \/ Board[i, j-1, 1] = 10 \/ Board[i, j-1, 1] = 11 \/ Board[i, j-1, 1] = 12) /\ 
(Board[i, j-1, 2] != number + 1 -> (Board[i, j, 2] = Board[i, j-1, 2] \/ Board[i, j, 2] = number + 1));

predicate right(int: i, int: j) =
j+1 <= dimension /\ 
(Board[i, j+1, 1] = 1 \/ Board[i, j+1, 1] = 2 \/ Board[i, j+1, 1] = 5 \/ Board[i, j+1, 1] = 7 \/ Board[i, j+1, 1] = 8 \/ Board[i, j+1, 1] = 9 \/ Board[i, j+1, 1] = 11 \/ Board[i, j+1, 1] = 12) /\ 
(Board[i, j+1, 2] != number + 1 -> (Board[i, j, 2] = Board[i, j+1, 2] \/ Board[i, j, 2] = number + 1));

% Each cell defines specific connections
constraint(
forall(i,j in D)(

(Board[i, j, 1] = 1 -> left(i,j) /\ top(i,j)) /\

(Board[i, j, 1] = 2 -> left(i,j) /\ bottom(i,j)) /\

(Board[i, j, 1] = 3 -> top(i,j) /\ right(i,j)) /\

(Board[i, j, 1] = 4 -> bottom(i,j) /\ right(i,j)) /\

(Board[i, j, 1] = 5 -> left(i,j) /\ right(i,j)) /\

(Board[i, j, 1] = 6 -> top(i,j) /\ bottom(i,j)) /\

(Board[i, j, 1] = 7 -> top(i,j) /\ left(i,j) /\ right(i,j)) /\

(Board[i, j, 1] = 8 -> bottom(i,j) /\ left(i,j) /\ right(i,j)) /\

(Board[i, j, 1] = 9 -> top(i,j) /\ bottom(i,j) /\ left(i,j)) /\

(Board[i, j, 1] = 10 -> top(i,j) /\ bottom(i,j) /\ right(i,j)) /\

(Board[i, j, 1] = 11 -> top(i,j) /\ bottom(i,j) /\ right(i,j) /\ left(i,j)) /\

(Board[i, j, 1] = 12 -> top(i,j) \/ bottom(i,j) \/ right(i,j) \/ left(i,j))

)
);

% Based on how many initial points there are, there has to be a specific goal cell.
constraint(
let {array[D,D] of var 0..12: MoveBoard; constraint forall(i,j in D) (MoveBoard[i,j] = Board[i,j, 1]);} in
if number = 2 then
among(0, MoveBoard, 7..11)
elseif number = 3 then
among(1, MoveBoard, 7..10)
elseif number = 4 then
count_eq(MoveBoard, 11, 1)
else
false % There can't be more than 4 points!
endif
);

% Each path has to do a specific number of turns.
constraint(
forall (n in N)(
let {array[D,D] of var 0..12: MoveBoard; constraint forall(i,j in D) (if  Board[i,j,2] = n then MoveBoard[i,j] = Board[i,j, 1] else MoveBoard[i,j] = 0 endif);} in
among(starting_points[n,3], MoveBoard, 1..4)
));

% There has to be only one point in the second dimension of the Board labelled as number+1.
constraint(
let {array[D,D] of var 0..12: PathsBoard; constraint forall(i,j in D) (PathsBoard[i,j] = Board[i,j,2]);} in
count_eq(PathsBoard, 4, 1)
);

% The number of starting points is fixed.
constraint(
let {array[D,D] of var 0..12: MoveBoard; constraint forall(i,j in D) (MoveBoard[i,j] = Board[i,j,1]);} in
count_eq(MoveBoard, 12, number)
);

output 
[
  if i = 1 /\ j = 1 then "\n\n" elseif j=1 then "\n" else " " endif ++
  show(Board[i,j,1])
  | i,j in D
] ++ ["\n"];