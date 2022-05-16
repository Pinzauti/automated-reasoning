par int: dimension; set of int: D = 1..dimension; % Dimension of the board
par int: number; set of int: N = 1..number; % Number of starting points
array[N, 1..3] of par 0..number: starting_points; % These are the starting points, one per row. First two columns are the coordinates X and Y and the last element is the number of turn that the starting points have to make in order to arrive to the intersection.


array[D, D, 1..2] of var 0..12: Board; % This is the DxD board. In the first dimension we have the next move, in the second dimension to which path the move belongs to.



constraint(
% Bottom-left position
if Board[dimension,1, 1] = 12 then 
% Up move
((Board[dimension - 1, 1, 1] = 4 \/  Board[dimension - 1, 1, 1]  = 6 \/  Board[dimension - 1, 1, 1]  = 10) /\ Board[dimension - 1, 1, 2] = Board[dimension,1, 2] )
\/ 
% Right move
((Board[dimension,2, 1] = 1 \/ Board[dimension,2, 1] = 5 \/ Board[dimension,2, 1] = 7) /\  Board[dimension,2, 1] = Board[dimension,1, 1])
endif

/\

% Bottom right position
if Board[dimension,dimension, 1] = 12 then
% Up move
((Board[dimension - 1,dimension, 1] = 2 \/ Board[dimension - 1,dimension, 1] = 6 \/ Board[dimension - 1,dimension, 1] = 9) /\ Board[dimension - 1,dimension, 2] = Board[dimension,dimension, 2])
\/ 
% Left move
((Board[dimension,dimension -1, 1] = 3 \/ Board[dimension,dimension -1, 1] = 7) /\ Board[dimension,dimension -1, 2] = Board[dimension,dimension, 2])
endif

/\

% Bottom position (not bottom left nor bottom right)
forall(j in 2..(dimension-1)) (
if Board[dimension, j, 1] = 12 then
% Up move
((Board[dimension - 1, j, 1] = 2 \/ Board[dimension - 1, j, 1] = 4 \/ Board[dimension - 1, j, 1] = 6 \/ Board[dimension - 1, j, 1] = 8 \/ Board[dimension - 1, j, 1] = 9 \/ Board[dimension - 1, j, 1] = 10 \/ Board[dimension - 1, j, 1] = 11) /\ Board[dimension - 1, j, 2] = Board[dimension, j, 2])
\/
% Left move
((Board[dimension, j-1,1] = 3 \/ Board[dimension, j-1,1] = 5 \/ Board[dimension, j-1,1] = 7) /\  Board[dimension, j-1,2] = Board[dimension, j, 2])
\/
%Right move
((Board[dimension, j+1,1] = 1 \/ Board[dimension, j+1,1] = 5 \/ Board[dimension, j+1,1] = 7) /\  Board[dimension, j+1,2] = Board[dimension, j, 2])
endif
)


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
% da finire di aggiungere i constraint per i punti iniziali
% aggiungere i constraint per le mosse che si possono fare dopo una specifica cella
% aggiungere che un percorso può avere solo un certo numero di turns