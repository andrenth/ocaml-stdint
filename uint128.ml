type uint128 = { lo : Uint64.t; hi : Uint64.t }
type t = uint128

let zero = { lo = Uint64.zero; hi = Uint64.zero }
let one = { lo = Uint64.one; hi = Uint64.zero }
let max_int = { lo = Uint64.max_int; hi = Uint64.max_int }
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
  let max32 = Uint64.of_int32 (-2) in
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
(*     { lo = x.hi >> (i - 32); hi = Uint64.zero } *)

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

let digit_of_char c =
  let disp =
    if c >= '0' && c <= '9' then 48
    else if c >= 'A' && c <= 'F' then 55
    else if c >= 'a' && c <= 'f' then 87
    else failwith "Uint128.of_string" in
  int_of_char c - disp

let of_string' s base =
  let base128 = of_int base in
  let threshold, _ = divmod max_int base128 in
  let d = digit_of_char s.[0] in
  if d > base then failwith "Uint128.of_string";
  let res = ref (of_int d) in
  for i = 1 to String.length s - 1 do
    let c = s.[i] in
    if c <> '_' then begin
      let d = digit_of_char c in
      if d > base then failwith "Uint128.of_string";
      if threshold < !res then failwith "Uint128.of_string";
      let d128 = of_int d in
      res := add (mul !res base128) d128;
      if !res < d128 then failwith "Uint128.of_string"
    end
  done;
  !res

let of_string s =
  let len = String.length s in
  match len with
  | 0 -> invalid_arg "Uint128.of_string"
  | 1 | 2 -> of_string' s 10
  | _ ->
      if s.[0] = '0' then
        let base =
          match s.[1] with
          | 'b' | 'B' -> 2
          | 'o' | 'O' -> 8
          | 'x' | 'X' -> 16
          | _ -> invalid_arg "Uint128.of_string" in
        of_string' (String.sub s 2 (len - 2)) base
      else
        of_string' s 10

let to_string x =
  let y = ref x in
  if !y = zero then
    "0"
  else begin
    let buffer = String.make 42 'x' in
    let conv = "0123456789abcdef" in
    let base = of_int 10 in
    let i = ref (String.length buffer) in
    while !y <> zero do
      let x', digit = divmod !y base in
      y := x';
      decr i;
      buffer.[!i] <- conv.[to_int digit]
    done;
    String.sub buffer !i (String.length buffer - !i)
  end
