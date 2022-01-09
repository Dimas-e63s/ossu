fun times_until_zero (f,x) = 
  if x=0  then 0 else 1 + times_until_zero(f, f x);

fun len xs = 
    case xs of
        [] => 1
        | _::xs' => 1 + len xs';