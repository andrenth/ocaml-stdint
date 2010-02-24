type uint32
type t = uint32

val add : uint32 -> uint32 -> uint32
val sub : uint32 -> uint32 -> uint32
val mul : uint32 -> uint32 -> uint32
val div : uint32 -> uint32 -> uint32
val rem : uint32 -> uint32 -> uint32
val logand : uint32 -> uint32 -> uint32
val logor : uint32 -> uint32 -> uint32
val logxor : uint32 -> uint32 -> uint32
val shift_left : uint32 -> int -> uint32
val shift_right : uint32 -> int -> uint32
val of_int : int -> uint32
val to_int : uint32 -> int
val of_float : float -> uint32
val to_float : uint32 -> float
val bits_of_float : float -> uint32
val float_of_bits : uint32 -> float

val zero : uint32
val one : uint32
val succ : uint32 -> uint32
val pred : uint32 -> uint32
val max_int : uint32
val lognot : uint32 -> uint32

val to_string : uint32 -> string
val of_string : string -> uint32

val compare : uint32 -> uint32 -> int

val to_int32 : uint32 -> int32
