fun n_times (f,n,x) = 
  if n=0
  then x
  else f (n_times(f, n-1, x));

(* unnecessary pooling of global scope *)
fun triple x = 3 * x;

fun triple_n_times (n,x) =
  n_times(triple, n, x);

(* unredable let expression *)
fun triple_n_times_v2 (n,x) =
  n_times(let fun triple x = 3*x in triple end, n, x);

(* anonymous function *)
fun triple_n_times_v3 (n,x) =
  n_times((fn x => 3*x), n, x);
