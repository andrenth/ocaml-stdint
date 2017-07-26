#load "stdint.cma";;
open Stdint.Uint32;;
#use "spec/common.ml";;

describe "An uint32" do
  it "should convert to/from an uint8 correctly" do
    forall (int_in_range 0 255) x .
      (Stdint.Uint8.of_int x |> of_uint8 |> to_int) should = x
  done;
done
