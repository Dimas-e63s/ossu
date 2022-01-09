fun fact n = 
    let fun aux(n, acc) =
        if n=0
        then acc
        else aux(n-1,acc*n)
    in 
      aux(n,1)
    end;

val x = fact 3