fun hd xs = 
  case xs of
     [] => raise List.Empty
   | x::xs => x;

exception DevisiondByZero
exception MyUndesirableCondition

fun mydiv (x,y) = 
  if y=0
  then raise DevisiondByZero
  else z div y;

fun maxlist (xs, ex) = 
    case xs of
        [] => raise ex
        | x::[] => x
        | x::xs' => Int.max(x, maxlist(xs', ex));

val x = maxlist ([3,4,5], MyUndesirableCondition)
        handle MyUndesirableCondition => 42

val z = maxlist ([], MyUndesirableCondition)
        handle MyUndesirableCondition => 42