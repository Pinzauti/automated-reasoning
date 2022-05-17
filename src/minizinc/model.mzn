par int: dimension; set of int: D = 1..dimension; % Dimension of the board
par int: number; set of int: N = 1..number; % Number of starting points
array[N, 1..3] of par 0..number: starting_points; % These are the starting points, one per row. First two columns are the coordinates X and Y and the last element is the number of turn that the starting points have to make in order to arrive to the intersection.


array[D, D, 1..2] of var 0..12: Board; % This is the DxD board. In the first dimension we have the next move, in the second dimension to which path the move belongs to.

include "globals.mzn";

constraint(
% Bottom-left position
if Board[dimension,1, 1] = 12 then 
% Up move
((Board[dimension - 1, 1, 1] = 4 \/  Board[dimension - 1, 1, 1]  = 6 \/  Board[dimension - 1, 1, 1]  = 10) /\ (Board[dimension - 1, 1, 2] = Board[dimension,1, 2] \/ Board[dimension - 1, 1, 2] = number + 1))
\/ 
% Right move
((Board[dimension,2, 1] = 1 \/ Board[dimension,2, 1] = 5 \/ Board[dimension,2, 1] = 7) /\  (Board[dimension,2, 1] = Board[dimension,1, 1] \/ Board[dimension,2, 1] = number + 1))
endif

/\

% Bottom right position
if Board[dimension,dimension, 1] = 12 then
% Up move
((Board[dimension - 1,dimension, 1] = 2 \/ Board[dimension - 1,dimension, 1] = 6 \/ Board[dimension - 1,dimension, 1] = 9) /\ (Board[dimension - 1,dimension, 2] = Board[dimension,dimension, 2] \/ Board[dimension - 1,dimension, 2] = number + 1))
\/ 
% Left move
((Board[dimension,dimension -1, 1] = 3 \/ Board[dimension,dimension -1, 1] = 7) /\ (Board[dimension,dimension -1, 2] = Board[dimension,dimension, 2] \/ Board[dimension,dimension -1, 2] = number + 1))
endif

/\

% Bottom position (not bottom left nor bottom right)
forall(j in 2..(dimension-1)) (
if Board[dimension, j, 1] = 12 then
% Up move
((Board[dimension - 1, j, 1] = 2 \/ Board[dimension - 1, j, 1] = 4 \/ Board[dimension - 1, j, 1] = 6 \/ Board[dimension - 1, j, 1] = 8 \/ Board[dimension - 1, j, 1] = 9 \/ Board[dimension - 1, j, 1] = 10 \/ Board[dimension - 1, j, 1] = 11) /\ (Board[dimension - 1, j, 2] = Board[dimension, j, 2] \/ Board[dimension - 1, j, 2] = number + 1))
\/
% Left move
((Board[dimension, j-1,1] = 3 \/ Board[dimension, j-1,1] = 5 \/ Board[dimension, j-1,1] = 7) /\  (Board[dimension, j-1,2] = Board[dimension, j, 2] \/ Board[dimension, j-1,2] = number + 1))
\/
%Right move
((Board[dimension, j+1,1] = 1 \/ Board[dimension, j+1,1] = 5 \/ Board[dimension, j+1,1] = 7) /\  (Board[dimension, j+1,2] = Board[dimension, j, 2] \/ Board[dimension, j+1,2] = number + 1))
endif
)

/\

% Top left position
if Board[1, 1, 1] = 12 then
% Bottom move
((Board[2, 1, 1] = 3 \/ Board[2, 1, 1] = 6 \/ Board[2, 1, 1] = 10) /\ (Board[2, 1, 2] = Board[1, 1, 2] \/ Board[2, 1, 2] = number + 1))

\/
% Right move
((Board[1,2,1] = 2 \/ Board[1,2,1] = 5 \/ Board[1,2,1] = 8) /\ (Board[1, 2, 2] = Board[1, 1, 2] \/ Board[1, 2, 2] = number + 1))
endif


/\

% Left position (not top left nor bottom left)
forall(i in 2..(dimension-1)) (
if Board[1, i, 1] = 12 then
% Up move
((Board[1, i - 1, 1] = 4 \/ Board[1, i - 1, 1] = 6 \/ Board[1, i - 1, 1] = 10) /\ (Board[1, i - 1, 2] = Board[1, i, 2] \/ Board[1, i - 1, 2] = number + 1))
\/
% Bottom move
((Board[1, i + 1, 1] = 3 \/ Board[1, i + 1, 1] = 6 \/ Board[1, i + 1, 1] = 10) /\ (Board[1, i + 1, 2] = Board[1, i, 2] \/ Board[1, i + 1, 2] = number + 1))
\/
% Right move
((Board[2, i, 1] = 1 \/ Board[2, i, 1] = 2 \/ Board[2, i, 1] = 5 \/ Board[2, i, 1] = 7 \/ Board[2, i, 1] = 8 \/ Board[2, i, 1] = 9 \/ Board[2, i, 1] = 11) /\ (Board[2, i, 2] = Board[1, i, 2] \/ Board[2, i, 2] = number + 1))
endif
)

/\

% Top right position
if Board[1, number, 1] = 12 then
% Left move
((Board[1, number - 1, 1] = 4 \/ Board[1, number - 1, 1] = 5 \/ Board[1, number - 1, 1] = 8) /\ (Board[1, number - 1, 2] = Board[1, number, 2] \/ Board[1, number - 1, 2] = number + 1))
\/
% Bottom move
((Board[2, number, 1] = 1 \/ Board[2, number, 1] = 6 \/ Board[2, number, 1] = 9) /\ (Board[2, number, 2] = Board[1, number, 2] \/ Board[2, number, 2] = number + 1))
endif

/\

% Top position (not top left nor top right)
forall(j in 2..(dimension-1)) (
if Board[1, j, 1] = 12 then
% Left move
((Board[1, j-1,1] = 4 \/ Board[1, j-1,1] = 5 \/ Board[1, j-1,1] = 8) /\ (Board[1, j-1, 2] = Board[1, j, 2] \/ Board[1, j-1, 2] = number + 1))
\/
% Right move
((Board[1, j+1, 1] = 2 \/ Board[1, j+1, 1] = 5 \/ Board[1, j+1, 1] = 8) /\ (Board[1, j+1, 2] = Board[1, j, 2] \/ Board[1, j+1, 2] = number + 1))
\/
%Bottom move
((Board[2, j,1] = 1 \/ Board[2, j,1] = 3 \/  Board[2, j,1] = 6 \/ Board[2, j,1] = 7 \/ Board[2, j,1] = 9 \/ Board[2, j,1] = 10 \/ Board[2, j,1] = 11) /\ (Board[2, j, 2] = Board[1, j, 2] \/ Board[2, j, 2] = number + 1))
endif
)

% Right position (not top right nor bottom right)
/\


);


% Pahts have to do a definite number of turns to arrive to the goal.
constraint(
let {array[D,D] of var 0..12: PathsBoard; constraint forall(i,j in D) (PathsBoard[i,j] = Board[i,j, 1]);} in
count_eq(PathsBoard, number + 1, 1)
);


% Here we assign the starting points, both in the first dimension of the board (next move) and the second dimension (path). Note that there is a change of notation from the input to the standard array indexing of MiniZinc, which is properly handled. 
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


solve satisfy;

output 
[
  if i = 1 /\ j = 1 then "\n\n" elseif j=1 then "\n" else " " endif ++
  show(Board[i,j,t])
  | t in 1..2, i,j in D
] ++ ["\n"];

% TODO
% aggiungere i constraint per le mosse che si possono fare dopo una specifica cella
% aggiungere che un percorso può avere solo un certo numero di turns
% aggiungere la cella che ci deve essere in base ai punti iniziali