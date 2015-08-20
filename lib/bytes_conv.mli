module type IntSig = sig
  type t
  val zero    : t
  val bits    : int
  val of_int  : int -> t
  val to_int  : t -> int
  val logand  : t -> t -> t
  val logor   : t -> t -> t
  val shift_left : t -> int -> t
  val shift_right_logical : t -> int -> t
end

module type S = sig
  type t
  val of_bytes_big_endian : Bytes.t -> int -> t
  val of_bytes_little_endian : Bytes.t -> int -> t
  val to_bytes_big_endian : t -> Bytes.t -> int -> unit
  val to_bytes_little_endian : t -> Bytes.t -> int -> unit
end

module Make (I : IntSig) : S with type t = I.t

