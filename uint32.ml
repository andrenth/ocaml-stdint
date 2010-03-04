type uint32 = int32
type t = uint32

external add : uint32 -> uint32 -> uint32 = "%int32_add"
external sub : uint32 -> uint32 -> uint32 = "%int32_sub"
external mul : uint32 -> uint32 -> uint32 = "%int32_mul"
external logand : uint32 -> uint32 -> uint32 = "%int32_and"
external logor : uint32 -> uint32 -> uint32 = "%int32_or"
external logxor : uint32 -> uint32 -> uint32 = "%int32_xor"
external shift_left : uint32 -> int -> uint32 = "%int32_lsl"
external shift_right : uint32 -> int -> uint32 = "%int32_asr"
external shift_right_logical : uint32 -> int -> uint32 = "%int32_lsr"
external of_int : int -> uint32 = "%int32_of_int"
external to_int : uint32 -> int = "%int32_to_int"
external of_float : float -> uint32 = "caml_int32_of_float"
external to_float : uint32 -> float = "caml_int32_to_float"
external bits_of_float : float -> uint32 = "caml_int32_bits_of_float"
external float_of_bits : uint32 -> float = "caml_int32_float_of_bits"

let zero = 0l
let one = 1l
let succ = add one
let pred = sub one
let max_int = -1l
let min_int = 0l
let lognot = logxor max_int

let of_int32 x = x
let to_int32 x = x

let u_ge x y =
  if y < 0l && x >= 0l then false
  else if x < 0l && y >= 0l then true
  else x >= y

let divmod x y =
  let q = ref x in
  let r = ref 0l in
  for i = 0 to 31 do
    r := Int32.shift_left !r 1;
    if (!q < 0l) then r := Int32.add !r 1l;
    q := Int32.shift_left !q 1;
    if u_ge !r y then begin
      q := Int32.add !q 1l;
      r := Int32.sub !r y
    end
  done;
  !q, !r

let div x y = fst (divmod x y)
let rem x y = snd (divmod x y)

module Fmt = Fmt.Make(struct
  type t      = uint32
  let name    = "Uint32"
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


