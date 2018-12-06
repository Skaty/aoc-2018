#!/usr/bin/env escript

% Part II Solution
main(_) ->
    Xs = get_strings([]),
    find_common([], Xs, sets:new(), 0).

get_strings(Xs) ->
    case io:fread("", "~s") of
        eof -> Xs;
        {ok, [Str]} -> get_strings([Str|Xs])
    end.

% Pos refers to the position of the character
% we want to "eliminate"
find_common(Xs, Ys, Set, Pos) ->
    case Ys of
        [] -> find_common([], lists:reverse(Xs), sets:new(), Pos + 1);
        [X | Rst] -> XFmt = without_n(Pos, [], X),
            case sets:is_element(XFmt, Set) of
                true -> io:fwrite("~B,~s~n", [Pos, XFmt]);
                false -> find_common([X | Xs], Rst, sets:add_element(XFmt, Set), Pos)
            end
    end.

% Weird nth-tail implementation
without_n(N, Front, [X | List]) ->
    case N of
        0 -> [Front | List];
        _ -> without_n(N - 1, [X | Front] , List)
    end.