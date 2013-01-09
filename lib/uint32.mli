type t
type uint32 = t
val zero : uint32
val one : uint32
val add : uint32 -> uint32 -> uint32
val sub : uint32 -> uint32 -> uint32
val mul : uint32 -> uint32 -> uint32
val div : uint32 -> uint32 -> uint32
val rem : uint32 -> uint32 -> uint32
val succ : uint32 -> uint32
val pred : uint32 -> uint32
val max_int : uint32
val min_int : uint32
val logand : uint32 -> uint32 -> uint32
val logor : uint32 -> uint32 -> uint32
val logxor : uint32 -> uint32 -> uint32
val lognot : uint32 -> uint32
val shift_left : uint32 -> int -> uint32
val shift_right : uint32 -> int -> uint32
val of_int : int -> uint32
val to_int : uint32 -> int
val of_float : float -> uint32
val to_float : uint32 -> float
val of_int32 : int32 -> uint32
val to_int32 : uint32 -> int32
val of_string : string -> uint32
val to_string : uint32 -> string
val to_string_bin : uint32 -> string
val to_string_oct : uint32 -> string
val to_string_hex : uint32 -> string
val bits_of_float : float -> uint32
val float_of_bits : uint32 -> float
val compare : t -> t -> int
val printer : Format.formatter -> uint32 -> unit
val printer_bin : Format.formatter -> uint32 -> unit
val printer_oct : Format.formatter -> uint32 -> unit
val printer_hex : Format.formatter -> uint32 -> unit
