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
      (fun () -> of_string ("3" ^ s)) should raise_an_exception
  done;
  it "should be converted from/to an ocaml positive integer losslessly" do
    (of_int 0 |> to_int) should = 0;
    let i = Pervasives.max_int |> Pervasives.pred in
    (of_int i |> to_int) should = i;
    (of_int Pervasives.max_int |> to_int) should = Pervasives.max_int;
  done
done
