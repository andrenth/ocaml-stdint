#load "stdint.cma";;
#load "str.cma";;
open Stdint.Int128;;
#use "spec/common.ml";;

describe "A signed 128-bit integer" do
  it "should be converted from strings correctly" do
    (* Note: this would fail if the string was only 0s *)
    forall (string_of ~length:(fun () -> 38) digit) s .
      let str = Str.replace_first (Str.regexp "^0+") "" s in
      (to_string (of_string str)) should = str;
      (fun () -> (to_string (of_string ("2" ^ s)))) should raise_an_exception
  it "...even when sign is present" do
    forall (string_of ~length:(fun () -> 38) digit) s .
      let str = Str.replace_first (Str.regexp "^0+") "" s in
      (to_string (of_string ("+" ^ str))) should = str;
  done;
  it "...even for negative values" do
    forall (string_of ~length:(fun () -> 38) digit) s .
      let str = "-" ^ Str.replace_first (Str.regexp "^0+") "" s in
      (to_string (of_string str)) should = str;
  done;
done
