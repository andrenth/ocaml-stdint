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

module Make_signed (D : Size) : S

module Make_unsigned (D : Size) : S

