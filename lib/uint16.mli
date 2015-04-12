type t
type uint16 = t
val zero : uint16
val one : uint16
val add : uint16 -> uint16 -> uint16
val sub : uint16 -> uint16 -> uint16
val mul : uint16 -> uint16 -> uint16
val div : uint16 -> uint16 -> uint16
val rem : uint16 -> uint16 -> uint16
val succ : uint16 -> uint16
val pred : uint16 -> uint16
val max_int : uint16
val min_int : uint16
val logand : uint16 -> uint16 -> uint16
val logor : uint16 -> uint16 -> uint16
val logxor : uint16 -> uint16 -> uint16
val lognot : uint16 -> uint16
val shift_left : uint16 -> int -> uint16
val shift_right : uint16 -> int -> uint16
val of_int : int -> uint16
val to_int : uint16 -> int
val of_float : float -> uint16
val to_float : uint16 -> float
val of_int32 : int32 -> uint16
val to_int32 : uint16 -> int32
val of_string : string -> uint16
val to_string : uint16 -> string
val to_string_bin : uint16 -> string
val to_string_oct : uint16 -> string
val to_string_hex : uint16 -> string
val bits_of_float : float -> uint16
val float_of_bits : uint16 -> float
val compare : t -> t -> int
val printer : Format.formatter -> uint16 -> unit
val printer_bin : Format.formatter -> uint16 -> unit
val printer_oct : Format.formatter -> uint16 -> unit
val printer_hex : Format.formatter -> uint16 -> unit
