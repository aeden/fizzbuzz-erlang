% Write a program that prints out the numbers from 1 through 100, but…
%  For numbers that are multiples of 3, print “Fizz” instead of the number.
%  For numbers that are multiples of 5, print “Buzz” instead of the number
%  For numbers that are multiples of both 3 and 5, print “FizzBuzz” instead of the number.
% That’s it!

-module(fizzbuzz).

-export([run/0]).

-include_lib("eunit/include/eunit.hrl").

run() -> run(1).

run(N) -> lists:foreach(fun(S) -> io:format("~s~n", [S]) end, run(N, [])).

run(N, Res) when N > 100 -> Res;
run(N, Res) when (N rem 3 =:= 0) and (N rem 5 =:= 0) -> run(N + 1, Res ++ ["FizzBuzz"]);
run(N, Res) when N rem 3 =:= 0 -> run(N + 1, Res ++ ["Fizz"]);
run(N, Res) when N rem 5 =:= 0 -> run(N + 1, Res ++ ["Buzz"]);
run(N, Res) -> run(N + 1, Res ++ [integer_to_list(N)]).

fizz_test() -> [1, 2, "Fizz"] = run(3, []).
