type uint32
val zero : uint32
val one : uint32
external add : uint32 -> uint32 -> uint32 = "uint32_add"
external sub : uint32 -> uint32 -> uint32 = "uint32_sub"
external mul : uint32 -> uint32 -> uint32 = "uint32_mul"
external div : uint32 -> uint32 -> uint32 = "uint32_div"
external rem : uint32 -> uint32 -> uint32 = "uint32_mod"
val succ : uint32 -> uint32
val pred : uint32 -> uint32
val max_int : uint32
val min_int : uint32
external logand : uint32 -> uint32 -> uint32 = "uint32_and"
external logor : uint32 -> uint32 -> uint32 = "uint32_or"
external logxor : uint32 -> uint32 -> uint32 = "uint32_xor"
val lognot : uint32 -> uint32
external shift_left : uint32 -> int -> uint32 = "uint32_shift_left"
external shift_right : uint32 -> int -> uint32 = "uint32_shift_right"
external of_int : int -> uint32 = "uint32_of_int"
external to_int : uint32 -> int = "uint32_to_int"
external of_float : float -> uint32 = "uint32_of_float"
external to_float : uint32 -> float = "uint32_to_float"
val of_int32 : int32 -> uint32
val to_int32 : uint32 -> int32
val of_string : string -> uint32
val to_string : uint32 -> string
external bits_of_float : float -> uint32 = "uint32_bits_of_float"
external float_of_bits : uint32 -> float = "uint32_float_of_bits"
type t = uint32
external compare : t -> t -> int = "uint32_compare"
val printer : Format.formatter -> uint32 -> unit
