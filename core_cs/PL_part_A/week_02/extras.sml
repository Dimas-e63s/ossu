(* alternate : int list -> int *)
(* recieve the list of integers summ all of them by alternative sign *)
fun alternate (ints: int list) = 
  if null ints then 0
  else hd ints - alternate(tl ints);

alternate [1,2,3,4];

(* fn: list int -> (int * int) *)
(* receive the list of numbers --> should return tuple with min and max number *)

fun min_max (ls: int list) = 
  if null tl ls then let val num = hd ls in (num, num) end
  else
    let
      val exp = #1 min_max(tl ls);
      val head = hd ls;
      val min = if head > exp then exp else head;
      val max = if head < exp then exp else head;
    in
      (min, max)
    end;