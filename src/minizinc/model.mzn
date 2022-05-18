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
if Board[1, dimension, 1] = 12 then
% Left move
((Board[1, dimension - 1, 1] = 4 \/ Board[1, dimension - 1, 1] = 5 \/ Board[1, dimension - 1, 1] = 8) /\ (Board[1, dimension - 1, 2] = Board[1, dimension, 2] \/ Board[1, dimension - 1, 2] = number + 1))
\/
% Bottom move
((Board[2, dimension, 1] = 1 \/ Board[2, dimension, 1] = 6 \/ Board[2, dimension, 1] = 9) /\ (Board[2, dimension, 2] = Board[1, dimension, 2] \/ Board[2, dimension, 2] = number + 1))
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

forall(i in 2..(dimension-1)) (
if Board[i, dimension, 1] = 12 then
% Up move
((Board[i - 1, dimension, 1] = 2 \/ Board[i - 1, dimension, 1] = 6 \/ Board[i - 1, dimension, 1] = 9) /\ (Board[i - 1, dimension, 2] = Board[i, dimension, 2] \/ Board[i - 1, dimension, 2] = number + 1))
\/
% Bottom move
((Board[i + 1, dimension, 1] = 1 \/ Board[i + 1, dimension, 1] = 6 \/ Board[i + 1, dimension, 1] = 9) /\ (Board[i + 1, dimension, 2] = Board[i, dimension, 2] \/ Board[i + 1, dimension, 2] = number + 1))
\/
% Left move
((Board[i, dimension - 1, 1] = 3 \/ Board[i, dimension - 1, 1] = 4 \/ Board[i, dimension - 1, 1] = 5 \/ Board[i, dimension - 1, 1] = 7 \/ Board[i, dimension - 1, 1] = 8 \/ Board[i, dimension - 1, 1] = 10 \/ Board[i, dimension - 1, 1] = 11) /\ (Board[i, dimension - 1, 2] = Board[i, dimension, 2] \/ Board[i, dimension - 1, 2] = number + 1))
endif
)

/\
% Central position
forall(i,j in 2..(dimension-1))(
if Board[i, j, 1] = 12 then
% Up move
((Board[i + 1, j, 1] = 2 \/ Board[i + 1, j, 1] = 4 \/ Board[i + 1, j, 1] = 6 \/ Board[i + 1, j, 1] = 8 \/ Board[i + 1, j, 1] = 9 \/ Board[i + 1, j, 1] = 10 \/ Board[i + 1, j, 1] =  11) /\ (Board[i + 1, j, 2] = Board[i, j, 2] \/ Board[i + 1, j, 2] = number + 1))
/\
% Left move
((Board[i, j - 1, 1] = 3 \/ Board[i, j - 1, 1] = 4 \/ Board[i, j - 1, 1] = 5 \/ Board[i, j - 1, 1] = 7 \/ Board[i, j - 1, 1] = 8 \/ Board[i, j - 1, 1] = 10 \/ Board[i, j - 1, 1] = 11) /\ (Board[i, j - 1, 2] = Board[i, j, 2] \/Board[i, j - 1, 2] =  number + 1))
/\
% Bottom move
((Board[i + 1, j, 1] = 1 \/ Board[i + 1, j, 1] = 3 \/ Board[i + 1, j, 1] = 6 \/ Board[i + 1, j, 1] = 7 \/ Board[i + 1, j, 1] = 9 \/ Board[i + 1, j, 1] = 10 \/ Board[i + 1, j, 1] = 11) /\ (Board[i + 1, j, 2] = Board[i, j, 2] \/ Board[i + 1, j, 2] = number + 1))
/\
% Right move
((Board[i, j + 1, 1] = 1 \/ Board[i, j + 1, 1] = 2 \/ Board[i, j + 1, 1] = 5 \/ Board[i, j + 1, 1] = 7 \/ Board[i, j + 1, 1] = 8 \/ Board[i, j + 1, 1] = 9 \/ Board[i, j + 1, 1] = 11) /\ (Board[i, j + 1, 2] = Board[i, j, 2] \/ Board[i, j + 1, 2] = number + 1))
endif
)
);

% Each cell can have only specific cells near it
constraint(
forall(i,j in D)(
% Cell 1
if Board[i, j, 1] = 1 then
j-1 >= 1 /\  i-1 >= 1 /\
% Left move
(Board[i, j-1, 1] = 3 \/ Board[i, j-1, 1] = 4 \/ Board[i, j-1, 1] =  5 \/ Board[i, j-1, 1] = 7 \/ Board[i, j-1, 1] = 8 \/ Board[i, j-1, 1] = 10 \/ Board[i, j-1, 1] = 11 \/ Board[i, j-1, 1] = 12) /\ (Board[i, j-1, 2] = Board[i, j, 2] \/ Board[i, j-1, 2] = number + 1)
/\
% Up move
(Board[i-1, j, 1] = 2 \/ Board[i-1, j, 1] = 4 \/ Board[i-1, j, 1] = 6 \/ Board[i-1, j, 1] = 8 \/ Board[i-1, j, 1] = 9 \/ Board[i-1, j, 1] = 10 \/ Board[i-1, j, 1] = 11 \/ Board[i-1, j, 1] = 12) /\ (Board[i-1, j, 2] = Board[i, j, 2] \/ Board[i-1, j, 2] = number + 1)

endif

/\
% Cell 2
if Board[i, j, 1] = 2 then
j-1 >= 1 /\ j+1 <= dimension /\
% Left move
(Board[i, j-1, 1] = 3 \/ Board[i, j-1, 1] = 4 \/ Board[i, j-1, 1] = 5 \/ Board[i, j-1, 1] = 7 \/ Board[i, j-1, 1] = 8 \/ Board[i, j-1, 1] = 10 \/ Board[i, j-1, 1] = 11 \/ Board[i, j-1, 1] = 12) /\ (Board[i, j-1, 2] = Board[i, j, 2] \/ Board[i, j-1, 2] = number + 1)

/\
% Bottom move
 (Board[i, j+1, 1] = 1 \/ Board[i, j+1, 1] = 3 \/ Board[i, j+1, 1] = 6 \/ Board[i, j+1, 1] = 7 \/ Board[i, j+1, 1] = 9 \/ Board[i, j+1, 1] = 10 \/ Board[i, j+1, 1] = 11 \/ Board[i, j+1, 1] = 12) /\ (Board[i, j+1, 2] = Board[i, j, 2] \/ Board[i, j+1, 2] = number + 1)
endif

/\

% Cell 3
if Board[i, j, 1] = 3 then
i-1>=1 /\ j+1 <= dimension /\ 
% Top move
((Board[i-1, j, 1] = 2 \/ Board[i-1, j, 1] = 4 \/ Board[i-1, j, 1] = 6 \/ Board[i-1, j, 1] = 8 \/ Board[i-1, j, 1] = 9 \/ Board[i-1, j, 1] = 10 \/ Board[i-1, j, 1] = 11 \/ Board[i-1, j, 1] = 12) /\ (Board[i-1, j, 2] = Board[i, j, 2] \/ Board[i-1, j, 2] = number + 1))

/\
% Bottom move
((Board[i, j+1, 1] = 1 \/ Board[i, j+1, 1] = 2 \/ Board[i, j+1, 1] = 5 \/ Board[i, j+1, 1] = 7 \/ Board[i, j+1, 1] = 8 \/ Board[i, j+1, 1] = 9 \/ Board[i, j+1, 1] = 11 \/ Board[i, j+1, 1] = 12) /\ (Board[i, j+1, 2] = Board[i, j, 2] \/ Board[i, j+1, 2] = number + 1))
endif

/\
% Cell 4
if Board[i, j, 1] = 4 then
(i+1 <= dimension /\ j+1 <= dimension) /\ 
% Bottom move
((Board[i+1, j, 1] = 1 \/ Board[i+1, j, 1] = 3 \/ Board[i+1, j, 1] = 6 \/ Board[i+1, j, 1] = 7 \/ Board[i+1, j, 1] = 9 \/ Board[i+1, j, 1] = 10 \/ Board[i+1, j, 1] = 11 \/ Board[i+1, j, 1] = 12) /\ (Board[i+1, j, 1] = Board[i, j, 2] \/ Board[i+1, j, 1] = number + 1))
/\
% Right move
((Board[i, j+1, 1] = 1 \/ Board[i, j+1, 1] = 2 \/ Board[i, j+1, 1] = 5 \/ Board[i, j+1, 1] = 7 \/ Board[i, j+1, 1] = 8 \/ Board[i, j+1, 1] = 9 \/ Board[i, j+1, 1] = 11 \/ Board[i, j+1, 1] = 12) /\ (Board[i, j+1, 2] = Board[i, j, 2] \/ Board[i, j+1, 2] = number + 1))
endif


/\
% Cell 5
if Board[i, j, 1] = 5 then
(j-1 >= 1 /\ j+1 <= dimension) /\
% Left move
((Board[i, j-1, 1] = 3 \/ Board[i, j-1, 1] = 4 \/ Board[i, j-1, 1] = 5 \/ Board[i, j-1, 1] = 7 \/ Board[i, j-1, 1] = 8 \/ Board[i, j-1, 1] = 10 \/ Board[i, j-1, 1] = 11 \/ Board[i, j-1, 1] = 12) /\ (Board[i, j-1, 2] = Board[i, j, 2] \/ Board[i, j-1, 2] = number + 1))
/\
% Right move
((Board[i, j+1, 1] = 1 \/ Board[i, j+1, 1] = 2 \/ Board[i, j+1, 1] = 5 \/ Board[i, j+1, 1] = 7 \/ Board[i, j+1, 1] = 8 \/ Board[i, j+1, 1] = 9 \/ Board[i, j+1, 1] = 11 \/ Board[i, j+1, 1] = 12) /\ (Board[i, j+1, 2] = Board[i, j, 2] \/ Board[i, j+1, 2] = number + 1))
endif

/\
% Cell 6
if Board[i, j, 1] = 6 then
(i-1 >= 1 /\ i+1 <= dimension) /\
% Top move
((Board[i-1, j, 1] = 2 \/Board[i-1, j, 1] = 4 \/ Board[i-1, j, 1] = 6 \/ Board[i-1, j, 1] = 8 \/ Board[i-1, j, 1] = 9 \/ Board[i-1, j, 1] = 10 \/ Board[i-1, j, 1] = 11 \/ Board[i-1, j, 1] = 12) /\ (Board[i-1, j, 2] = Board[i, j, 2] \/ Board[i-1, j, 2] = number + 1))
/\
%Bottom move
((Board[i+1, j, 1] = 1 \/ Board[i+1, j, 1] = 3 \/ Board[i+1, j, 1] = 6 \/ Board[i+1, j, 1] = 7 \/ Board[i+1, j, 1] = 9 \/ Board[i+1, j, 1] = 10 \/ Board[i+1, j, 1] = 11 \/ Board[i+1, j, 1] = 12) /\ (Board[i+1, j, 2] = Board[i, j, 2] \/ Board[i+1, j, 2] = number + 1))

endif
% Cell 7

% Cell 8

% Cell 9

% Cell 10 

% Cell 11
)
);

% Based on how many initial points there are, there can be a specific goal cell.
constraint(
if number = 2 then
let {array[D,D] of var 0..12: MoveBoard; constraint forall(i,j in D) (MoveBoard[i,j] = Board[i,j, 1]);} in
among(0, MoveBoard, 7..11)
elseif number = 3 then
let {array[D,D] of var 0..12: MoveBoard; constraint forall(i,j in D) (MoveBoard[i,j] = Board[i,j, 1]);} in
among(1, MoveBoard, 7..10)
elseif number = 4 then
let {array[D,D] of var 0..12: MoveBoard; constraint forall(i,j in D) (MoveBoard[i,j] = Board[i,j, 1]);} in
count_eq(MoveBoard, 11, 1)
else
1516=2342 % There can't be more than 4 points!
endif
);

% Each path has to do a specific number of turns.
constraint(
forall (n in N)(
let {array[D,D] of var 0..12: MoveBoard; constraint forall(i,j in D) (if  Board[i,j,2] = n then MoveBoard[i,j] = Board[i,j, 1] else MoveBoard[i,j] = 0 endif );} in
count(MoveBoard, 1) + count(MoveBoard, 2) + count(MoveBoard, 3) + count(MoveBoard, 4) = starting_points[n,3] 
));

% There has to be only one point in the second dimension of the Board laeblled as number+1.
constraint(
let {array[D,D] of var 0..12: PathsBoard; constraint forall(i,j in D) (if  Board[i,j,2] != 0 then PathsBoard[i,j] = Board[i,j, 2] else PathsBoard[i,j] = 0 endif );} in
count_eq(PathsBoard, 4, 1)
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
% Valuta se riscrivere come prima il check  "Each path has to do a specific number of turns."
% you could have to constraint the number of 12 to not be magior than number
% pay attention to the real usefulnesss of all the inital condition on the starting points