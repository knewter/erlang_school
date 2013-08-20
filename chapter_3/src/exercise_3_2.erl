-module(exercise_3_2).
-export([create/1, reverse_create/1]).

-include_lib("eunit/include/eunit.hrl").

reverse_create(0) ->
    [];
reverse_create(Num) ->
    [Num|reverse_create(Num - 1)].

create(0) ->
    [];
create(N) ->
    create(N-1) ++ [N].

create_test() ->
    [1,2,3] = create(3).

reverse_create_test() ->
    [3,2,1] = reverse_create(3).
