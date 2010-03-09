#load "uint64.cma";;
#load "uint128.cma";;
#load "str.cma";;
open Uint128;;
#use "spec/common.ml";;

describe "A 128-bit integer" do
  it "should be converted from strings correctly" do
    forall (char_in_range '0' '2') d .
      forall (string_of ~length:(fun () -> 38) digit) s .
        let str = Str.replace_first (Str.regexp "^0+") "" s in
        (to_string (of_string str)) should = str;
        (fun () -> (to_string (of_string ("4" ^ s)))) should raise_an_exception
  done
done
