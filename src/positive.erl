
-module(positive).
-export([is_positive/1, 'really?'/1]).

is_positive(N) when is_integer(N) ->
    N > 0;
is_positive(_) -> false.

'really?'(N) ->
    is_positive(N).
