type int16
type t = int16

external add : int16 -> int16 -> int16 = "int16_add"
external sub : int16 -> int16 -> int16 = "int16_sub"
external mul : int16 -> int16 -> int16 = "int16_mul"
external div : int16 -> int16 -> int16 = "int16_div"
external rem : int16 -> int16 -> int16 = "int16_mod"
external logand : int16 -> int16 -> int16 = "int16_and"
external logor : int16 -> int16 -> int16 = "int16_or"
external logxor : int16 -> int16 -> int16 = "int16_xor"
external shift_left : int16 -> int -> int16 = "int16_shift_left"
external shift_right : int16 -> int -> int16 = "int16_shift_right"
external shift_right_logical : int16 -> int -> int16 = "uint16_shift_right"
external of_int : int -> int16 = "int16_of_int"
external to_int : int16 -> int = "int16_to_int"
external of_float : float -> int16 = "int16_of_float"
external to_float : int16 -> float = "int16_to_float"
external of_int32 : int32 -> int16 = "int16_of_int32"
external to_int32 : int16 -> int32 = "int16_to_int32"
external bits_of_float : float -> int16 = "int16_bits_of_float"
external float_of_bits : int16 -> float = "int16_float_of_bits"
external abs : int16 -> int16 = "int16_abs"
external max_int_fun : unit -> int16 = "int16_max_int"
external min_int_fun : unit -> int16 = "int16_min_int"

let zero = of_int 0
let one = of_int 1
let minus_one = of_int (-1)
let succ = add one
let pred x = sub x one
let max_int = max_int_fun ()
let min_int = min_int_fun ()
let lognot = logxor minus_one

module Conv = Uint.Str_conv.Make(struct
  type t      = int16
  let fmt     = "l"
  let name    = "int16"
  let zero    = zero
  let max_int = max_int
  let min_int = min_int
  let bits    = 16
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

external init_custom_ops : unit -> unit = "int16_init_custom_ops"
let () = init_custom_ops ()

let compare = Pervasives.compare

