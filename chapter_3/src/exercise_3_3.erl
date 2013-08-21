-module(exercise_3_3).
-export([print_integers_to/1, print_even_integers_to/1]).

-include_lib("eunit/include/eunit.hrl").

print_integers_to(N) ->
    io:format("Number:~p~n", [integers_to(N)]).

print_even_integers_to(N) ->
    io:format("Number:~p~n", [even_integers_to(N)]).

integers_to(1) ->
    [1];
integers_to(N) ->
    integers_to(N-1) ++ [N].

even_integers_to(1) ->
    [];
even_integers_to(N) when(N rem 2 == 0) ->
    even_integers_to(N-1) ++ [N];
even_integers_to(N) when(N rem 2 == 1) ->
    even_integers_to(N-1).

integers_to_test() ->
    [1,2,3] = integers_to(3),
    [1] = integers_to(1).

even_integers_to_test() ->
    [2,4,6] = even_integers_to(7),
    [] = even_integers_to(1).
