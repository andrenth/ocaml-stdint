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
external of_int32 : int32 -> uint64 = "uint64_of_int32"
external to_int32 : uint64 -> int32 = "uint64_to_int32"
external of_int64 : int64 -> uint64 = "uint64_of_int64"
external to_int64 : uint64 -> int64 = "uint64_to_int64"
external of_nativeint : nativeint -> uint64 = "uint64_of_nativeint"
external to_nativeint : uint64 -> nativeint = "uint64_to_nativeint"
external of_float : float -> uint64 = "uint64_of_float"
external to_float : uint64 -> float = "uint64_to_float"
external bits_of_float : float -> uint64 = "uint64_bits_of_float"
external float_of_bits : uint64 -> float = "uint64_float_of_bits"
external max_int_fun : unit -> uint64 = "uint64_max_int"

let zero = of_int 0
let one = of_int 1
let succ = add one
let pred x = sub x one
let max_int = max_int_fun ()
let min_int = zero
let lognot = logxor max_int

module Conv = Uint.Str_conv.Make(struct
  type t      = uint64
  let name    = "Uint64"
  let fmt     = "UL"
  let zero    = zero
  let max_int = max_int
  let bits    = 64
  let of_int  = of_int
  let to_int  = to_int
  let add     = add
  let mul     = mul
  let divmod  = (fun x y -> div x y, rem x y)
end)

let of_string = Conv.of_string
let to_string = Conv.to_string
let to_string_bin = Conv.to_string_bin
let to_string_oct = Conv.to_string_oct
let to_string_hex = Conv.to_string_hex
let printer = Conv.printer
let printer_bin = Conv.printer_bin
let printer_oct = Conv.printer_oct
let printer_hex = Conv.printer_hex

external init_custom_ops : unit -> unit = "uint64_init_custom_ops"
let () = init_custom_ops ()

let compare = Pervasives.compare
