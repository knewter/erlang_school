-module(exercise_3_5).
-export([filter/2, reverse/1, concatenate/1, flatten/1]).
-include_lib("eunit/include/eunit.hrl").

filter(List, UpTo) ->
    filter(List, UpTo, []).
filter([], _, Accum) ->
    Accum;
filter([H|T], UpTo, Accum) when(H =< UpTo) ->
    filter(T, UpTo, Accum ++ [H]);
filter([H|T], UpTo, Accum) when(H > UpTo) ->
    filter(T, UpTo, Accum).

reverse(List) ->
    reverse(List, []).
reverse([H|T], Accum) ->
    reverse(T, [H] ++ Accum);
reverse([], Accum) ->
    Accum.

concatenate(List) ->
    concatenate(List, []).
concatenate([H|T], Accum) ->
    concatenate(T, Accum ++ H);
concatenate([], Accum) ->
    Accum.

flatten(List) ->
    flatten(concatenate(List), []).
flatten([[H2|T2]|T], Accum) when(is_list(H2)) ->
    flatten(T, Accum ++ flatten(H2) ++ flatten(T2));
flatten([[H2|T2]|T], Accum) ->
    flatten(T, Accum ++ ([H2] ++ flatten(T2)));
flatten([H|T], Accum) ->
    flatten(T, Accum ++ [H]);
flatten([], Accum) ->
    Accum;
flatten(El, Accum) ->
    flatten([], Accum ++ [El]).

%%% TEST %%%

filter_test() ->
    [1,2,3] = filter([1,2,3,4,5], 3).

reverse_test() ->
    [3,2,1] = reverse([1,2,3]).

concatenate_test() ->
    [1,2,3,4,five] = concatenate([[1,2,3], [], [4,five]]).

flatten_test() ->
    [1,2,3,4,5,6] = flatten([[1,[2,[3],[]]], [[[4]]], [5,6]]).
