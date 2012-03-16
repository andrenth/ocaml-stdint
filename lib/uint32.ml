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
external to_float : uint32 -> float = "uint32_to_float"
external of_int32 : int32 -> uint32 = "uint32_of_int32"
external to_int32 : uint32 -> int32 = "uint32_to_int32"
external bits_of_float : float -> uint32 = "uint32_bits_of_float"
external float_of_bits : uint32 -> float = "uint32_float_of_bits"
external max_int_fun : unit -> uint32 = "uint32_max_int"

let zero = of_int 0
let one = of_int 1
let succ = add one
let pred x = sub x one
let max_int = max_int_fun ()
let min_int = zero
let lognot = logxor max_int

module Conv = Uint.Str_conv.Make(struct
  type t      = uint32
  let fmt     = "Ul"
  let name    = "Uint32"
  let zero    = zero
  let max_int = max_int
  let bits    = 32
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

external init_custom_ops : unit -> unit = "uint32_init_custom_ops"
let () = init_custom_ops ()

let compare = Pervasives.compare
