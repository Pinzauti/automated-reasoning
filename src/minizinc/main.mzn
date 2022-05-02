par int: dimension; set of int: D = 1..dimension; % Dimension of the board
set of int: BoardRange = -1..dimension*dimension;

array[D, D] of par BoardRange: input;

var D: x; var D: y;
 
constraint input[x,y] < 0;

constraint forall(i,j in D where input[i,j] >=0)(exists(k in 0..input[i,j], s in 0..input[i,j] where k+s = input[i,j])(abs(i-x) = k \/ abs(j-y) = s));

constraint forall(i,j in D where input[i,j] >=0)(
exists(s in -abs(i-x)..abs(i-x), k in -abs(j-y)..abs(j-y) where s + i <= dimension /\ k + j <= dimension)(input[i + s, j + k] = input[x,y])
);