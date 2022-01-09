val x = 1;
   (* x -> 1 *)
fun f y = x + y;
   (* f -> exp *)
val x = 2;
  (* x -> 2 *)
val y = 3;
  (* y -> 3 *)
val z = f (x + y)
   (* z -> f (5) -> 6 *) 