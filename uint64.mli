type uint64
val zero : uint64
val one : uint64
external add : uint64 -> uint64 -> uint64 = "uint64_add"
external sub : uint64 -> uint64 -> uint64 = "uint64_sub"
external mul : uint64 -> uint64 -> uint64 = "uint64_mul"
external div : uint64 -> uint64 -> uint64 = "uint64_div"
external rem : uint64 -> uint64 -> uint64 = "uint64_mod"
val succ : uint64 -> uint64
val pred : uint64 -> uint64
val max_int : uint64
val min_int : uint64
external logand : uint64 -> uint64 -> uint64 = "uint64_and"
external logor : uint64 -> uint64 -> uint64 = "uint64_or"
external logxor : uint64 -> uint64 -> uint64 = "uint64_xor"
val lognot : uint64 -> uint64
external shift_left : uint64 -> int -> uint64 = "uint64_shift_left"
external shift_right : uint64 -> int -> uint64 = "uint64_shift_right"
external of_int : int -> uint64 = "uint64_of_int"
external to_int : uint64 -> int = "uint64_to_int"
external of_float : float -> uint64 = "uint64_of_float"
external to_float : uint64 -> float = "uint64_to_float"
external of_int32 : int32 -> uint64 = "uint64_of_int32"
external to_int32 : uint64 -> int32 = "uint64_to_int32"
external of_nativeint : nativeint -> uint64 = "uint64_of_nativeint"
external to_nativeint : uint64 -> nativeint = "uint64_to_nativeint"
external of_int64 : int64 -> uint64 = "uint64_of_int64"
external to_int64 : uint64 -> int64 = "uint64_to_int64"
val of_string : string -> uint64
val to_string : uint64 -> string
external bits_of_float : float -> uint64 = "uint64_bits_of_float"
external float_of_bits : uint64 -> float = "uint64_float_of_bits"
type t = uint64
external compare : t -> t -> int = "uint64_compare"
val printer : Format.formatter -> uint64 -> unit
