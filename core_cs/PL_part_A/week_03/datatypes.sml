datatype mytype = TwoInts of int * int 
    | Str of string
    | Pizza;

val a = Str "hi";
val b = Str;
val c = Pizza;
val d = TwoInts(1+2, 3+4);
val e = a;


datatype my_int_list = Empty | Cons of int * my_int_list;

val x = Cons(4, Cons(23, Cons(2008, Empty)));

fun append_my_list (xs, ys) = 
case xs of
  Empty => ys
  | Cons (x, xs') => Cons(x, append_my_list(xs', ys));

fun incr_or_zero intoption = 
case intoption of
   NONE => 0
 | SOME i => i + 1;

fun sum_list xs = 
  case xs of
     [] => 0
   | x::xs' => x + sum_list xs';

fun append (xs, ys) = 
    case xs of
        [] => ys
        | x::xs' => x:: append(xs', ys);

append([1,2], [3]);