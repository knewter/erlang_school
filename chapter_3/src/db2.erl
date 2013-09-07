-module(db2).
-export([new/0, write/3, read/2, match/2, delete/2]).

-include_lib("eunit/include/eunit.hrl").

new() ->
    [].

write(Key, Value, State) ->
    [{Key,Value}] ++ State.

read(Key, State) ->
    case lists:keyfind(Key, 1, State) of
        {Key, Value} -> {ok, Value};
        false -> {error, instance}
    end.

match(SearchTerm, State) ->
    lists:filtermap(
        fun({Key, Value}) ->
            case SearchTerm == Value of
                true -> {true, Key};
                false -> false
            end
        end,
        State
     ).

delete(DeleteKey, State) ->
    lists:filtermap(
        fun({Key, Value}) ->
            case DeleteKey == Key of
                true -> false;
                false -> {true, {Key, Value}}
            end
        end,
        State
     ).

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
