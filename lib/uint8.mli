type t
type uint8 = t
val zero : uint8
val one : uint8
val add : uint8 -> uint8 -> uint8
val sub : uint8 -> uint8 -> uint8
val mul : uint8 -> uint8 -> uint8
val div : uint8 -> uint8 -> uint8
val rem : uint8 -> uint8 -> uint8
val succ : uint8 -> uint8
val pred : uint8 -> uint8
val max_int : uint8
val min_int : uint8
val logand : uint8 -> uint8 -> uint8
val logor : uint8 -> uint8 -> uint8
val logxor : uint8 -> uint8 -> uint8
val lognot : uint8 -> uint8
val shift_left : uint8 -> int -> uint8
val shift_right : uint8 -> int -> uint8
val of_int : int -> uint8
val to_int : uint8 -> int
val of_float : float -> uint8
val to_float : uint8 -> float
val of_int32 : int32 -> uint8
val to_int32 : uint8 -> int32
val of_string : string -> uint8
val to_string : uint8 -> string
val to_string_bin : uint8 -> string
val to_string_oct : uint8 -> string
val to_string_hex : uint8 -> string
val bits_of_float : float -> uint8
val float_of_bits : uint8 -> float
val compare : t -> t -> int
val printer : Format.formatter -> uint8 -> unit
val printer_bin : Format.formatter -> uint8 -> unit
val printer_oct : Format.formatter -> uint8 -> unit
val printer_hex : Format.formatter -> uint8 -> unit
