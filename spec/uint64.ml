#load "stdint.cma";;
#load "str.cma";;
open Stdint.Uint64;;
open Str;;
#use "spec/common.ml";;

describe "A 64-bit integer" do
  it "should be converted from strings correctly" do
    forall (string_of ~length:(fun () -> 19) digit) s .
      let str = replace_first (regexp "^0+") "" s in
      (to_string (of_string str)) should = str;
      (fun () -> (to_string (of_string ("3" ^ s)))) should raise_an_exception
  done
done
