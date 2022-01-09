fun curry f x y = f (x,y);

fun range (i, j) = if i > j then [] else i :: range(i+1,j)
val countup = curry range 1