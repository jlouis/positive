-module(positive_SUITE).

-export([all/0]).
-export([is_positive_test/1
	   , is_negative_test/1
	   , is_not_integer_test/1
	   , 'is_really?_positive_test'/1
	   , 'is_really?_negative_test'/1
	   , 'is_not_really?_integer_test'/1]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Common Test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

-spec ignored_funs() -> [atom()].
ignored_funs() ->
  [ module_info
  , init_per_suite
  , end_per_suite
  ].

-spec all() -> [atom()].
all() ->
  [Fun || {Fun, 1} <- module_info(exports),
          not lists:member(Fun, ignored_funs())].

-type config() :: proplists:proplist().
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Test cases
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

-spec is_positive_test(config()) -> _.
is_positive_test(Config) ->
  PositiveNumbers = lists:seq(1,1000000),
  Results = lists:map(fun positive:is_positive/1, PositiveNumbers),
  true = lists:all(fun(Bool) -> Bool == true end, Results),
  {comment, ""}.

-spec is_negative_test(config()) -> _.
is_negative_test(Config) ->
  NegativeNumbers = lists:seq(-1000000, -1),
  Results = lists:map(fun positive:is_positive/1, NegativeNumbers),
  true = lists:all(fun(Bool) -> Bool == false end, Results), 
  {comment, ""}.

-spec is_not_integer_test(config()) -> _.
is_not_integer_test(Config) ->
  Letters = lists:seq($A, $z),
  Tuples  = module_info(exports),
  Atoms   = [Fun || {Fun, 1} <- module_info(exports)],
  InputList = Letters ++ Tuples ++ Atoms,
  Results = lists:map(fun positive:is_positive/1, InputList),
  false   = lists:all(fun(Bool) -> Bool == true end, Results),
  {comment, ""}.

-spec 'is_really?_positive_test'(config()) -> _.
'is_really?_positive_test'(Config) ->
  PositiveNumbers = lists:seq(1,1000000),
  Results = lists:map(fun positive:'really?'/1, PositiveNumbers),
  true = lists:all(fun(Bool) -> Bool == true end, Results),
  {comment, ""}.

-spec 'is_really?_negative_test'(config()) -> _.
'is_really?_negative_test'(Config) ->
  NegativeNumbers = lists:seq(-1000000, -1),
  Results = lists:map(fun positive:'really?'/1, NegativeNumbers),
  true = lists:all(fun(Bool) -> Bool == false end, Results), 
  {comment, ""}.

-spec 'is_not_really?_integer_test'(config()) -> _.
'is_not_really?_integer_test'(Config) ->
  Letters = lists:seq($A, $z),
  Tuples  = module_info(exports),
  Atoms   = [Fun || {Fun, 1} <- module_info(exports)],
  InputList = Letters ++ Tuples ++ Atoms,
  Results = lists:map(fun positive:is_positive/1, InputList),
  false   = lists:all(fun(Bool) -> Bool == true end, Results),
  {comment, ""}.
