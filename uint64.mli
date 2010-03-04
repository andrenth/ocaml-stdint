type uint64
type t = uint64

external add : uint64 -> uint64 -> uint64 = "%int64_add"
external sub : uint64 -> uint64 -> uint64 = "%int64_sub"
external mul : uint64 -> uint64 -> uint64 = "%int64_mul"
external logand : uint64 -> uint64 -> uint64 = "%int64_and"
external logor : uint64 -> uint64 -> uint64 = "%int64_or"
external logxor : uint64 -> uint64 -> uint64 = "%int64_xor"
external shift_left : uint64 -> int -> uint64 = "%int64_lsl"
external shift_right : uint64 -> int -> uint64 = "%int64_asr"
external shift_right_logical : uint64 -> int -> uint64 = "%int64_lsr"
external of_int : int -> uint64 = "%int64_of_int"
external to_int : uint64 -> int = "%int64_to_int"
external of_int32 : int32 -> uint64 = "%int64_of_int32"
external to_int32 : uint64 -> int32 = "%int64_to_int32"
external of_nativeint : nativeint -> uint64 = "caml_int64_of_nativeint"
external to_nativeint : uint64 -> nativeint = "caml_int64_to_nativeint"
external of_float : float -> uint64 = "caml_int64_of_float"
external to_float : uint64 -> float = "caml_int64_to_float"
external bits_of_float : float -> uint64 = "caml_int64_bits_of_float"
external float_of_bits : uint64 -> float = "caml_int64_float_of_bits"

val of_int64 : int64 -> uint64
val to_int64 : uint64 -> int64

val div : uint64 -> uint64 -> uint64
val rem : uint64 -> uint64 -> uint64

val zero : uint64
val one : uint64
val succ : uint64 -> uint64
val pred : uint64 -> uint64
val max_int : uint64
val min_int : uint64
val lognot : uint64 -> uint64

val of_string : string -> uint64
val to_string : uint64 -> string

val compare : uint64 -> uint64 -> int
