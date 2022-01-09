(* date --> int * int * int 
   - int year -> positive year
   - int month -> [1, 12]
   - int day -> [1, 31]
 *)

(* Date * Date -> bool *)
(* recieves two dates and check if one is greater than second *)

(*(check-example is_older((1998, 2, 23), (1997, 2, 23)));
(check-example is_older((1998, 3, 23), (1998, 2, 23)));
(check-example is_older((1998, 2, 25), (1998, 2, 23)));
(check-example is_older((1998, 2, 23), (1998, 2, 23)));
(check-example is_older((1998, 2, 23), (1999, 2, 23)));
 *)

fun is_equal (date1 : int * int * int, date2 : int * int * int) =
    (#1 date1 = #1 date2) andalso (#2 date1 = #2 date2) andalso (#3 date1 = #3 date2);

fun is_older (date1 : int * int * int, date2 : int * int * int) =
    if is_equal (date1, date2)
    then false
    else (#1 date1 <= #1 date2) andalso (#2 date1 <= #2 date2) andalso (#3 date1 <= #3 date2);

(* fn : (int * int * int) list * int -> int  *)
(* recieve list of dates and month and on calculate how many month in the list  *)
fun number_in_month(dates: (int * int * int) list, month: int) =
    if null dates
    then 0
    else
	let
	    val x = if (#2(hd dates))=month then 1 else 0
	in
	    x + number_in_month(tl dates, month)
	end;

(* fn : (int * int * int) list * int list -> int *)
(* recieve the list of dates, the list of months and return the number of months*)
(* number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3 *)
(* number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[1]) = 0 *)
fun number_in_months (dates: (int * int * int) list, months: int list) =
    if null dates orelse null months
    then 0
    else number_in_month(dates, hd months) + number_in_months(dates, tl months);

(* fn : (int * int * int) list * int -> (int * int * int) list *)
(* given the list of dates and the month and return the list of dates in order they occur *)

fun dates_in_month (dates: (int * int * int) list, month: int) =
    if null dates
    then []
    else if (#2(hd dates))=month
    then  (hd dates)::dates_in_month(tl dates, month)
    else
        dates_in_month(tl dates, month);	

(* = fn : (int * int * int) list * int list -> (int * int * int) list *)
(* given the list of dates and the list of months -- return list of dates in chronological order *)
fun dates_in_months (dates: (int * int * int) list, months: int list) =
    if null months orelse null dates
    then []
    else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months);

(* = fn : string list * int -> string *)
(* given the list of strings and index -- return the string by index *)
fun get_nth (strings: string list, idx: int) =
    if idx=1
    then hd strings
    else get_nth(tl strings, idx - 1);

(* fn: Date -> string *)
(* given the Date object produce Date formated to a string  *)
fun date_to_string (date: int * int * int) =
    let
	val months = ["January", "February", "March", "April",
		      "May", "June", "July", "August", "September", "October", "November", "December"]
    in
	get_nth(months, #2 date)^" "^Int.toString(#3 date)^", "^Int.toString(#1 date)
    end;

(* fn : int * int list -> int  *)
(* given sum and  *)
fun number_before_reaching_sum (sum : int, values : int list) =
    let
        fun iterate_sum (i : int, sum_stop : int, max : int, v : int list) =
            if sum_stop + hd v >= max
            then i - 1
            else iterate_sum (i + 1, sum_stop + hd v, max, tl v)
    in 
        iterate_sum (1, 0, sum, values)
    end;

(*  fn : int -> int  *)
(* given the sum of the days return the month *)
fun what_month (sum: int) =
    let
	val months_sum = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
	number_before_reaching_sum(sum, months_sum) + 1
    end;

(* fn : int * int -> int list *)
(* given two days as int and return the list of month between day1 and day2  *)
fun month_range(day1: int, day2: int) =
    if day1 > day2
    then []
    else what_month(day1)::month_range(day1 + 1, day2);

(* fn: Dates list -> Date option  *)
(* given the list of Dates and evaluates to SOME d or NONE d if there is no dates *)
fun oldest (dates: (int * int * int) list) =
    if null dates
    then NONE
    else
	let fun get_oldest(dates: (int * int * int) list) =
		if null (tl dates)
	        then hd dates
		else
		    let
			val last = get_oldest(tl dates)
			val first = hd dates
		    in
			if is_older (first, last)
			then first
			else last
		    end
	in
	    SOME (get_oldest dates)
	end
