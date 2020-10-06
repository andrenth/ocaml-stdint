module type TESTER =
sig
  val tests : QCheck.Test.t list
end

let skip name = QCheck.Test.make ~count:0 ~name
let test name = QCheck.Test.make ~count:10 ~name

module IntBounds (I : Stdint.Int) =
struct
  let mini, maxi =
    if I.(to_int max_int) = -1 then
      if I.(min_int < zero) then
        (* halved because int_range must be able to diff the two boundaries *)
        min_int/2, max_int/2
      else
        0, max_int
    else
      I.(to_int min_int),
      I.(to_int max_int)

  let () = assert (mini < maxi)

  let in_range = QCheck.int_range mini maxi
  let pos_int = QCheck.map_same_type abs in_range
  let in_range_float =
    QCheck.float_range (float_of_int mini) (float_of_int maxi)
end

module Tester (I : Stdint.Int) : TESTER =
struct
  include IntBounds (I)

  let ( *** ) = ( * )  (* Preserve int mul for later use *)

  open I

  let tests = [
    QCheck.Test.make ~count:1 ~name:"Maximum value is greater than minimum"
      QCheck.unit (fun () -> min_int < max_int) ;

    test "An integer should not modify an int when converted"
      in_range (fun x -> to_int (of_int x) = x) ;

    test "An integer should not modify strings when converted"
      in_range (fun x -> to_string (of_int x) = string_of_int x) ;

    test "An integer should perform logical and correctly"
      (QCheck.pair pos_int pos_int) (fun (x, y) ->
        to_int (logand (of_int x) (of_int y)) = x land y) ;

    test "An integer should perform logical or correctly"
      (QCheck.pair pos_int pos_int) (fun (x, y) ->
        to_int (logor (of_int x) (of_int y)) = x lor y) ;

    test "An integer should perform logical xor correctly"
      (QCheck.pair pos_int pos_int) (fun (x, y) ->
        to_int (logxor (of_int x) (of_int y)) = x lxor y) ;

    test "An integer should perform logical not correctly"
      pos_int (fun x -> lognot (of_int x) = of_int (lnot x)) ;

    test "An integer should perform left-shifts correctly"
      QCheck.(pair in_range (int_bound 31)) (fun (x, y) ->
        shift_left (of_int x) y = of_int (x lsl y)) ;

    test "An integer should perform right-shifts correctly"
      QCheck.(pair in_range (int_bound 31)) (fun (x, y) ->
        shift_right (of_int x) y = of_int (x asr y)) ;

    test "Arithmetic shifts must sign-extend"
      QCheck.(int_range 0 200) (fun i ->
        let v = shift_right min_int i in
        (compare min_int zero) *** (compare v zero) >= 0) ;

    test "Logical shifts must not sign-extend"
      QCheck.(int_range 0 200) (fun i ->
        let v = shift_right_logical min_int i in
        compare v zero >= 0) ;

    test "An integer should perform float conversions correctly"
      in_range_float (fun x ->
        to_float (of_float x) = float_of_int (int_of_float x)) ;
  ]
end

module Tester2 (I1 : Stdint.Int) (I2 : Stdint.Int)
               (C : sig val of_i2 : I2.t -> I1.t end) : TESTER =
struct
  let mini, maxi =
    if I2.(to_int max_int) = -1 then
      if I2.(min_int < zero) then
        min_int, max_int
      else
        0, max_int
    else
      I2.(to_int min_int),
      I2.(to_int max_int)

  open I1

  let tests = [
    test "Conversion to/from a smaller integer"
      QCheck.(int_range mini maxi) (fun x ->
        I2.of_int x |> C.of_i2 |> to_int = x)
  ]
end

module OfStringTester (I : Stdint.Int) =
struct
  let max_str = I.(to_string max_int)
  let max_str_len = String.length max_str

  let integer_str_gen =
    QCheck.(string_gen_of_size (Gen.return max_str_len) Gen.numeral |>
              map_same_type (fun s ->
                if s <= max_str then s else String.sub s 1 (max_str_len - 1)))

  let str_gen =
    QCheck.pair integer_str_gen (
    QCheck.(string_gen_of_size (Gen.return 1) (Gen.oneofl ['k';'!'])))

  open I

  let tests = [
    test "An integer should be converted from strings correctly"
      integer_str_gen (fun s ->
        let str = Str.(replace_first (regexp "^0+") "" s) in
        to_string (of_string str) = str &&
        (try
          ignore (of_string ("9" ^ s)) ;
          false
        with e -> true)) ;

    test "An integer should be converted from signed (+) strings correctly"
      integer_str_gen (fun s ->
        let str = Str.(replace_first (regexp "^0+") "" s) in
        to_string (of_string ("+" ^ str)) = str) ;

    test "An integer should be converted from signed (-) strings correctly"
      integer_str_gen (fun s ->
        let str = "-" ^ Str.(replace_first (regexp "^0+") "" s) in
        min_int = zero ||
        to_string (of_string str) = str) ;

    test "An integer should be converted from strings with right offset correctly"
      str_gen (fun (i, s) ->
        let i_str = Str.(replace_first (regexp "^0+") "" i) in
        let str = i_str ^ s in
        let s, o = of_substring ~pos:0 str in
        to_string s = i_str && o = String.length i_str) ;
  ]
end

module SignTester (I : Stdint.Int) =
struct
  include IntBounds (I)

  open I

  let tests = [
    test "A signed integer should perform negation correctly"
      pos_int (fun x -> neg (of_int x) = of_int (~- x)) ;

    test "Neg is like multiply by minus one"
      in_range (fun x -> neg (of_int x) = mul (neg one) (of_int x)) ;

    test "One can print after neg"
      in_range (fun x -> mul (neg one) (of_int x) |> to_string = string_of_int ~-x) ;
  ]
end

let () =
  let ok = ref 0 and ko = ref 0 in

  let test_mods = Stdint.[
    "Int8", (module Tester (Int8) : TESTER) ;
    "Int16", (module Tester (Int16) : TESTER) ;
    "Int24", (module Tester (Int24) : TESTER) ;
    "Int32", (module Tester (Int32) : TESTER) ;
    "Int40", (module Tester (Int40) : TESTER) ;
    "Int48", (module Tester (Int48) : TESTER) ;
    "Int56", (module Tester (Int56) : TESTER) ;
    "Int64", (module Tester (Int64) : TESTER) ;
    "Int128", (module Tester (Int128) : TESTER) ;
    "Uint8", (module Tester (Uint8) : TESTER) ;
    "Uint16", (module Tester (Uint16) : TESTER) ;
    "Uint24", (module Tester (Uint24) : TESTER) ;
    "Uint32", (module Tester (Uint32) : TESTER) ;
    "Uint40", (module Tester (Uint40) : TESTER) ;
    "Uint48", (module Tester (Uint48) : TESTER) ;
    "Uint56", (module Tester (Uint56) : TESTER) ;
    "Uint64", (module Tester (Uint64) : TESTER) ;
    "Uint128", (module Tester (Uint128) : TESTER) ;

    "Uint16 x Uint8", (module Tester2 (Uint16) (Uint8) (struct let of_i2 = Uint16.of_uint8 end): TESTER) ;
    "Uint24 x Uint8", (module Tester2 (Uint24) (Uint8) (struct let of_i2 = Uint24.of_uint8 end): TESTER) ;
    "Uint32 x Uint8", (module Tester2 (Uint32) (Uint8) (struct let of_i2 = Uint32.of_uint8 end): TESTER) ;
    "Uint40 x Uint8", (module Tester2 (Uint40) (Uint8) (struct let of_i2 = Uint40.of_uint8 end): TESTER) ;
    "Uint48 x Uint8", (module Tester2 (Uint48) (Uint8) (struct let of_i2 = Uint48.of_uint8 end): TESTER) ;
    "Uint56 x Uint8", (module Tester2 (Uint56) (Uint8) (struct let of_i2 = Uint56.of_uint8 end): TESTER) ;
    "Uint64 x Uint8", (module Tester2 (Uint64) (Uint8) (struct let of_i2 = Uint64.of_uint8 end): TESTER) ;
    "Uint128 x Uint8", (module Tester2 (Uint128) (Uint8) (struct let of_i2 = Uint128.of_uint8 end): TESTER) ;
    "Int16 x Uint8", (module Tester2 (Int16) (Uint8) (struct let of_i2 = Int16.of_uint8 end): TESTER) ;
    "Int24 x Uint8", (module Tester2 (Int24) (Uint8) (struct let of_i2 = Int24.of_uint8 end): TESTER) ;
    "Int32 x Uint8", (module Tester2 (Int32) (Uint8) (struct let of_i2 = Int32.of_uint8 end): TESTER) ;
    "Int40 x Uint8", (module Tester2 (Int40) (Uint8) (struct let of_i2 = Int40.of_uint8 end): TESTER) ;
    "Int48 x Uint8", (module Tester2 (Int48) (Uint8) (struct let of_i2 = Int48.of_uint8 end): TESTER) ;
    "Int56 x Uint8", (module Tester2 (Int56) (Uint8) (struct let of_i2 = Int56.of_uint8 end): TESTER) ;
    "Int64 x Uint8", (module Tester2 (Int64) (Uint8) (struct let of_i2 = Int64.of_uint8 end): TESTER) ;
    "Int128 x Uint8", (module Tester2 (Int128) (Uint8) (struct let of_i2 = Int128.of_uint8 end): TESTER) ;

    "Uint24 x Uint16", (module Tester2 (Uint24) (Uint16) (struct let of_i2 = Uint24.of_uint16 end): TESTER) ;
    "Uint32 x Uint16", (module Tester2 (Uint32) (Uint16) (struct let of_i2 = Uint32.of_uint16 end): TESTER) ;
    "Uint40 x Uint16", (module Tester2 (Uint40) (Uint16) (struct let of_i2 = Uint40.of_uint16 end): TESTER) ;
    "Uint48 x Uint16", (module Tester2 (Uint48) (Uint16) (struct let of_i2 = Uint48.of_uint16 end): TESTER) ;
    "Uint56 x Uint16", (module Tester2 (Uint56) (Uint16) (struct let of_i2 = Uint56.of_uint16 end): TESTER) ;
    "Uint64 x Uint16", (module Tester2 (Uint64) (Uint16) (struct let of_i2 = Uint64.of_uint16 end): TESTER) ;
    "Uint128 x Uint16", (module Tester2 (Uint128) (Uint16) (struct let of_i2 = Uint128.of_uint16 end): TESTER) ;
    "Int24 x Uint16", (module Tester2 (Int24) (Uint16) (struct let of_i2 = Int24.of_uint16 end): TESTER) ;
    "Int32 x Uint16", (module Tester2 (Int32) (Uint16) (struct let of_i2 = Int32.of_uint16 end): TESTER) ;
    "Int40 x Uint16", (module Tester2 (Int40) (Uint16) (struct let of_i2 = Int40.of_uint16 end): TESTER) ;
    "Int48 x Uint16", (module Tester2 (Int48) (Uint16) (struct let of_i2 = Int48.of_uint16 end): TESTER) ;
    "Int56 x Uint16", (module Tester2 (Int56) (Uint16) (struct let of_i2 = Int56.of_uint16 end): TESTER) ;
    "Int64 x Uint16", (module Tester2 (Int64) (Uint16) (struct let of_i2 = Int64.of_uint16 end): TESTER) ;
    "Int128 x Uint16", (module Tester2 (Int128) (Uint16) (struct let of_i2 = Int128.of_uint16 end): TESTER) ;

    "Uint32 x Uint24", (module Tester2 (Uint32) (Uint24) (struct let of_i2 = Uint32.of_uint24 end): TESTER) ;
    "Uint40 x Uint24", (module Tester2 (Uint40) (Uint24) (struct let of_i2 = Uint40.of_uint24 end): TESTER) ;
    "Uint48 x Uint24", (module Tester2 (Uint48) (Uint24) (struct let of_i2 = Uint48.of_uint24 end): TESTER) ;
    "Uint56 x Uint24", (module Tester2 (Uint56) (Uint24) (struct let of_i2 = Uint56.of_uint24 end): TESTER) ;
    "Uint64 x Uint24", (module Tester2 (Uint64) (Uint24) (struct let of_i2 = Uint64.of_uint24 end): TESTER) ;
    "Uint128 x Uint24", (module Tester2 (Uint128) (Uint24) (struct let of_i2 = Uint128.of_uint24 end): TESTER) ;
    "Int32 x Uint24", (module Tester2 (Int32) (Uint24) (struct let of_i2 = Int32.of_uint24 end): TESTER) ;
    "Int40 x Uint24", (module Tester2 (Int40) (Uint24) (struct let of_i2 = Int40.of_uint24 end): TESTER) ;
    "Int48 x Uint24", (module Tester2 (Int48) (Uint24) (struct let of_i2 = Int48.of_uint24 end): TESTER) ;
    "Int56 x Uint24", (module Tester2 (Int56) (Uint24) (struct let of_i2 = Int56.of_uint24 end): TESTER) ;
    "Int64 x Uint24", (module Tester2 (Int64) (Uint24) (struct let of_i2 = Int64.of_uint24 end): TESTER) ;
    "Int128 x Uint24", (module Tester2 (Int128) (Uint24) (struct let of_i2 = Int128.of_uint24 end): TESTER) ;

    "Uint40 x Uint32", (module Tester2 (Uint40) (Uint32) (struct let of_i2 = Uint40.of_uint32 end): TESTER) ;
    "Uint48 x Uint32", (module Tester2 (Uint48) (Uint32) (struct let of_i2 = Uint48.of_uint32 end): TESTER) ;
    "Uint56 x Uint32", (module Tester2 (Uint56) (Uint32) (struct let of_i2 = Uint56.of_uint32 end): TESTER) ;
    "Uint64 x Uint32", (module Tester2 (Uint64) (Uint32) (struct let of_i2 = Uint64.of_uint32 end): TESTER) ;
    "Uint128 x Uint32", (module Tester2 (Uint128) (Uint32) (struct let of_i2 = Uint128.of_uint32 end): TESTER) ;
    "Int40 x Uint32", (module Tester2 (Int40) (Uint32) (struct let of_i2 = Int40.of_uint32 end): TESTER) ;
    "Int48 x Uint32", (module Tester2 (Int48) (Uint32) (struct let of_i2 = Int48.of_uint32 end): TESTER) ;
    "Int56 x Uint32", (module Tester2 (Int56) (Uint32) (struct let of_i2 = Int56.of_uint32 end): TESTER) ;
    "Int64 x Uint32", (module Tester2 (Int64) (Uint32) (struct let of_i2 = Int64.of_uint32 end): TESTER) ;
    "Int128 x Uint32", (module Tester2 (Int128) (Uint32) (struct let of_i2 = Int128.of_uint32 end): TESTER) ;

    "Uint48 x Uint40", (module Tester2 (Uint48) (Uint40) (struct let of_i2 = Uint48.of_uint40 end): TESTER) ;
    "Uint56 x Uint40", (module Tester2 (Uint56) (Uint40) (struct let of_i2 = Uint56.of_uint40 end): TESTER) ;
    "Uint64 x Uint40", (module Tester2 (Uint64) (Uint40) (struct let of_i2 = Uint64.of_uint40 end): TESTER) ;
    "Uint128 x Uint40", (module Tester2 (Uint128) (Uint40) (struct let of_i2 = Uint128.of_uint40 end): TESTER) ;
    "Int48 x Uint40", (module Tester2 (Int48) (Uint40) (struct let of_i2 = Int48.of_uint40 end): TESTER) ;
    "Int56 x Uint40", (module Tester2 (Int56) (Uint40) (struct let of_i2 = Int56.of_uint40 end): TESTER) ;
    "Int64 x Uint40", (module Tester2 (Int64) (Uint40) (struct let of_i2 = Int64.of_uint40 end): TESTER) ;
    "Int128 x Uint40", (module Tester2 (Int128) (Uint40) (struct let of_i2 = Int128.of_uint40 end): TESTER) ;

    "Uint56 x Uint48", (module Tester2 (Uint56) (Uint48) (struct let of_i2 = Uint56.of_uint48 end): TESTER) ;
    "Uint64 x Uint48", (module Tester2 (Uint64) (Uint48) (struct let of_i2 = Uint64.of_uint48 end): TESTER) ;
    "Uint128 x Uint48", (module Tester2 (Uint128) (Uint48) (struct let of_i2 = Uint128.of_uint48 end): TESTER) ;
    "Int56 x Uint48", (module Tester2 (Int56) (Uint48) (struct let of_i2 = Int56.of_uint48 end): TESTER) ;
    "Int64 x Uint48", (module Tester2 (Int64) (Uint48) (struct let of_i2 = Int64.of_uint48 end): TESTER) ;
    "Int128 x Uint48", (module Tester2 (Int128) (Uint48) (struct let of_i2 = Int128.of_uint48 end): TESTER) ;

    "Uint64 x Uint56", (module Tester2 (Uint64) (Uint56) (struct let of_i2 = Uint64.of_uint56 end): TESTER) ;
    "Uint128 x Uint56", (module Tester2 (Uint128) (Uint56) (struct let of_i2 = Uint128.of_uint56 end): TESTER) ;
    "Int64 x Uint56", (module Tester2 (Int64) (Uint56) (struct let of_i2 = Int64.of_uint56 end): TESTER) ;
    "Int128 x Uint56", (module Tester2 (Int128) (Uint56) (struct let of_i2 = Int128.of_uint56 end): TESTER) ;

    "Uint128 x Uint64", (module Tester2 (Uint128) (Uint64) (struct let of_i2 = Uint128.of_uint64 end): TESTER) ;
    "Int128 x Uint64", (module Tester2 (Int128) (Uint64) (struct let of_i2 = Int128.of_uint64 end): TESTER) ;

    "Uint8 strings", (module OfStringTester (Stdint.Uint8) : TESTER) ;
    "Int8 strings", (module OfStringTester (Stdint.Int8) : TESTER) ;
    "Uint16 strings", (module OfStringTester (Stdint.Uint16) : TESTER) ;
    "Int16 strings", (module OfStringTester (Stdint.Int16) : TESTER) ;
    "Uint24 strings", (module OfStringTester (Stdint.Uint24) : TESTER) ;
    "Int24 strings", (module OfStringTester (Stdint.Int24) : TESTER) ;
    "Uint32 strings", (module OfStringTester (Stdint.Uint32) : TESTER) ;
    "Int32 strings", (module OfStringTester (Stdint.Int32) : TESTER) ;
    "Uint40 strings", (module OfStringTester (Stdint.Uint40) : TESTER) ;
    "Int40 strings", (module OfStringTester (Stdint.Int40) : TESTER) ;
    "Uint48 strings", (module OfStringTester (Stdint.Uint48) : TESTER) ;
    "Int48 strings", (module OfStringTester (Stdint.Int48) : TESTER) ;
    "Uint56 strings", (module OfStringTester (Stdint.Uint56) : TESTER) ;
    "Int56 strings", (module OfStringTester (Stdint.Int56) : TESTER) ;
    "Uint64 strings", (module OfStringTester (Stdint.Uint64) : TESTER) ;
    "Int64 strings", (module OfStringTester (Stdint.Int64) : TESTER) ;
    "Uint128 strings", (module OfStringTester (Stdint.Uint128) : TESTER) ;
    "Int128 strings", (module OfStringTester (Stdint.Int128) : TESTER) ;

    "Int8 sign ops", (module SignTester (Stdint.Int8) : TESTER) ;
    "Int16 sign ops", (module SignTester (Stdint.Int16) : TESTER) ;
    "Int24 sign ops", (module SignTester (Stdint.Int24) : TESTER) ;
    "Int32 sign ops", (module SignTester (Stdint.Int32) : TESTER) ;
    "Int40 sign ops", (module SignTester (Stdint.Int40) : TESTER) ;
    "Int48 sign ops", (module SignTester (Stdint.Int48) : TESTER) ;
    "Int56 sign ops", (module SignTester (Stdint.Int56) : TESTER) ;
    "Int64 sign ops", (module SignTester (Stdint.Int64) : TESTER) ;
    "Int128 sign ops", (module SignTester (Stdint.Int128) : TESTER) ;
  ] in

  List.iter (fun (n, m) ->
    Printf.printf "\n== Testing %s ==\n" n ;
    let module T = (val m : TESTER) in

    List.iter (fun t ->
      try
        QCheck.Test.check_exn t ;
        incr ok
      with e ->
        print_string (Printexc.to_string e ^ "\n") ;
        incr ko
    ) T.tests
  ) test_mods ;

  if !ko = 0 then
    Printf.printf "%d/%d Ok\n" !ok !ok
  else (
    Printf.printf "%d/%d FAILURE\n" !ko (!ko + !ok) ;
    exit 1
  )
