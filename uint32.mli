type uint32
val zero : uint32
val one : uint32
external add : uint32 -> uint32 -> uint32 = "%int32_add"
external sub : uint32 -> uint32 -> uint32 = "%int32_sub"
external mul : uint32 -> uint32 -> uint32 = "%int32_mul"
val div : uint32 -> uint32 -> uint32
val rem : uint32 -> uint32 -> uint32
val succ : uint32 -> uint32
val pred : uint32 -> uint32
val max_int : uint32
val min_int : uint32
external logand : uint32 -> uint32 -> uint32 = "%int32_and"
external logor : uint32 -> uint32 -> uint32 = "%int32_or"
external logxor : uint32 -> uint32 -> uint32 = "%int32_xor"
val lognot : uint32 -> uint32
external shift_left : uint32 -> int -> uint32 = "%int32_lsl"
external shift_right : uint32 -> int -> uint32 = "%int32_asr"
external shift_right_logical : uint32 -> int -> uint32 = "%int32_lsr"
external of_int : int -> uint32 = "%int32_of_int"
external to_int : uint32 -> int = "%int32_to_int"
external of_float : float -> uint32 = "caml_int32_of_float"
external to_float : uint32 -> float = "caml_int32_to_float"
val of_int32 : int32 -> uint32
val to_int32 : uint32 -> int32
val of_string : string -> uint32
val to_string : uint32 -> string
external bits_of_float : float -> uint32 = "caml_int32_bits_of_float"
external float_of_bits : uint32 -> float = "caml_int32_float_of_bits"
type t = uint32
val compare : t -> t -> int
