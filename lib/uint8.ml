type uint8
type t = uint8

external add : uint8 -> uint8 -> uint8 = "uint8_add"
external sub : uint8 -> uint8 -> uint8 = "uint8_sub"
external mul : uint8 -> uint8 -> uint8 = "uint8_mul"
external div : uint8 -> uint8 -> uint8 = "uint8_div"
external rem : uint8 -> uint8 -> uint8 = "uint8_mod"
external logand : uint8 -> uint8 -> uint8 = "uint8_and"
external logor : uint8 -> uint8 -> uint8 = "uint8_or"
external logxor : uint8 -> uint8 -> uint8 = "uint8_xor"
external shift_left : uint8 -> int -> uint8 = "uint8_shift_left"
external shift_right : uint8 -> int -> uint8 = "uint8_shift_right"
external of_int : int -> uint8 = "uint8_of_int"
external to_int : uint8 -> int = "uint8_to_int"
external of_float : float -> uint8 = "uint8_of_float"
external to_float : uint8 -> float = "uint8_to_float"
external of_int32 : int32 -> uint8 = "uint8_of_int32"
external to_int32 : uint8 -> int32 = "uint8_to_int32"
external bits_of_float : float -> uint8 = "uint8_bits_of_float"
external float_of_bits : uint8 -> float = "uint8_float_of_bits"
external max_int_fun : unit -> uint8 = "uint8_max_int"

let zero = of_int 0
let one = of_int 1
let succ = add one
let pred x = sub x one
let max_int = max_int_fun ()
let min_int = zero
let lognot = logxor max_int

module Conv = Uint.Str_conv.Make(struct
  type t      = uint8
  let fmt     = "Ul"
  let name    = "Uint8"
  let zero    = zero
  let max_int = max_int
  let bits    = 8
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

external init_custom_ops : unit -> unit = "uint8_init_custom_ops"
let () = init_custom_ops ()

let compare = Pervasives.compare
