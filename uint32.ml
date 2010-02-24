type uint32 = int32
type t = uint32

let add = Int32.add
let sub = Int32.sub
let mul = Int32.mul
let logand = Int32.logand
let logor = Int32.logor
let logxor = Int32.logxor
let shift_left = Int32.shift_left
let shift_right = Int32.shift_right
let of_int = Int32.of_int
let to_int = Int32.to_int
let of_float = Int32.of_float
let to_float = Int32.to_float
let bits_of_float = Int32.bits_of_float
let float_of_bits = Int32.float_of_bits
let zero = 0l
let one = 1l
let succ = add one
let pred = sub one
let max_int = -1l
let lognot = logxor max_int

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

let to_int32 x = x
