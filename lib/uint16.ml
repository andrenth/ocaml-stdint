type uint16
type t = uint16

external add : uint16 -> uint16 -> uint16 = "uint16_add"
external sub : uint16 -> uint16 -> uint16 = "uint16_sub"
external mul : uint16 -> uint16 -> uint16 = "uint16_mul"
external div : uint16 -> uint16 -> uint16 = "uint16_div"
external rem : uint16 -> uint16 -> uint16 = "uint16_mod"
external logand : uint16 -> uint16 -> uint16 = "uint16_and"
external logor : uint16 -> uint16 -> uint16 = "uint16_or"
external logxor : uint16 -> uint16 -> uint16 = "uint16_xor"
external shift_left : uint16 -> int -> uint16 = "uint16_shift_left"
external shift_right : uint16 -> int -> uint16 = "uint16_shift_right"
external of_int : int -> uint16 = "uint16_of_int"
external to_int : uint16 -> int = "uint16_to_int"
external of_float : float -> uint16 = "uint16_of_float"
external to_float : uint16 -> float = "uint16_to_float"
external of_int32 : int32 -> uint16 = "uint16_of_int32"
external to_int32 : uint16 -> int32 = "uint16_to_int32"
external bits_of_float : float -> uint16 = "uint16_bits_of_float"
external float_of_bits : uint16 -> float = "uint16_float_of_bits"
external max_int_fun : unit -> uint16 = "uint16_max_int"

let zero = of_int 0
let one = of_int 1
let succ = add one
let pred x = sub x one
let max_int = max_int_fun ()
let min_int = zero
let lognot = logxor max_int

module Conv = Uint.Str_conv.Make(struct
  type t      = uint16
  let fmt     = "Ul"
  let name    = "Uint16"
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

external init_custom_ops : unit -> unit = "uint16_init_custom_ops"
let () = init_custom_ops ()

let compare = Pervasives.compare
