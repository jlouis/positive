
-module(positive).
-export([is_positive/1, 'really?'/1, 'perhaps?'/1]).

%% @doc Checks whether an integer is positive or not.
-spec is_positive(any()) -> boolean().
is_positive(N) when is_integer(N) ->
    N > 0;
is_positive(_) -> false.

%% @doc Syntax sugar for is_positive/1.
-spec 'really?'(any()) -> boolean().
'really?'(N) ->
    is_positive(N).

%% @doc Optimized version of 'really?'/1 that uses heuristics
%% only use this when you are not 'really?' conceared about whether
%% a value is positive but just want to know if it 'perhaps?' is.
-spec 'perhaps?'(any()) -> true.
'perhaps?'(_N) when is_integer(_N) ->
    true;
'perhaps?'(_) ->
    false.
