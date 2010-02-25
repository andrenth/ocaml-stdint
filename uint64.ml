type uint64 = int64
type t = uint64

let add = Int64.add
let sub = Int64.sub
let mul = Int64.mul
let logand = Int64.logand
let logor = Int64.logor
let logxor = Int64.logxor
let shift_left = Int64.shift_left
let shift_right = Int64.shift_right
let of_int = Int64.of_int
let to_int = Int64.to_int
let of_int32 = Int64.of_int32
let to_int32 = Int64.to_int32
let of_float = Int64.of_float
let to_float = Int64.to_float
let bits_of_float = Int64.bits_of_float
let float_of_bits = Int64.float_of_bits
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

let to_int64 x = x
