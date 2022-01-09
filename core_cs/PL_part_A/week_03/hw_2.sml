(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)
(* string * string list -> NONE | SOME [] *)
(* given the string and the list -- returns SOME without string or NONE*)
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

(* string list list * string --> list *)
(* given the list of list of strings and substitution, and return the list with all substitutuion *)
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
    end
;

(* string list list * {first:string,middle:string,last:string} --> {first:string,middle:string,last:string} list *)
(* given the list of list of string and record with the following structure -->  return the list of all that can produce by substituting fot the fitst name*)
fun similar_names(xs: string list list, {first=f, middle=m, last=l}) = 
    let fun map_to_full_name(xs, acc) =
        case xs of
          [] => acc
          | h::xs' => map_to_full_name(xs', {name=h, middle=m, last= l}::acc)
        val arr = get_substitutions2(xs, #first full_name)
    in
        map_to_full_name(arr, [])
    end;
similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],
{first="Fred", middle="W", last="Smith"});

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 
val held_card = []
exception IllegalMove

(* put your solutions for problem 2 here *)
(*  card --> Color *)
fun card_color (c: card) = 
  case c of
     (Clubs, _) => Black
     | (Spades, _) => Black
     | (Diamonds, _) => Red
     | (Hearts, _) => Red;

(* card -> Number *)
(* given the card return the value *)
fun card_value (c : card) =
    case c of
        (_, Num i) => i
      | (_, Ace) => 11
      | _ => 10;

(* card list * card * exception *)
(* given the list of card, card and exception 
  return a list of cards without card
  if card is there more than once remove first value
  if no card in the list raise exception
 *)

   (* iterate thorighout list *)
   (* check if card equal to provided *)
   (* if yes remove *)
   (* go ahead *)
   (* if it go more than once, ignore *)
   (* otherwise raise exception *)
 fun remove_card(cs: card list, c: card, e: exn) = 
   case cs of
      [] => raise e
    | h::cs' => if h=c then cs' else h::remove_card(cs', c, e);

(* car list --> bool *)
(* given the list of cards an return true if all colors are the same *)
(* fun all_same_color (cs: card list) = 
  case cs of
     [] => false
   | h::xs' => let fun compare(cs: card list, c) =
                    case cs of
                       [] => true
                     | h::xs' => if (card_color(h) = card(c)) then compare(xs', c) else false
                in
                  compare(xs', h)
                end; *)
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

(* card list -> int *)
(* given the card list return the sum of all values
  Hint: use local helper function
  Hint 2: use existing function
 *)

fun sum_cards(cs: card list) = 
  let fun sum(xs, acc) = 
    case xs of
       [] => acc
     | h::xs' => sum(xs', card_value(h) + acc)
  in 
    sum(cs, 0)
  end;

(* card list * move list * int --> int *)
(*
  held-cards --> []
  if move list is [] --> stop
  if discard card --> held card without card OR IllegalMove
  if draws AND card-list is [] --> game over
  else if drawing sum > goal --> game over
  else LARGER held-cards and LESS card-list
*)

(*
  use remove_card and add to held card

  DRAW --> remove first card from card list 
  DISCARD --> remove selected card
*)

(*
  GAME ENDS when
   - no more moves
   - sum of held cards > goal
*)

(*
  GOAL
  - if sum > goal == (sum - goal) * 3
  - else goal - sum
  - else if all_colors_the_same sum / 2
*)

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

officiate([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         42);