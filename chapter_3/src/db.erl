-module(db).
-export([new/0, write/3, read/2, match/2, delete/2]).

-include_lib("eunit/include/eunit.hrl").

new() ->
    [].

write(Key, Value, State) ->
    [{Key,Value}] ++ State.

read(Key, [{Key, Value}|_]) ->
    {ok, Value};
read(Key, [_|T]) ->
    read(Key, T);
read(_, []) ->
    {error,instance}.
    
match(Value, [{Key, Value}|T]) ->
    match(Value, T, [Key]);
match(Value, [_|T]) ->
    match(Value, T);
match(_, []) ->
    [].
match(Value, TestList, ExistingResponse) ->
    ExistingResponse ++ match(Value, TestList).

delete(Key, State) ->
    delete(Key, State, []).
delete(_, [], ResponseState) ->
    ResponseState;
delete(Key, [{Key, _}|T], ResponseState) ->
    delete(Key, T, ResponseState);
delete(Key, [{NoMatchKey, NoMatchValue}|T], ResponseState) ->
    NewResponseState = ResponseState ++ [{NoMatchKey, NoMatchValue}],
    delete(Key, T, NewResponseState).

%%%% Tests %%%%

new_test() ->
    [] = new().

write_test() ->
    Db = new(),
    Db1 = write(francesco, london, Db),
    [{francesco,london}] = Db1,
    [{lelle,stockholm},{francesco,london}] = write(lelle, stockholm, Db1).

read_test() ->
    Db = new(),
    Db1 = write(francesco, london, Db),
    Db2 = write(lelle, stockholm, Db1),
    {ok,london} = read(francesco, Db2),
    {error,instance} = read(ola, Db2).

match_test() ->
    Db = new(),
    Db1 = write(francesco, london, Db),
    Db2 = write(lelle, stockholm, Db1),
    Db3 = write(joern, stockholm, Db2),
    [joern,lelle] = match(stockholm, Db3).

delete_test() ->
    Db = new(),
    Db1 = write(francesco, london, Db),
    Db2 = write(lelle, stockholm, Db1),
    Db3 = write(joern, stockholm, Db2),
    Db4 = delete(lelle, Db3),
    [joern] = match(stockholm, Db4).
