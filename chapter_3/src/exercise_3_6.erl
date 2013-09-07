-module(exercise_3_6).
-export([quicksort/1, mergesort/1]).
-include_lib("eunit/include/eunit.hrl").

quicksort(List) ->
    quicksort(List, []).
quicksort(List, SortingAttempt) when List == SortingAttempt ->
    List;
quicksort([H|T], _) ->
    Lesser = lists:filter(fun(X) -> X < H end, T),
    Greater = lists:filter(fun(X) -> X >= H end, T),
    quicksort(quicksort(Lesser) ++ [H] ++ quicksort(Greater), [H] ++ quicksort(Greater)).

mergesort(List) ->
    mergesort(List, []).
mergesort(List, _) when length(List) == 1 ->
    List;
mergesort(List, _) when length(List) == 2 ->
    [H|T] = List,
    case H < lists:nth(1, T) of
        true -> [H] ++ T;
        false -> T ++ [H]
    end;
mergesort(List, SortingAttempt) when List == SortingAttempt ->
    List;
mergesort(List, SortingAttempt) ->
    Halfish = (length(List) div 2),
    Left = lists:sublist(List, Halfish),
    Right = lists:sublist(List, Halfish + 1, Halfish + 1),
    merge(mergesort(Left), mergesort(Right)).

merge(Left, Right) ->
    merge(Left, Right, []).
merge(Left, Right, Acc) when (length(Left) == 0) and (length(Right) == 0) ->
    Acc;
merge(Left, Right, Acc) when (length(Left) > 0) and (length(Right) > 0) ->
    [FirstL|RestL] = Left,
    [FirstR|RestR] = Right,
    case FirstL =< FirstR of
        true -> merge(RestL, Right, Acc ++ [FirstL]);
        false -> merge(Left, RestR, Acc ++ [FirstR])
    end;
merge(Left, Right, Acc) when (length(Left) > 0) ->
    [FirstL|RestL] = Left,
    merge(RestL, Right, Acc ++ [FirstL]);
merge(Left, Right, Acc) when (length(Right) > 0) ->
    [FirstR|RestR] = Right,
    merge(Left, RestR, Acc ++ [FirstR]).

%%% TEST %%%
quicksort_test() ->
    % pathological case
    [1] = quicksort([1]),
    % slightly less pathological case, but still lolworthy
    [1,2] = quicksort([1,2]),
    % zomg, actual sorting
    [1,2] = quicksort([2,1]),
    % calm down nao
    [1,2,3] = quicksort([3,2,1]),
    % wat
    [1,2,3] = quicksort([1,3,2]),
    % magical I know
    [1,2,3,4,5,6,7,8,9] = quicksort([1,3,2,5,4,6,7,8,9]).

mergesort_test() ->
    % pathological case
    [1] = mergesort([1]),
    % slightly less pathological case, but still lolworthy
    [1,2] = mergesort([1,2]),
    % zomg, actual sorting
    [1,2] = mergesort([2,1]),
    % calm down nao
    [1,2,3,4] = mergesort([4,3,2,1]),
    % wat
    [1,2,3] = mergesort([1,3,2]),
    % magical I know
    [1,2,3,4,5,6,7,8,9] = mergesort([1,3,2,5,4,6,7,8,9]).
