type uint32
type t = uint32

external add : uint32 -> uint32 -> uint32 = "uint32_add"
external sub : uint32 -> uint32 -> uint32 = "uint32_sub"
external mul : uint32 -> uint32 -> uint32 = "uint32_mul"
external div : uint32 -> uint32 -> uint32 = "uint32_div"
external rem : uint32 -> uint32 -> uint32 = "uint32_mod"
external logand : uint32 -> uint32 -> uint32 = "uint32_and"
external logor : uint32 -> uint32 -> uint32 = "uint32_or"
external logxor : uint32 -> uint32 -> uint32 = "uint32_xor"
external shift_left : uint32 -> int -> uint32 = "uint32_shift_left"
external shift_right : uint32 -> int -> uint32 = "uint32_shift_right"
external of_int : int -> uint32 = "uint32_of_int"
external to_int : uint32 -> int = "uint32_to_int"
external of_float : float -> uint32 = "uint32_of_float"
external to_float : uint32 -> float -> uint32 = "uint32_to_float"
external bits_of_float : float -> uint32 = "uint32_bits_of_float"
external float_of_bits : uint32 -> float = "uint32_float_of_bits"

let zero = of_int 0
let one = of_int 1
let succ x = add x one
let pred x = sub x one
external max_int_fun : unit -> uint32 = "uint32_max_int"
let max_int = max_int_fun ()
let lognot x = logxor x max_int

external format : string -> uint32 -> string = "uint32_format"
let to_string n = format "%u" n

external of_string : string -> uint32 = "uint32_of_string"

let compare (x : t) (y : t) = Pervasives.compare x y
