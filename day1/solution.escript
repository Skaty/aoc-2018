#!/usr/bin/env escript

main(_) ->
    %% Does Part I
    Numbers = part_one([]),
    %% Does Part II
    part_two(lists:reverse(Numbers)).

part_one(Ns) -> read_tok(Ns, io:fread("", "~d")).

read_tok(Ns, eof) ->
    io:fwrite("~B~n", [lists:foldr(fun(X, Sum) -> X + Sum end, 0, Ns)]),
    Ns;
read_tok(Ns, {ok, [X]}) -> part_one([X|Ns]).

% Entry point for find_repeat
part_two(Ns) -> find_repeat([], Ns, sets:new(), 0).

% Recursive portion of find_repeat
find_repeat(Ss, [], MySet, N) -> find_repeat([], lists:reverse(Ss), MySet, N);
find_repeat(Ss, [Nn|Ns], MySet, N) ->
    case sets:is_element(N + Nn, MySet) of
        true -> io:fwrite("~B~n", [N + Nn]);
        false -> find_repeat([Nn | Ss], Ns, sets:add_element(N + Nn, MySet), N + Nn)
    end.