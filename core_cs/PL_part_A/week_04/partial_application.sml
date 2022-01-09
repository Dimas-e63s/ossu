fun sorted3 x y z = z >= y andalso y >= x;

fun fold f acc xs = 
  case xs of
     [] => acc
   | x::xs' => fold f (f(acc, x)) xs';

(* If a curried function is applied to "too few" arguments, that
    returns, which is iften useful.
    A powerful idiom (no new semantics) *)

val is_nonnegative = sorted3 0 0;
val sum = fold (fn (x,y) => x+y) 0;

(* In fact, not doing this is often a harder-to-notice version of
    unnecessary function wrapping, as in these inferior versions *)

fun is_nonnegative_inferior x = sorted3 0 0 x;
fun sum_inferior xs = fold (fn (x,y) => x+y) 0 xs;

(* another example *)

fun exists predicate xs = 
    case xs of
        [] => false
        | x::xs' => predicate x orelse exists predicate xs';

val no = exists (fn x => x=7) [4,11,23];
val hasZero = exists (fn x => x=0) 