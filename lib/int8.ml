type int8
type t = int8

external add : int8 -> int8 -> int8 = "int8_add"
external sub : int8 -> int8 -> int8 = "int8_sub"
external mul : int8 -> int8 -> int8 = "int8_mul"
external div : int8 -> int8 -> int8 = "int8_div"
external rem : int8 -> int8 -> int8 = "int8_mod"
external logand : int8 -> int8 -> int8 = "int8_and"
external logor : int8 -> int8 -> int8 = "int8_or"
external logxor : int8 -> int8 -> int8 = "int8_xor"
external shift_left : int8 -> int -> int8 = "int8_shift_left"
external shift_right : int8 -> int -> int8 = "int8_shift_right"
external shift_right_logical : int8 -> int -> int8 = "uint8_shift_right"
external of_int : int -> int8 = "int8_of_int"
external to_int : int8 -> int = "int8_to_int"
external of_float : float -> int8 = "int8_of_float"
external to_float : int8 -> float = "int8_to_float"
external of_int32 : int32 -> int8 = "int8_of_int32"
external to_int32 : int8 -> int32 = "int8_to_int32"
external bits_of_float : float -> int8 = "int8_bits_of_float"
external float_of_bits : int8 -> float = "int8_float_of_bits"
external abs : int8 -> int8 = "int8_abs"
external max_int_fun : unit -> int8 = "int8_max_int"
external min_int_fun : unit -> int8 = "int8_min_int"

let zero = of_int 0
let one = of_int 1
let minus_one = of_int (-1)
let succ = add one
let pred x = sub x one
let max_int = max_int_fun ()
let min_int = min_int_fun ()
let lognot = logxor minus_one

module Conv = Uint.Str_conv.Make(struct
  type t      = int8
  let fmt     = "l"
  let name    = "Int8"
  let unsigned = false
  let zero    = zero
  let max_int = max_int
  let min_int = min_int
  let bits    = 8
  let of_int  = of_int
  let to_int  = to_int
  let add     = add
  let sub     = sub
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

external init_custom_ops : unit -> unit = "int8_init_custom_ops"
let () = init_custom_ops ()

let compare = Pervasives.compare
