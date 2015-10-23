module type Size = sig
  val bits : int
end

module type S = sig
  type t = int
  val bits : int
  val add : t -> t -> t
  val sub : t -> t -> t
  val mul : t -> t -> t
  val div : t -> t -> t
  val rem : t -> t -> t
  val logand : t -> t -> t
  val logor : t -> t -> t
  val logxor : t -> t -> t
  val shift_left : t -> t -> t
  val shift_right : t -> t -> t
  val shift_right_logical : t -> t -> t
  val abs : t -> t
  val neg : t -> t
  val of_int : int -> t
  val to_int : t -> int
  val zero : t
  val one : t
  val succ : t -> t
  val pred : t -> t
  val max_int : t
  val min_int : t
  val lognot : t -> t
  val compare : t -> t -> int
  val divmod : t -> t -> (t * t)
end

module Make_signed (I : Size) = struct
  type t = int

  let bits = I.bits

  let of_int x = x lsl (Sys.word_size - I.bits - 1)
  let to_int x = x asr (Sys.word_size - I.bits - 1)
  let mask = (1 lsl I.bits) - 1

  let add = (+)
  let sub = (-)
  let mul a b = (to_int a) * b
  let div a b = of_int (a / b)
  let rem = (mod)
  let logand = (land)
  let logor = (lor)
  let logxor a b = (a lxor b) land (of_int mask)
  let shift_left a b = a lsl b
  let shift_right a b = (a asr b) land (of_int mask)
  let shift_right_logical a b = (a lsr b) land (of_int mask)
  let abs = abs
  let neg x = (-1) * x

  let zero = 0
  let one = of_int 1
  let minus_one = of_int (-1)
  let succ = add one
  let pred x = sub x one

  let max_int = of_int (1 lsl (I.bits - 1)) - 1
  let min_int = of_int ((-1) * (1 lsl (I.bits - 1)))

  let lognot = logxor minus_one
  let compare = Pervasives.compare
  let divmod  = (fun x y -> div x y, rem x y)
end

module Make_unsigned (I : Size) = struct
  type t = int

  let bits = I.bits

  let mask = (1 lsl I.bits) - 1
  let of_int = (land) mask
  external to_int : t -> int = "%identity"

  let add a b = of_int (a + b)
  let sub a b = of_int (a - b)
  let mul a b = of_int (a * b)
  let div = (/)
  let rem = (mod)
  let logand = (land)
  let logor = (lor)
  let logxor a b = of_int (a lxor b)
  let shift_left a b = of_int (a lsl b)
  let shift_right = (lsr)
  let shift_right_logical = shift_right
  external abs : t -> t = "%identity"
  let neg x = of_int ((-1) * x)

  let zero = of_int 0
  let one = of_int 1
  let succ = add one
  let pred x = sub x one
  let max_int = of_int ((1 lsl I.bits) - 1)
  let min_int = zero
  let lognot = logxor max_int
  let compare = Pervasives.compare
  let divmod  = (fun x y -> div x y, rem x y)
end

