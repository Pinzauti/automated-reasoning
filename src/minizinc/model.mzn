par int: dimension; set of int: D = 1..dimension; % Dimension of the board
par int: number; set of int: N = 1..number; %Number of starting points
array[N, 1..3] of par 0..number: starting_points; %These are the starting point, first two element are the coordinates X and Y and the last element is the number of turn that the starting point have to make to arrive to the intersection.


array[D, D] of var 1..13: Board;



constraint(

if Board[dimension,1] = 13 then 
Board[dimension - 1, 1] = 5 \/  Board[dimension - 1, 1]  = 7 \/  Board[dimension - 1, 1]  = 11
\/ 
Board[dimension,2] = 2 \/ Board[dimension,2] = 6 \/ Board[dimension,2] = 8
endif

/\

if Board[dimension,dimension] = 13 then
Board[dimension + 1,dimension] = 3 \/ Board[dimension + 1,dimension] = 7 \/ Board[dimension + 1,dimension] = 10 
\/ 
Board[dimension,dimension -1] = 4 \/ Board[dimension,dimension -1] = 8
endif

/\







);



constraint(
forall(n in N)
(
if starting_points[n,2] = 1 then Board[dimension, starting_points[n,1]] = 13
elseif
starting_points[n,2] = dimension then Board[1, starting_points[n,1]] = 13
else
Board[dimension - n + 1, starting_points[n,1]] = 13
endif
)
);


solve satisfy;

output 
[
  if j = 1 then "\n" else " " endif ++
  show(Board[i,j])
  | i,j in D
] ++ ["\n"];
