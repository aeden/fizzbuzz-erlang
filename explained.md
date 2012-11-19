# Explaining The Implementation

Lines 1 through 5 are simply comments explaining the exercise.

Line 7 defines the module which all of the functions live in. This is the only namespace mechanism we have and need.

Line 9 defines which functions are exported. Exported functions can be called using the syntax `module:function()`. Any function that is not exported is an internal private function to the module. Functions to export are defined as `function/arity`.

Line 11 includes the eunit library, the unit testing library in Erlang.

The entry function is `run()` on line 13. When this function is invoked it then calls `run(N)` where N is 1. This is an example of Erlang's pattern matching in functions.

The `run(N)` function on line 15 is matched when `run(1)` is invoked. This in turn uses lists:foreach on the list returned by `run(N, [])`. `lists:foreach` is used to invoke functions with side effects, which in this case is `io:format`. We'll come back to this in a bit after we've collected all of the values we that will be iterated over.

Moving on, `run(1, [])` is invoked to retrieve the list of items. Lines 17 through 21 define various versions of the `run(N, Res)` function. N is the current iteration and Res is the result collector list. Each of the functions except for 21 include a guard clause. When `run(1, [])` is invoked first line 17 will try to match, and will fail to do so because of the N > 100 guard. Next line 18 will try to match and fail (N rem =:= 0 is the same as N / 3 has a remainder of 0, which is false). 19 and 20 will also fail to match due to their guard clauses.

Finally we arrive at 19 which does match. N at this point is 1 and Res is an empty list. The function on line 19 recursively calls run(N, Res) with the value of N as 2 and the value of Res as [] with the array ["1"]. integer_to_list is a built-in function (also known as a BIF in Erlang land) and converts the integer 1 to a list. It is helpful to know at this point that in Erlang strings are just lists of integers, so [1] when used where a string is expected will become "1".

Next, `run(1, [])` calls `run(2, [[1]])`. We again go through the matching process in 17 through 21 and again end up matching on line 21. The expression in `run(2, [[1]])` next calls `run(3, [[1], [2]])`. At this point a different pattern is matched, specifically the pattern `run(N, Res) when N rem 3 =:= 0`. The body of this function also recursively calls run(N, Res), but it appends ["Fizz"] to the collector list. So the next call is `run(4, [[1], [2], ["Fizz"]])`.

This recursive behavior continues up until the point where line 17 matches (where N is greater than 100). At this point the function simply returns the Res collector. Now we can finish looking at line 15. `lists:foreach`'s first argument is a function that has an arity of 1. In this case an anonymous function is used. The function is called once for each item in the list returned from `run(N, [])` and the value is printed to stdout using the `io:format` function. The first argument of that function is the string with control sequences that are replaced with values from the second argument to the function. See http://erlang.org/doc/man/io.html#format-2 for the full list of control sequences.

And that's it. A tail recursive implementation of fizzbuzz in Erlang.

Side note about Erlang punctuation, here's one way to remember it:

    Comma AND
    Semicolon OR
    FullStop END

Also:

    A comma: "here is an expression, and here is an expression"
    A semicolon: "here is a pattern match, or here is a pattern match"
    A period: "end of this pattern match"
