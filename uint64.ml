type uint64 = int64
type t = uint64

external add : uint64 -> uint64 -> uint64 = "%int64_add"
external sub : uint64 -> uint64 -> uint64 = "%int64_sub"
external mul : uint64 -> uint64 -> uint64 = "%int64_mul"
external logand : uint64 -> uint64 -> uint64 = "%int64_and"
external logor : uint64 -> uint64 -> uint64 = "%int64_or"
external logxor : uint64 -> uint64 -> uint64 = "%int64_xor"
external shift_left : uint64 -> int -> uint64 = "%int64_lsl"
external shift_right : uint64 -> int -> uint64 = "%int64_asr"
external of_int : int -> uint64 = "%int64_of_int"
external to_int : uint64 -> int = "%int64_to_int"
external of_int32 : int32 -> uint64 = "%int64_of_int32"
external to_int32 : uint64 -> int32 = "%int64_to_int32"
external of_float : float -> uint64 = "caml_int64_of_float"
external to_float : uint64 -> float = "caml_int64_to_float"
external bits_of_float : float -> uint64 = "caml_int64_bits_of_float"
external float_of_bits : uint64 -> float = "caml_int64_float_of_bits"

let of_int64 x = x
let to_int64 x = x

let zero = 0L
let one = 1L
let succ = add one
let pred = sub one
let max_int = -1L
let lognot = logxor max_int

let u_ge x y =
  if y < 0L && x >= 0L then false
  else if x < 0L && y >= 0L then true
  else x >= y

let divmod x y =
  let q = ref x in
  let r = ref 0L in
  for i = 0 to 63 do
    r := Int64.shift_left !r 1;
    if (!q < 0L) then r := Int64.add !r 1L;
    q := Int64.shift_left !q 1;
    if u_ge !r y then begin
      q := Int64.add !q 1L;
      r := Int64.sub !r y
    end
  done;
  !q, !r

let div x y = fst (divmod x y)
let rem x y = snd (divmod x y)

module Fmt = Fmt.Make(struct
  type t      = uint64
  let name    = "Uint64"
  let zero    = zero
  let max_int = max_int
  let of_int  = of_int
  let to_int  = to_int
  let add     = add
  let mul     = mul
  let divmod  = divmod
end)

let to_string = Fmt.to_string
let of_string = Fmt.of_string

let compare (x : t) (y : t) = Pervasives.compare x y
