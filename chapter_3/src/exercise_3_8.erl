-module(exercise_3_8).
-export([parse/1]).
-include_lib("eunit/include/eunit.hrl").

parse(Expression) ->
    extract_subexpressions(Expression).

extract_subexpressions(Expression) ->
    extract_subexpressions_open(Expression, 0, []).

extract_subexpressions_open(Expression, NestingLevel, Accum) ->
    OpenParen = lists:nth(1, "("),
    case Expression of
        [OpenParen|Rest] -> extract_subexpressions_close(Rest, NestingLevel+1, Accum);
        _ -> extract_addition(Expression)
    end.

extract_subexpressions_close(Expression, NestingLevel, Accum) ->
    CloseParen = lists:nth(1, ")"),
    case lists:reverse(Expression) of
        [CloseParen|Rest] -> extract_subexpressions_open(lists:reverse(Rest), NestingLevel-1, Accum);
        _ -> extract_subexpressions_open(Expression, NestingLevel, Accum)
    end.

extract_addition(Expression) ->
    Split = re:split(Expression, "[+]", [{return, list}]),
    case Split of
        [Left,Right] -> {plus, parse(Left), parse(Right)};
        [Expression] -> extract_subtraction(Expression)
    end.

extract_subtraction(Expression) ->
    Split = re:split(Expression, "[-]", [{return, list}]),
    case Split of
        [Left,Right] -> {minus, parse(Left), parse(Right)};
        [Expression] -> extract_number(Expression)
    end.

extract_number(Expression) ->
    Number = list_to_integer(Expression),
    {num, Number}.

%%% TEST %%%
%parser_test() ->
    %?assertEqual({num, 4}, parse("4")),
    %?assertEqual({num, 5}, parse("5")),
    %?assertEqual({num, 23}, parse("23")),
    %?assertEqual({plus, {num, 2}, {num, 3}}, parse("2+3")),
    %?assertEqual({minus, {num, 2}, {num, 3}}, parse("2-3")),
    %?assertEqual({plus, {num, 2}, {num, 3}}, parse("(2+3)")),
    %{plus, {plus, {num, 2}, {num,3}}, {num, 4}} = parse("((2+3)+4)"),
    %{minus, {plus, {num, 2}, {num,3}}, {num, 4}} = parse("((2+3)-4)").

%extract_subexpressions_test() ->
    %?assertEqual({plus, {num, 2}, {num, 3}}, extract_subexpressions("(2+3)")),
    %?assertEqual({plus, {num, 3}, {num, 4}}, extract_subexpressions("(3+4)")),
    %?assertEqual({plus, {num, 3}, {num, 4}}, extract_subexpressions("((3+4))")).

extract_number_test() ->
    ?assertEqual({num, 2}, extract_number("2")).
