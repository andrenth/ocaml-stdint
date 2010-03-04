type uint128 = { lo : Uint64.t; hi : Uint64.t }
type t = uint128

let zero = { lo = Uint64.zero; hi = Uint64.zero }
let one = { lo = Uint64.one; hi = Uint64.zero }
let max_int = { lo = Uint64.max_int; hi = Uint64.max_int }
let min_int = { lo = Uint64.min_int; hi = Uint64.min_int }
let compare x y =
  if x.hi > y.hi then 1
  else if x.hi < y.hi then -1
  else if x.lo > y.lo then 1
  else if x.lo < y.lo then -1
  else 0

let add x y =
  let l = Uint64.add x.lo y.lo in
  let h = Uint64.add x.hi y.hi in
  if l < x.lo then
    { lo = l; hi = Uint64.succ h }
  else
    { lo = l; hi = h }

let sub x y =
  let l = Uint64.sub x.lo y.lo in
  let h = Uint64.sub x.hi y.hi in
  if x.lo < y.lo then
    { lo = l; hi = Uint64.pred h }
  else
    { lo = l; hi = h }

let mul x y =
  let (&) = Uint64.logand in
  let (<<) = Uint64.shift_left in
  let (>>) = Uint64.shift_right in
  let (+) = Uint64.add in
  let ( * ) = Uint64.mul in
  let max32 = Uint64.of_int32 (-2l) in
  let p0 = ref ((x.lo & max32) * (y.lo & max32)) in
  let p1 = ref ((x.lo & max32) * (y.lo >> 32)) in
  let p2 = ref ((x.lo >> 32) * (y.lo & max32)) in
  let p3 = ref ((x.lo >> 32) * (y.lo >> 32)) in
  let l = ref !p0 in
  let h = ref (!p3 + (!p1 >> 32) + (!p2 >> 32)) in
  p1 := !p1 << 32;
  l := !l + !p1;
  if !l < !p1 then h := Uint64.succ !h;
  p2 := !p2 << 32;
  l := !l + !p2;
  if !l < !p2 then h := Uint64.succ !h;
  h := !h + x.lo * y.hi + x.hi * y.lo;
  { lo = !l; hi = !h }

let logand x y =
  { lo = Uint64.logand x.lo y.lo; hi = Uint64.logand x.hi y.hi }

let logor x y =
  { lo = Uint64.logor x.lo y.lo; hi = Uint64.logor x.hi y.hi }

let logxor x y =
  { lo = Uint64.logxor x.lo y.lo; hi = Uint64.logxor x.hi y.hi }

let lognot x =
  { hi = Uint64.lognot x.hi; lo = Uint64.lognot x.lo }

let shift_left x s =
  let (<<) = Uint64.shift_left in
  let (>>) = Uint64.shift_right in
  let (||) = Uint64.logor in
  let i = s land 127 in
  if i = 0 then
    x
  else if i < 64 then
    { lo = x.lo << i; hi = (x.hi << i) || (x.lo >> (64 - i)) }
  else
    { lo = Uint64.zero; hi = x.lo << (i - 32) }

let shift_right x s =
  let (<<) = Uint64.shift_left in
  let (>>) = Uint64.shift_right in
  let (||) = Uint64.logor in
  let i = s land 127 in
  if i = 0 then
    x
  else if i < 64 then
    { lo = (x.lo >> i) || (x.hi << (64 - i)); hi = x.hi >> i }
  else
     { lo = x.hi >> (i - 32); hi = x.hi >> 63 }

let shift_right_logical x s =
  let (<<) = Uint64.shift_left in
  let (>>) = Uint64.shift_right in
  let (||) = Uint64.logor in
  let i = s land 127 in
  if i = 0 then
    x
  else if i < 64 then
    { lo = (x.lo >> i) || (x.hi << (64 - i)); hi = x.hi >> i }
  else
     { lo = x.hi >> (i - 32); hi = Uint64.zero }

let divmod modulus divisor =
  let (|.) = Uint64.logor in
  let mask = ref one in
  let d = ref divisor in
  (try
    while Uint64.to_int64 !d.hi >= 0L do
      let cmp = compare !d modulus in
      d := shift_left !d 1;
      mask := shift_left !mask 1;
      if cmp >= 0 then raise Exit
    done;
  with Exit -> ());
  let rem = ref modulus in
  let quotient = ref zero in
  while !mask.lo |. !mask.hi <> Uint64.zero do
    if compare !rem !d >= 0 then begin
      quotient := {
        hi = !quotient.hi |. !mask.hi;
        lo = !quotient.lo |. !mask.lo 
      };
      rem := sub !rem !d;
    end;
    mask := shift_right !mask 1;
    d := shift_right !d 1
  done;
  !quotient, !rem

let div x y =
  fst (divmod x y)

let rem x y =
  snd (divmod x y)

let pred x = sub x one
let succ x = add x one

let of_int x =
  { hi = Uint64.zero; lo = Uint64.of_int x }

let to_int x =
  Uint64.to_int x.lo

let of_float x =
  { hi = Uint64.zero; lo = Uint64.of_float x }

let to_float x =
  Uint64.to_float x.lo

module Fmt = Fmt.Make(struct
  type t      = uint128
  let name    = "Uint128"
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
