#load "stdint.cma";;
#load "str.cma";;
open Stdint.Uint128;;
#use "spec/common.ml";;

describe "A 128-bit integer" do
  it "should be converted from strings correctly" do
    forall (string_of ~length:(fun () -> 38) digit) s .
      let str = Str.replace_first (Str.regexp "^0+") "" s in
      (to_string (of_string str)) should = str;
      (fun () -> of_string ("4" ^ s)) should raise_an_exception
  done;
  it "...even when sign is present" do
    forall (string_of ~length:(fun () -> 38) digit) s .
      let str = Str.replace_first (Str.regexp "^0+") "" s in
      (to_string (of_string ("+" ^ str))) should = str;
  done;
done
