-module(positive_eqc).

%% This module uses Erlang QuickCheck Mini for its work. This makes it possible to
%% use and test this freely without access to a full QuickCheck license. You can also
%% relatively easily adapt the code to PropEr or Triq if you want to do so.

-include_lib("eqc/include/eqc.hrl").

%% For convenience, it is often worth it to export everything from EQC modules:
-compile(export_all).

%% A bit is either 0 or 1:
bit() ->
    elements([1, 0]).
    
%% A string of bits is to generate a non-empty list of bits, and then form a bitstring:
bit_string() ->
    ?LET(Bits, non_empty(list(bit())),
        << <<X:1>> || X <- Bits >>).
        
%% Generate an integer based on a set of bits:
bit_integer() ->
    ?LET({Sign, BitStr}, {bit(), bit_string()},
        begin
           B = << Sign:1, BitStr/bitstring>>,
           Sz = bit_size(B),
           <<I:Sz/integer-signed>> = B,
           SignType = case Sign of
               0 -> pos;
               1 -> neg
           end,
           {SignType, I}
       end).

%% Identify the positive values as those which are positive, but not 0
positive_bits(pos, 0) -> false;
positive_bits(pos, _) -> true;
positive_bits(neg, _) -> false.

%% Main property:
prop_positive() ->
   ?FORALL({SignType, I}, bit_integer(),
      begin
          eq(positive_bits(SignType, I), positive:is_positive(I))
      end).

eq(X, X) -> true;
eq(X, Y) -> {X, '/=', Y}.
