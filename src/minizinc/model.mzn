par int: dimension; set of int: D = 1..dimension; % Dimension of the board
par int: number; set of int: N = 1..number; %Number of starting points
array[N, 1..3] of par 0..number: starting_points; %These are the starting point, first two element are the coordinates X and Y and the last element is the number of turn that the starting point have to make to arrive to the intersection.


array[D, D] of var 1..12: Board;

constraint(
forall(n in N)
(
if starting_points[n,2] = 1 then Board[dimension, starting_points[n,1]] = 12
elseif
starting_points[n,2] = dimension then Board[1, starting_points[n,1]] = 12
else
Board[dimension - n + 1, starting_points[n,1]] = 12
endif

%/\
%starting_points[n,1] = 1 /\ starting_points[n,2] = 1 -> Board[starting_points[n,1] + 1,starting_points[n,2], n] = 4 \/ Board[starting_points[n,1] + 1,starting_points[n,2], n] = 6 \/ Board[starting_points[n,1] + 1,starting_points[n,2], n] = 10
)
);




solve satisfy;

output 
[
  if j = 1 then "\n" else " " endif ++
  show(Board[i,j])
  | i,j in D
] ++ ["\n"];
