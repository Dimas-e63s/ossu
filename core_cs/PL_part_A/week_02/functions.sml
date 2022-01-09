fun pow(x: int, y: int) =
    if y=0
    then 1
    else x * pow(x, y-1);

fun cube(x: int) =
    pow(x, 3);

val sixtyfour = cube 4;

fun swap (pr : int*bool) =
    (#2 pr, #1 pr);

fun sum_two_pairs (pr1 : int * int, pr2: int * int) =
    (#1 pr1) + (#2 pr1) + (#1 pr2) + (#2 pr2);

fun div_mod (x: int, y: int) =
    (x div y, x mod y);

fun sort_pair (pr: int * int) =
    if (#1 pr) > (#2 pr)
    then (#2 pr, #1 pr)
    else pr;

