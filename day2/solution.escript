#!/usr/bin/env escript

main(_) -> 
    %% Part I
    checksum_solver(0, 0, #{}).

checksum_solver(Twos, Threes, Map) ->
    case io:get_chars("", 1) of
        "\n" -> checksum_solver(Twos + any_x(Map, 2, 1, 0), Threes + any_x(Map, 3, 1, 0), #{});
        eof -> io:fwrite("~B~n", [Twos * Threes]);
        Chr -> checksum_solver(Twos, Threes, maps:update_with(Chr, fun(V) -> V + 1 end, 1, Map))
    end.

any_x(Map, X, IfTrue, IfFalse) ->
    Fun = fun
        (_,V,_) when V == X -> IfTrue;
        (_,_,AccIn) -> AccIn
    end,
    maps:fold(Fun, IfFalse, Map).