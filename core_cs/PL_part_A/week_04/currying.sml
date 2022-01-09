(* old way to get the effect of multiple arguments *)
fun sorted3_tupled (x,y,z) = z >= y andalso y >= x;

val t1 = sorted3_tupled (7,9,11)

(* new way currying *)
val sorted3 = fn x => fn y => fn z => z >= y andalso y >= x;

val t2 = ((sorted 7) 9) 11;
val t3 = sorted 7 9 11;

fun sorted3_nicer x y z = z >= y andalso y >= x;
val t4 = sorted3_nicer 7 9 11;

fun fold f acc xs = 
    case xs of
        [] => acc
        | x::xs' => fold f (f(acc, x)) xs';
