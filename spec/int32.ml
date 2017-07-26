#load "stdint.cma";;
open Stdint.Int32;;
#use "spec/common.ml";;

describe "An int32" do
  it "should convert to/from an uint8 correctly" do
    forall (int_in_range 0 255) x .
      (Stdint.Uint8.of_int x |> of_uint8 |> to_int) should = x
  done;
  it "should convert to/from an int8 correctly" do
    forall (int_in_range ~-128 127) x .
      (Stdint.Int8.of_int x |> of_int8 |> to_int) should = x
  done;
done
