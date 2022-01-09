fun double_or_triple f = (* (int -> bool) -> (int -> int) *)
    if f 7
    then fn x => 2*x
    else fn x => 3*x;

val double = double_or_triple(fn x => x-3 = 4);
val nine = double_or_triple(fn x => x=42) 3;

double 4;