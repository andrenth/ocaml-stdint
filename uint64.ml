type uint64
type t = uint64

external add : uint64 -> uint64 -> uint64 = "uint64_add"
external sub : uint64 -> uint64 -> uint64 = "uint64_sub"
external mul : uint64 -> uint64 -> uint64 = "uint64_mul"
external div : uint64 -> uint64 -> uint64 = "uint64_div"
external rem : uint64 -> uint64 -> uint64 = "uint64_mod"
external logand : uint64 -> uint64 -> uint64 = "uint64_and"
external logor : uint64 -> uint64 -> uint64 = "uint64_or"
external logxor : uint64 -> uint64 -> uint64 = "uint64_xor"
external shift_left : uint64 -> int -> uint64 = "uint64_shift_left"
external shift_right : uint64 -> int -> uint64 = "uint64_shift_right"
external of_int : int -> uint64 = "uint64_of_int"
external to_int : uint64 -> int = "uint64_to_int"
external of_float : float -> uint64 = "uint64_of_float"
external to_float : uint64 -> float -> uint64 = "uint64_to_float"
external bits_of_float : float -> uint64 = "uint64_bits_of_float"
external float_of_bits : uint64 -> float = "uint64_float_of_bits"

let zero = of_int 0
let one = of_int 1
let succ x = add x one
let pred x = sub x one
external max_int_fun : unit -> uint64 = "uint64_max_int"
let max_int = max_int_fun ()
let lognot x = logxor x max_int

external format : string -> uint64 -> string = "uint64_format"
let to_string n = format "%u" n

external of_string : string -> uint64 = "uint64_of_string"

let compare (x : t) (y : t) = Pervasives.compare x y
