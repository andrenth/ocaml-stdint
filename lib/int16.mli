type t
type int16 = t
val zero : int16
val one : int16
val minus_one : int16
val add : int16 -> int16 -> int16
val sub : int16 -> int16 -> int16
val mul : int16 -> int16 -> int16
val div : int16 -> int16 -> int16
val rem : int16 -> int16 -> int16
val succ : int16 -> int16
val pred : int16 -> int16
val abs : int16 -> int16
val max_int : int16
val min_int : int16
val logand : int16 -> int16 -> int16
val logor : int16 -> int16 -> int16
val logxor : int16 -> int16 -> int16
val lognot : int16 -> int16
val shift_left : int16 -> int -> int16
val shift_right : int16 -> int -> int16
val shift_right_logical : int16 -> int -> int16
val of_int : int -> int16
val to_int : int16 -> int
val of_float : float -> int16
val to_float : int16 -> float
val of_int32 : int32 -> int16
val to_int32 : int16 -> int32
val of_string : string -> int16
val to_string : int16 -> string
val to_string_bin : int16 -> string
val to_string_oct : int16 -> string
val to_string_hex : int16 -> string
val bits_of_float : float -> int16
val float_of_bits : int16 -> float
val compare : t -> t -> int
val printer : Format.formatter -> int16 -> unit
val printer_bin : Format.formatter -> int16 -> unit
val printer_oct : Format.formatter -> int16 -> unit
val printer_hex : Format.formatter -> int16 -> unit

