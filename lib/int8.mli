type t
type int8 = t
val zero : int8
val one : int8
val minus_one : int8
val add : int8 -> int8 -> int8
val sub : int8 -> int8 -> int8
val mul : int8 -> int8 -> int8
val div : int8 -> int8 -> int8
val rem : int8 -> int8 -> int8
val succ : int8 -> int8
val pred : int8 -> int8
val abs : int8 -> int8
val max_int : int8
val min_int : int8
val logand : int8 -> int8 -> int8
val logor : int8 -> int8 -> int8
val logxor : int8 -> int8 -> int8
val lognot : int8 -> int8
val shift_left : int8 -> int -> int8
val shift_right : int8 -> int -> int8
val shift_right_logical : int8 -> int -> int8
val of_int : int -> int8
val to_int : int8 -> int
val of_float : float -> int8
val to_float : int8 -> float
val of_int32 : int32 -> int8
val to_int32 : int8 -> int32
val of_string : string -> int8
val to_string : int8 -> string
val to_string_bin : int8 -> string
val to_string_oct : int8 -> string
val to_string_hex : int8 -> string
val bits_of_float : float -> int8
val float_of_bits : int8 -> float
val compare : t -> t -> int
val printer : Format.formatter -> int8 -> unit
val printer_bin : Format.formatter -> int8 -> unit
val printer_oct : Format.formatter -> int8 -> unit
val printer_hex : Format.formatter -> int8 -> unit
