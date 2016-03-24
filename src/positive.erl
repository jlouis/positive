-module(positive).
-export([is_positive/1]).

is_positive(N) when is_integer(N) ->
    N > 0;
is_positive(_) -> false.
