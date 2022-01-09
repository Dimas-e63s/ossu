fun same_string(s1 : string, s2 : string) =
    s1 = s2

fun all_except_option (s, xs) =
    let fun iterate(n, acc) =
        case n of
           [] => acc
         | h::n' => if same_string(h, s)
                    then iterate(n', acc)
                    else iterate(n', h::acc)
        val res = iterate(xs, [])
    in
        if res=xs then NONE else SOME res
    end;

fun get_substitutions1(xs: string list list, subst: string) = 
    case xs of
       [] => []
     | h::xs' => case all_except_option(subst, h) of
                NONE => get_substitutions1(xs', subst)
            | SOME z => z @ get_substitutions1(xs', subst)
;

fun get_substitutions2(xs: string list list, subst: string) = 
    let fun helper(xs) =
        case xs of
        [] => []
        | h::xs' => case all_except_option(subst, h) of
                    NONE => get_substitutions1(xs', subst)
                | SOME z => z @ get_substitutions1(xs', subst)
    in 
        helper(xs)
    end;

fun similar_names(xs: string list list, {first=f, middle=m, last=l}) = 
    let fun map_to_full_name(xs, acc) =
        case xs of
          [] => acc
          | h::xs' => map_to_full_name(xs', {name=h, middle=m, last= l}::acc)
        val arr = get_substitutions2(xs, f)
    in
        map_to_full_name(arr, [])
    end;

datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 
val held_card = []
exception IllegalMove

fun card_color (c: card) = 
  case c of
     (Clubs, _) => Black
     | (Spades, _) => Black
     | (Diamonds, _) => Red
     | (Hearts, _) => Red;

fun card_value (c : card) =
    case c of
        (_, Num i) => i
      | (_, Ace) => 11
      | _ => 10;

fun remove_card(cs: card list, c: card, e: exn) = 
   case cs of
      [] => raise e
    | h::cs' => if h=c then cs' else h::remove_card(cs', c, e);

fun all_same_color(cs: card list) =
  case cs of
     [] => false
   | h::xs' => let fun compare(cs: card list, c: card) = 
                case cs of
                   [] => true
                 | h::xs' => if(card_color(h)=card_color(c)) then compare(xs', c) else false
                in
                  compare(xs', h)
                end;

fun sum_cards(cs: card list) = 
  let fun sum(xs, acc) = 
    case xs of
       [] => acc
     | h::xs' => sum(xs', card_value(h) + acc)
  in 
    sum(cs, 0)
  end;

fun calculate_score(hs: card list, goal: int) = 
  let val sum = sum_cards hs
      val prelim_score = if sum > goal then ((sum - goal) * 3) else goal - sum
  in
    if all_same_color hs then prelim_score div 2 else prelim_score
  end;

fun officiate(cs: card list, ms: move list, goal: int) =
  let fun make_move(mv: move list, cs: card list, hs: card list) = 
    case mv of
        [] => calculate_score (hs, goal)
        | m::ms => case cs of
                      [] => calculate_score (hs, goal)
                      | x::xs' => if sum_cards hs >= goal 
                                then make_move([], cs, hs) 
                                else 
                                    case m of
                                      Draw => make_move(ms, remove_card(cs, x, IllegalMove), x::hs)
                                    | Discard c => make_move(ms, remove_card(cs, c, IllegalMove), c::hs)
  in 
    make_move(ms, cs, [])
  end;