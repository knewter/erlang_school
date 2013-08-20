-module(exercise_3_1).
-export([sum/1]).

-include_lib("eunit/include/eunit.hrl").

sum(0) ->
    0;
sum(1) ->
    1;
sum(Num) ->
    Num + sum(Num - 1).
sum(M, N) ->
    sum(N) - sum(M-1).

sum1_test() ->
    15 = sum(5),
    3 = sum(2).

sum2_test() ->
    6 = sum(1, 3),
    6 = sum(6, 6).
