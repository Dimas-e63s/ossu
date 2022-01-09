(* string list -> string list *)
(* given the list of strings retrun the list of strings, where all elements starts with upper case *)

fun only_capitals strs = 
    List.filter (fn x => Char.isUpper (String.sub (x, 0))) strs;

(* string list -> string list *)
(* given the list of strings return the longest string in the list *)


fun longest_string1 (strs: string list) = 
    List.foldl (fn (x,s) => if String.size x > String.size s then x else s) "" strs;

fun longest_string2 (strs: string list) = 
    List.foldl (fn (x,s) => if String.size x >= String.size s then x else s) "" strs;

fun longest_string_helper f ss = 
   List.foldl (fn (x, s) => if f(String.size x, String.size s) then x else s) "" ss;

fun longest_string3 strs = 
  longest_string_helper (fn (x, s) => x > s) strs;

fun longest_string4 strs = 
  longest_string_helper (fn (x, s) => x >= s) strs;

(* string list -> string *)
(*  given the list of string, return the longest string in the list started with the capitale letter *)
fun longest_capitalized (ss) = 
  (longest_string1 o only_capitals) ss;

(* string -> string  *)
(* given the string return the string in the reverse oreder *)
fun rev_str s =
  (String.implode o List.rev o String.explode) s;

(* (’a -> ’b option) -> ’a list -> ’b *)
(* given the function as first argument and list as second argument -- returns the list where f get applied for all elements of the list or return NONE *)
exception NoAnswer;
fun first_answer f xs =
    case xs of
        [] => raise NoAnswer
      | x::xs => case f(x) of
                     NONE => first_answer f xs
                   | SOME v => v;

fun all_answers f lst = 
  let
        fun f_int (f, lst, acc) = case lst of
                                      [] => SOME acc
                                    | x::xs => case f(x) of
                                                   NONE => NONE
                                                 | SOME v => f_int(f, xs, v @ acc)
    in
        f_int(f, lst, [])
    end;

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern;

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu;

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

fun count_wildcards p =
  g (fn v => 1) (fn v => 0) p;

count_wildcards(TupleP [ConstP 1, Wildcard, Wildcard])

fun count_wild_and_variable_lengths p = 
  g (fn v => 1) (fn v => String.size v) p;

fun count_some_var (s, p) = 
  g (fn v => 0) (fn v => if v=s then 1 else 0) p;

(* pattern --> boolean *)
(* given a pattern if all veriables are distinct return true *)

(* pattern -> string list *)
(* given the pattern return the list of all strings used for variables *)
(* Hint 1: first function takes a pattern and returns list of all strings used for a variable *)

(* string list --> boolean *)
(* given the list of strings and decide if it repeats *)
(* Hint 2: takes a list of strings and decide if strings are repeat *)

fun check_pat (p: pattern) = 
  let
    fun is_all_unique(ls: string list) = 
        case ls of
            [] => true
            | x::ls' => if []=ls' then true else not (List.exists (fn l => x=l) ls');
    fun p_to_list(p: pattern) = 
        case p of
            Variable x => [x]
            | TupleP ps => List.foldl (fn (v, vs) => vs @ p_to_list(v)) [] ps
            | ConstructorP(_, p) => p_to_list(p)
            | _ => [];
  in
    is_all_unique (p_to_list p)
  end;
  
(* valu * pattern  --> (string * valu) list option*)
fun match(v: valu, p: pattern) =
    case p of
        Variable x => SOME [(x, v)]
      | UnitP =>
        (case v of
             Unit => SOME []
           | _ => NONE)
      | Wildcard => SOME []
      | ConstP k =>
        (case v of
             Const(v) => if k = v then SOME [] else NONE
           | _ => NONE)
      | TupleP ps =>
        (case v of
             Tuple(vs) => if List.length vs = List.length ps
                          then all_answers match (ListPair.zip(vs, ps))
                          else NONE
           | _ => NONE)
      | ConstructorP(s1,pp) =>
        (case v of
             Constructor(s2,vv) =>
             if s1 = s2 then match(vv,pp) else NONE
           | _ => NONE)



(* valu -> pattern list --> (string * valu) list option *)
fun first_match v ps =
    SOME(first_answer (fn p => match(v, p)) ps) handle NoAnswer => NONE


