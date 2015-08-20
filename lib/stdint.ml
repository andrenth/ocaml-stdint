type int8
type int16
type int128
type uint8
type uint16
type uint32
type uint64
type uint128

module type Int = sig
  type t

  val zero : t
  val one : t
  val max_int : t
  val min_int : t
  val bits : int

  val add : t -> t -> t
  val sub : t -> t -> t
  val mul : t -> t -> t
  val div : t -> t -> t
  val rem : t -> t -> t
  val succ : t -> t
  val pred : t -> t
  val abs : t -> t
  val logand : t -> t -> t
  val logor : t -> t -> t
  val logxor : t -> t -> t
  val lognot : t -> t
  val shift_left : t -> int -> t
  val shift_right : t -> int -> t
  val shift_right_logical : t -> int -> t

  val of_int : int -> t
  val to_int : t -> int
  val of_float : float -> t
  val to_float : t -> float
  val of_nativeint : nativeint -> t
  val to_nativeint : t -> nativeint

  val of_int8 : int8 -> t
  val to_int8 : t -> int8
  val of_int16 : int16 -> t
  val to_int16 : t -> int16
  val of_int32 : int32 -> t
  val to_int32 : t -> int32
  val of_int64 : int64 -> t
  val to_int64 : t -> int64
  val of_int128 : int128 -> t
  val to_int128 : t -> int128

  val of_uint8 : uint8 -> t
  val to_uint8 : t -> uint8
  val of_uint16 : uint16 -> t
  val to_uint16 : t -> uint16
  val of_uint32 : uint32 -> t
  val to_uint32 : t -> uint32
  val of_uint64 : uint64 -> t
  val to_uint64 : t -> uint64
  val of_uint128 : uint128 -> t
  val to_uint128 : t -> uint128

  val of_string : string -> t
  val to_string : t -> string

  val to_string_bin : t -> string
  val to_string_oct : t -> string
  val to_string_hex : t -> string

  val printer : Format.formatter -> t -> unit
  val printer_bin : Format.formatter -> t -> unit
  val printer_oct : Format.formatter -> t -> unit
  val printer_hex : Format.formatter -> t -> unit

  val of_bytes_big_endian : Bytes.t -> int -> t
  val of_bytes_little_endian : Bytes.t -> int -> t
  val to_bytes_big_endian : t -> Bytes.t -> int -> unit
  val to_bytes_little_endian : t -> Bytes.t -> int -> unit

  val compare : t -> t -> int
end

module Int8 = struct
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
  external abs : int8 -> int8 = "int8_abs"

  external of_int : int -> int8 = "int8_of_int"
  external to_int : int8 -> int = "int_of_int8"
  external of_float : float -> int8 = "int8_of_float"
  external to_float : int8 -> float = "float_of_int8"
  external of_nativeint : nativeint -> int8 = "int8_of_nativeint"
  external to_nativeint : int8 -> nativeint = "nativeint_of_int8"

  external of_int8 : int8 -> int8 = "%identity"
  external of_int16 : int16 -> int8 = "int8_of_int16"
  external of_int32 : int32 -> int8 = "int8_of_int32"
  external of_int64 : int64 -> int8 = "int8_of_int64"
  external of_int128 : int128 -> int8 = "int8_of_int128"
  external of_uint8 : uint8 -> int8 = "int8_of_uint8"
  external of_uint16 : uint16 -> int8 = "int8_of_uint16"
  external of_uint32 : uint32 -> int8 = "int8_of_uint32"
  external of_uint64 : uint64 -> int8 = "int8_of_uint64"
  external of_uint128 : uint128 -> int8 = "int8_of_uint128"

  external to_int8 : int8 -> int8 = "%identity"
  external to_int16 : int8 -> int16 = "int16_of_int8"
  external to_int32 : int8 -> int32 = "int32_of_int8"
  external to_int64 : int8 -> int64 = "int64_of_int8"
  external to_int128 : int8 -> int128 = "int128_of_int8"
  external to_uint8 : int8 -> uint8 = "uint8_of_int8"
  external to_uint16 : int8 -> uint16 = "uint16_of_int8"
  external to_uint32 : int8 -> uint32 = "uint32_of_int8"
  external to_uint64 : int8 -> uint64 = "uint64_of_int8"
  external to_uint128 : int8 -> uint128 = "uint128_of_int8"

  external bits_of_float : float -> int8 = "int8_bits_of_float"
  external float_of_bits : int8 -> float = "int8_float_of_bits"
  external abs : int8 -> int8 = "int8_abs"
  external max_int_fun : unit -> int8 = "int8_max_int"
  external min_int_fun : unit -> int8 = "int8_min_int"

  let bits = 8
  let zero = of_int 0
  let one = of_int 1
  let minus_one = of_int (-1)
  let succ = add one
  let pred x = sub x one
  let max_int = max_int_fun ()
  let min_int = min_int_fun ()
  let lognot = logxor minus_one
  let compare = Pervasives.compare

  module Conv = Str_conv.Make(struct
    type t      = int8
    let fmt     = "l"
    let name    = "Int8"
    let unsigned = false
    let zero    = zero
    let max_int = max_int
    let min_int = min_int
    let bits    = bits
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

  module Endian = Bytes_conv.Make(struct
    type t      = int8
    let zero    = zero
    let bits    = bits
    let of_int  = of_int
    let to_int  = to_int
    let logand  = logand
    let logor   = logor
    let shift_left = shift_left
    let shift_right_logical = shift_right_logical
  end)
  let of_bytes_big_endian = Endian.of_bytes_big_endian
  let of_bytes_little_endian = Endian.of_bytes_little_endian
  let to_bytes_big_endian = Endian.to_bytes_big_endian
  let to_bytes_little_endian = Endian.to_bytes_little_endian

  external init_custom_ops : unit -> unit = "int8_init_custom_ops"
  let () = init_custom_ops ()
end

module Int16 = struct
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
  external abs : int16 -> int16 = "int16_abs"

  external of_int : int -> int16 = "int16_of_int"
  external to_int : int16 -> int = "int_of_int16"
  external of_float : float -> int16 = "int16_of_float"
  external to_float : int16 -> float = "float_of_int16"
  external of_nativeint : nativeint -> int16 = "int16_of_nativeint"
  external to_nativeint : int16 -> nativeint = "nativeint_of_int16"

  external of_int8 : int8 -> int16 = "int16_of_int8"
  external of_int16 : int16 -> int16 = "%identity"
  external of_int32 : int32 -> int16 = "int16_of_int32"
  external of_int64 : int64 -> int16 = "int16_of_int64"
  external of_int128 : int128 -> int16 = "int16_of_int128"
  external of_uint8 : uint8 -> int16 = "int16_of_uint8"
  external of_uint16 : uint16 -> int16 = "int16_of_uint16"
  external of_uint32 : uint32 -> int16 = "int16_of_uint32"
  external of_uint64 : uint64 -> int16 = "int16_of_uint64"
  external of_uint128 : uint128 -> int16 = "int16_of_uint128"
  external to_int8 : int16 -> int8 = "int8_of_int16"
  external to_int16 : int16 -> int16 = "%identity"
  external to_int32 : int16 -> int32 = "int32_of_int16"
  external to_int64 : int16 -> int64 = "int64_of_int16"
  external to_int128 : int16 -> int128 = "int128_of_int16"
  external to_uint8 : int16 -> uint8 = "uint8_of_int16"
  external to_uint16 : int16 -> uint16 = "uint16_of_int16"
  external to_uint32 : int16 -> uint32 = "uint32_of_int16"
  external to_uint64 : int16 -> uint64 = "uint64_of_int16"
  external to_uint128 : int16 -> uint128 = "uint128_of_int16"

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
  let compare = Pervasives.compare
  let bits    = 16

  module Conv = Str_conv.Make(struct
    type t      = int16
    let fmt     = "l"
    let name    = "int16"
    let zero    = zero
    let max_int = max_int
    let min_int = min_int
    let bits    = bits
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

  module Endian = Bytes_conv.Make(struct
    type t      = int16
    let zero    = zero
    let bits    = bits
    let of_int  = of_int
    let to_int  = to_int
    let logand  = logand
    let logor   = logor
    let shift_left = shift_left
    let shift_right_logical = shift_right_logical
  end)
  let of_bytes_big_endian = Endian.of_bytes_big_endian
  let of_bytes_little_endian = Endian.of_bytes_little_endian
  let to_bytes_big_endian = Endian.to_bytes_big_endian
  let to_bytes_little_endian = Endian.to_bytes_little_endian

  external init_custom_ops : unit -> unit = "int16_init_custom_ops"
  let () = init_custom_ops ()
end

module Int32 = struct
  include Int32

  let of_nativeint = Nativeint.to_int32
  let to_nativeint = Nativeint.of_int32

  external of_int8 : int8 -> int32 = "int32_of_int8"
  external of_int16 : int16 -> int32 = "int32_of_int16"
  external of_int32 : int32 -> int32 = "%identity"
  external of_int64 : int64 -> int32 = "int32_of_int64"
  external of_int128 : int128 -> int32 = "int32_of_int128"
  external of_uint8 : uint8 -> int32 = "int32_of_uint8"
  external of_uint16 : uint16 -> int32 = "int32_of_uint16"
  external of_uint32 : uint32 -> int32 = "int32_of_uint32"
  external of_uint64 : uint64 -> int32 = "int32_of_uint64"
  external of_uint128 : uint128 -> int32 = "int32_of_uint128"
  external to_int8 : int32 -> int8 = "int8_of_int32"
  external to_int16 : int32 -> int16 = "int16_of_int32"
  external to_int32 : int32 -> int32 = "%identity"
  external to_int64 : int32 -> int64 = "int64_of_int32"
  external to_int128 : int32 -> int128 = "int128_of_int32"
  external to_uint8 : int32 -> uint8 = "uint8_of_int32"
  external to_uint16 : int32 -> uint16 = "uint16_of_int32"
  external to_uint32 : int32 -> uint32 = "uint32_of_int32"
  external to_uint64 : int32 -> uint64 = "uint64_of_int32"
  external to_uint128 : int32 -> uint128 = "uint128_of_int32"

  let bits    = 32

  module Conv = Str_conv.Make(struct
    type t      = int32
    let fmt     = "l"
    let name    = "int32"
    let zero    = zero
    let max_int = max_int
    let min_int = min_int
    let bits    = bits
    let of_int  = of_int
    let to_int  = to_int
    let add     = add
    let sub     = sub
    let mul     = mul
    let divmod  = (fun x y -> div x y, rem x y)
  end)

  let to_string_bin = Conv.to_string_bin
  let to_string_oct = Conv.to_string_oct
  let to_string_hex = Conv.to_string_hex
  let printer = Conv.printer
  let printer_bin = Conv.printer_bin
  let printer_oct = Conv.printer_oct
  let printer_hex = Conv.printer_hex

  module Endian = Bytes_conv.Make(struct
    type t      = int32
    let zero    = zero
    let bits    = bits
    let of_int  = of_int
    let to_int  = to_int
    let logand  = logand
    let logor   = logor
    let shift_left = shift_left
    let shift_right_logical = shift_right_logical
  end)
  let of_bytes_big_endian = Endian.of_bytes_big_endian
  let of_bytes_little_endian = Endian.of_bytes_little_endian
  let to_bytes_big_endian = Endian.to_bytes_big_endian
  let to_bytes_little_endian = Endian.to_bytes_little_endian

end

module Int64 = struct
  include Int64

  external of_int8 : int8 -> int64 = "int64_of_int8"
  external of_int16 : int16 -> int64 = "int64_of_int16"
  external of_int32 : int32 -> int64 = "int64_of_int32"
  external of_int64 : int64 -> int64 = "%identity"
  external of_int128 : int128 -> int64 = "int64_of_int128"
  external of_uint8 : uint8 -> int64 = "int64_of_uint8"
  external of_uint16 : uint16 -> int64 = "int64_of_uint16"
  external of_uint32 : uint32 -> int64 = "int64_of_uint32"
  external of_uint64 : uint64 -> int64 = "int64_of_uint64"
  external of_uint128 : uint128 -> int64 = "int64_of_uint128"
  external to_int8 : int64 -> int8 = "int8_of_int64"
  external to_int16 : int64 -> int16 = "int16_of_int64"
  external to_int32 : int64 -> int32 = "int32_of_int64"
  external to_int64 : int64 -> int64 = "%identity"
  external to_int128 : int64 -> int128 = "int128_of_int64"
  external to_uint8 : int64 -> uint8 = "uint8_of_int64"
  external to_uint16 : int64 -> uint16 = "uint16_of_int64"
  external to_uint32 : int64 -> uint32 = "uint32_of_int64"
  external to_uint64 : int64 -> uint64 = "uint64_of_int64"
  external to_uint128 : int64 -> uint128 = "uint128_of_int64"

  let bits    = 64

  module Conv = Str_conv.Make(struct
    type t      = int64
    let fmt     = "l"
    let name    = "int64"
    let zero    = zero
    let max_int = max_int
    let min_int = min_int
    let bits    = bits
    let of_int  = of_int
    let to_int  = to_int
    let add     = add
    let sub     = sub
    let mul     = mul
    let divmod  = (fun x y -> div x y, rem x y)
  end)

  let to_string_bin = Conv.to_string_bin
  let to_string_oct = Conv.to_string_oct
  let to_string_hex = Conv.to_string_hex
  let printer = Conv.printer
  let printer_bin = Conv.printer_bin
  let printer_oct = Conv.printer_oct
  let printer_hex = Conv.printer_hex

  module Endian = Bytes_conv.Make(struct
    type t      = int64
    let zero    = zero
    let bits    = bits
    let of_int  = of_int
    let to_int  = to_int
    let logand  = logand
    let logor   = logor
    let shift_left = shift_left
    let shift_right_logical = shift_right_logical
  end)
  let of_bytes_big_endian = Endian.of_bytes_big_endian
  let of_bytes_little_endian = Endian.of_bytes_little_endian
  let to_bytes_big_endian = Endian.to_bytes_big_endian
  let to_bytes_little_endian = Endian.to_bytes_little_endian
end

module Int128 = struct
  type t = int128

  external add : int128 -> int128 -> int128 = "int128_add"
  external sub : int128 -> int128 -> int128 = "int128_sub"
  external mul : int128 -> int128 -> int128 = "int128_mul"
  external div : int128 -> int128 -> int128 = "int128_div"
  external rem : int128 -> int128 -> int128 = "int128_mod"
  external logand : int128 -> int128 -> int128 = "int128_and"
  external logor : int128 -> int128 -> int128 = "int128_or"
  external logxor : int128 -> int128 -> int128 = "int128_xor"
  external shift_left : int128 -> int -> int128 = "int128_shift_left"
  external shift_right : int128 -> int -> int128 = "int128_shift_right"
  external shift_right_logical : int128 -> int -> int128 = "uint128_shift_right"
  external abs : int128 -> int128 = "int128_abs"

  external of_int : int -> int128 = "int128_of_int"
  external to_int : int128 -> int = "int_of_int128"
  external of_float : float -> int128 = "int128_of_float"
  external to_float : int128 -> float = "float_of_int128"
  external of_nativeint : nativeint -> int128 = "int128_of_nativeint"
  external to_nativeint : int128 -> nativeint = "nativeint_of_int128"

  external of_int8 : int8 -> int128 = "int128_of_int8"
  external of_int16 : int16 -> int128 = "int128_of_int16"
  external of_int32 : int32 -> int128 = "int128_of_int32"
  external of_int64 : int64 -> int128 = "int128_of_int64"
  external of_int128 : int128 -> int128 = "%identity"
  external of_uint8 : uint8 -> int128 = "int128_of_uint8"
  external of_uint16 : uint16 -> int128 = "int128_of_uint16"
  external of_uint32 : uint32 -> int128 = "int128_of_uint32"
  external of_uint64 : uint64 -> int128 = "int128_of_uint64"
  external of_uint128 : uint128 -> int128 = "int128_of_uint128"
  external to_int8 : int128 -> int8 = "int8_of_int128"
  external to_int16 : int128 -> int16 = "int16_of_int128"
  external to_int32 : int128 -> int32 = "int32_of_int128"
  external to_int64 : int128 -> int64 = "int64_of_int128"
  external to_int128 : int128 -> int128 = "%identity"
  external to_uint8 : int128 -> uint8 = "uint8_of_int128"
  external to_uint16 : int128 -> uint16 = "uint16_of_int128"
  external to_uint32 : int128 -> uint32 = "uint32_of_int128"
  external to_uint64 : int128 -> uint64 = "uint64_of_int128"
  external to_uint128 : int128 -> uint128 = "uint128_of_int128"

  external max_int_fun : unit -> int128 = "int128_max_int"
  external min_int_fun : unit -> int128 = "int128_min_int"

  let zero = of_int 0
  let one = of_int 1
  let succ = add one
  let pred x = sub x one
  let max_int = max_int_fun ()
  let min_int = min_int_fun ()
  let lognot = logxor max_int
  let compare = Pervasives.compare
  let bits    = 128

  module Conv = Str_conv.Make(struct
    type t      = int128
    let fmt     = "LL"
    let name    = "Int1128"
    let zero    = zero
    let max_int = max_int
    let min_int = min_int
    let bits    = bits
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

  module Endian = Bytes_conv.Make(struct
    type t      = int128
    let zero    = zero
    let bits    = bits
    let of_int  = of_int
    let to_int  = to_int
    let logand  = logand
    let logor   = logor
    let shift_left = shift_left
    let shift_right_logical = shift_right_logical
  end)
  let of_bytes_big_endian = Endian.of_bytes_big_endian
  let of_bytes_little_endian = Endian.of_bytes_little_endian
  let to_bytes_big_endian = Endian.to_bytes_big_endian
  let to_bytes_little_endian = Endian.to_bytes_little_endian

  external init_custom_ops : unit -> unit = "int128_init_custom_ops"
  let () = init_custom_ops ()
end

module Uint8 = struct
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
  let shift_right_logical = shift_right
  external abs : uint8 -> uint8 = "%identity"

  external of_int : int -> uint8 = "uint8_of_int"
  external to_int : uint8 -> int = "int_of_uint8"
  external of_float : float -> uint8 = "uint8_of_float"
  external to_float : uint8 -> float = "float_of_uint8"
  external of_nativeint : nativeint -> uint8 = "uint8_of_nativeint"
  external to_nativeint : uint8 -> nativeint = "nativeint_of_uint8"

  external of_int8 : int8 -> uint8 = "uint8_of_int8"
  external of_int16 : int16 -> uint8 = "uint8_of_int16"
  external of_int32 : int32 -> uint8 = "uint8_of_int32"
  external of_int64 : int64 -> uint8 = "uint8_of_int64"
  external of_int128 : int128 -> uint8 = "uint8_of_int128"
  external of_uint8 : uint8 -> uint8 = "%identity"
  external of_uint16 : uint16 -> uint8 = "uint8_of_uint16"
  external of_uint32 : uint32 -> uint8 = "uint8_of_uint32"
  external of_uint64 : uint64 -> uint8 = "uint8_of_uint64"
  external of_uint128 : uint128 -> uint8 = "uint8_of_uint128"
  external to_int8 : uint8 -> int8 = "int8_of_uint8"
  external to_int16 : uint8 -> int16 = "int16_of_uint8"
  external to_int32 : uint8 -> int32 = "int32_of_uint8"
  external to_int64 : uint8 -> int64 = "int64_of_uint8"
  external to_int128 : uint8 -> int128 = "int128_of_uint8"
  external to_uint8 : uint8 -> uint8 = "%identity"
  external to_uint16 : uint8 -> uint16 = "uint16_of_uint8"
  external to_uint32 : uint8 -> uint32 = "uint32_of_uint8"
  external to_uint64 : uint8 -> uint64 = "uint64_of_uint8"
  external to_uint128 : uint8 -> uint128 = "uint128_of_uint8"

  external max_int_fun : unit -> uint8 = "uint8_max_int"

  let zero = of_int 0
  let one = of_int 1
  let succ = add one
  let pred x = sub x one
  let max_int = max_int_fun ()
  let min_int = zero
  let lognot = logxor max_int
  let compare = Pervasives.compare
  let bits    = 8

  module Conv = Str_conv.Make(struct
    type t      = uint8
    let fmt     = "Ul"
    let name    = "Uint8"
    let zero    = zero
    let max_int = max_int
    let min_int = min_int
    let bits    = bits
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

  module Endian = Bytes_conv.Make(struct
    type t      = uint8
    let zero    = zero
    let bits    = bits
    let of_int  = of_int
    let to_int  = to_int
    let logand  = logand
    let logor   = logor
    let shift_left = shift_left
    let shift_right_logical = shift_right_logical
  end)
  let of_bytes_big_endian = Endian.of_bytes_big_endian
  let of_bytes_little_endian = Endian.of_bytes_little_endian
  let to_bytes_big_endian = Endian.to_bytes_big_endian
  let to_bytes_little_endian = Endian.to_bytes_little_endian

  external init_custom_ops : unit -> unit = "uint8_init_custom_ops"
  let () = init_custom_ops ()
end

module Uint16 = struct
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
  let shift_right_logical = shift_right
  external abs : uint16 -> uint16 = "%identity"

  external of_int : int -> uint16 = "uint16_of_int"
  external to_int : uint16 -> int = "int_of_uint16"
  external of_float : float -> uint16 = "uint16_of_float"
  external to_float : uint16 -> float = "float_of_uint16"
  external of_nativeint : nativeint -> uint16 = "uint16_of_nativeint"
  external to_nativeint : uint16 -> nativeint = "nativeint_of_uint16"

  external of_int8 : int8 -> uint16 = "uint16_of_int8"
  external of_int16 : int16 -> uint16 = "uint16_of_int16"
  external of_int32 : int32 -> uint16 = "uint16_of_int32"
  external of_int64 : int64 -> uint16 = "uint16_of_int64"
  external of_int128 : int128 -> uint16 = "uint16_of_int128"
  external of_uint8 : uint8 -> uint16 = "uint16_of_uint8"
  external of_uint16 : uint16 -> uint16 = "%identity"
  external of_uint32 : uint32 -> uint16 = "uint16_of_uint32"
  external of_uint64 : uint64 -> uint16 = "uint16_of_uint64"
  external of_uint128 : uint128 -> uint16 = "uint16_of_uint128"
  external to_int8 : uint16 -> int8 = "int8_of_uint16"
  external to_int16 : uint16 -> int16 = "int16_of_uint16"
  external to_int32 : uint16 -> int32 = "int32_of_uint16"
  external to_int64 : uint16 -> int64 = "int64_of_uint16"
  external to_int128 : uint16 -> int128 = "int128_of_uint16"
  external to_uint8 : uint16 -> uint8 = "uint8_of_uint16"
  external to_uint16 : uint16 -> uint16 = "%identity"
  external to_uint32 : uint16 -> uint32 = "uint32_of_uint16"
  external to_uint64 : uint16 -> uint64 = "uint64_of_uint16"
  external to_uint128 : uint16 -> uint128 = "uint128_of_uint16"

  external max_int_fun : unit -> uint16 = "uint16_max_int"

  let zero = of_int 0
  let one = of_int 1
  let succ = add one
  let pred x = sub x one
  let max_int = max_int_fun ()
  let min_int = zero
  let lognot = logxor max_int
  let compare = Pervasives.compare
  let bits    = 16

  module Conv = Str_conv.Make(struct
    type t      = uint16
    let fmt     = "Ul"
    let name    = "Uint16"
    let zero    = zero
    let max_int = max_int
    let min_int = min_int
    let bits    = bits
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

  module Endian = Bytes_conv.Make(struct
    type t      = uint16
    let zero    = zero
    let bits    = bits
    let of_int  = of_int
    let to_int  = to_int
    let logand  = logand
    let logor   = logor
    let shift_left = shift_left
    let shift_right_logical = shift_right_logical
  end)
  let of_bytes_big_endian = Endian.of_bytes_big_endian
  let of_bytes_little_endian = Endian.of_bytes_little_endian
  let to_bytes_big_endian = Endian.to_bytes_big_endian
  let to_bytes_little_endian = Endian.to_bytes_little_endian

  external init_custom_ops : unit -> unit = "uint16_init_custom_ops"
  let () = init_custom_ops ()
end

module Uint32 = struct
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
  let shift_right_logical = shift_right
  external abs : uint32 -> uint32 = "%identity"

  external of_int : int -> uint32 = "uint32_of_int"
  external to_int : uint32 -> int = "int_of_uint32"
  external of_float : float -> uint32 = "uint32_of_float"
  external to_float : uint32 -> float = "float_of_uint32"
  external of_nativeint : nativeint -> uint32 = "uint32_of_nativeint"
  external to_nativeint : uint32 -> nativeint = "nativeint_of_uint32"

  external of_int8 : int8 -> uint32 = "uint32_of_int8"
  external of_int16 : int16 -> uint32 = "uint32_of_int16"
  external of_int32 : int32 -> uint32 = "uint32_of_int32"
  external of_int64 : int64 -> uint32 = "uint32_of_int64"
  external of_int128 : int128 -> uint32 = "uint32_of_int128"
  external of_uint8 : uint8 -> uint32 = "uint32_of_uint8"
  external of_uint16 : uint16 -> uint32 = "uint32_of_uint16"
  external of_uint32 : uint32 -> uint32 = "%identity"
  external of_uint64 : uint64 -> uint32 = "uint32_of_uint64"
  external of_uint128 : uint128 -> uint32 = "uint32_of_uint128"
  external to_int8 : uint32 -> int8 = "int8_of_uint32"
  external to_int16 : uint32 -> int16 = "int16_of_uint32"
  external to_int32 : uint32 -> int32 = "int32_of_uint32"
  external to_int64 : uint32 -> int64 = "int64_of_uint32"
  external to_int128 : uint32 -> int128 = "int128_of_uint32"
  external to_uint8 : uint32 -> uint8 = "uint8_of_uint32"
  external to_uint16 : uint32 -> uint16 = "uint16_of_uint32"
  external to_uint32 : uint32 -> uint32 = "%identity"
  external to_uint64 : uint32 -> uint64 = "uint64_of_uint32"
  external to_uint128 : uint32 -> uint128 = "uint128_of_uint32"

  external max_int_fun : unit -> uint32 = "uint32_max_int"

  let zero = of_int 0
  let one = of_int 1
  let succ = add one
  let pred x = sub x one
  let max_int = max_int_fun ()
  let min_int = zero
  let lognot = logxor max_int
  let compare = Pervasives.compare
  let bits = 32

  module Conv = Str_conv.Make(struct
    type t      = uint32
    let fmt     = "Ul"
    let name    = "Uint32"
    let zero    = zero
    let max_int = max_int
    let min_int = min_int
    let bits    = bits
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

  module Endian = Bytes_conv.Make(struct
    type t      = uint32
    let zero    = zero
    let bits    = bits
    let of_int  = of_int
    let to_int  = to_int
    let logand  = logand
    let logor   = logor
    let shift_left = shift_left
    let shift_right_logical = shift_right_logical
  end)
  let of_bytes_big_endian = Endian.of_bytes_big_endian
  let of_bytes_little_endian = Endian.of_bytes_little_endian
  let to_bytes_big_endian = Endian.to_bytes_big_endian
  let to_bytes_little_endian = Endian.to_bytes_little_endian

  external init_custom_ops : unit -> unit = "uint32_init_custom_ops"
  let () = init_custom_ops ()
end

module Uint64 = struct
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
  let shift_right_logical = shift_right
  external abs : uint64 -> uint64 = "%identity"

  external of_int : int -> uint64 = "uint64_of_int"
  external to_int : uint64 -> int = "int_of_uint64"
  external of_float : float -> uint64 = "uint64_of_float"
  external to_float : uint64 -> float = "float_of_uint64"
  external of_nativeint : nativeint -> uint64 = "uint64_of_nativeint"
  external to_nativeint : uint64 -> nativeint = "nativeint_of_uint64"

  external of_int8 : int8 -> uint64 = "uint64_of_int8"
  external of_int16 : int16 -> uint64 = "uint64_of_int16"
  external of_int32 : int32 -> uint64 = "uint64_of_int32"
  external of_int64 : int64 -> uint64 = "uint64_of_int64"
  external of_int128 : int128 -> uint64 = "uint64_of_int128"
  external of_uint8 : uint8 -> uint64 = "uint64_of_uint8"
  external of_uint16 : uint16 -> uint64 = "uint64_of_uint16"
  external of_uint32 : uint32 -> uint64 = "uint64_of_uint32"
  external of_uint64 : uint64 -> uint64 = "%identity"
  external of_uint128 : uint128 -> uint64 = "uint64_of_uint128"
  external to_int8 : uint64 -> int8 = "int8_of_uint64"
  external to_int16 : uint64 -> int16 = "int16_of_uint64"
  external to_int32 : uint64 -> int32 = "int32_of_uint64"
  external to_int64 : uint64 -> int64 = "int64_of_uint64"
  external to_int128 : uint64 -> int128 = "int128_of_uint64"
  external to_uint8 : uint64 -> uint8 = "uint8_of_uint64"
  external to_uint16 : uint64 -> uint16 = "uint16_of_uint64"
  external to_uint32 : uint64 -> uint32 = "uint32_of_uint64"
  external to_uint64 : uint64 -> uint64 = "%identity"
  external to_uint128 : uint64 -> uint128 = "uint128_of_uint64"

  external max_int_fun : unit -> uint64 = "uint64_max_int"

  let zero = of_int 0
  let one = of_int 1
  let succ = add one
  let pred x = sub x one
  let max_int = max_int_fun ()
  let min_int = zero
  let lognot = logxor max_int
  let compare = Pervasives.compare
  let bits = 64

  module Conv = Str_conv.Make(struct
    type t      = uint64
    let name    = "Uint64"
    let fmt     = "UL"
    let zero    = zero
    let max_int = max_int
    let min_int = min_int
    let bits    = bits
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

  module Endian = Bytes_conv.Make(struct
    type t      = uint64
    let zero    = zero
    let bits    = bits
    let of_int  = of_int
    let to_int  = to_int
    let logand  = logand
    let logor   = logor
    let shift_left = shift_left
    let shift_right_logical = shift_right_logical
  end)
  let of_bytes_big_endian = Endian.of_bytes_big_endian
  let of_bytes_little_endian = Endian.of_bytes_little_endian
  let to_bytes_big_endian = Endian.to_bytes_big_endian
  let to_bytes_little_endian = Endian.to_bytes_little_endian

  external init_custom_ops : unit -> unit = "uint64_init_custom_ops"
  let () = init_custom_ops ()
end

module Uint128 = struct
  type t = uint128

  external add : uint128 -> uint128 -> uint128 = "uint128_add"
  external sub : uint128 -> uint128 -> uint128 = "uint128_sub"
  external mul : uint128 -> uint128 -> uint128 = "uint128_mul"
  external div : uint128 -> uint128 -> uint128 = "uint128_div"
  external rem : uint128 -> uint128 -> uint128 = "uint128_mod"
  external logand : uint128 -> uint128 -> uint128 = "uint128_and"
  external logor : uint128 -> uint128 -> uint128 = "uint128_or"
  external logxor : uint128 -> uint128 -> uint128 = "uint128_xor"
  external shift_left : uint128 -> int -> uint128 = "uint128_shift_left"
  external shift_right : uint128 -> int -> uint128 = "uint128_shift_right"
  let shift_right_logical = shift_right
  external abs : uint128 -> uint128 = "%identity"

  external of_int : int -> uint128 = "uint128_of_int"
  external to_int : uint128 -> int = "int_of_uint128"
  external of_float : float -> uint128 = "uint128_of_float"
  external to_float : uint128 -> float = "float_of_uint128"
  external of_nativeint : nativeint -> uint128 = "uint128_of_nativeint"
  external to_nativeint : uint128 -> nativeint = "nativeint_of_uint128"

  external of_int8 : int8 -> uint128 = "uint128_of_int8"
  external of_int16 : int16 -> uint128 = "uint128_of_int16"
  external of_int32 : int32 -> uint128 = "uint128_of_int32"
  external of_int64 : int64 -> uint128 = "uint128_of_int64"
  external of_int128 : int128 -> uint128 = "uint128_of_int128"
  external of_uint8 : uint8 -> uint128 = "uint128_of_uint8"
  external of_uint16 : uint16 -> uint128 = "uint128_of_uint16"
  external of_uint32 : uint32 -> uint128 = "uint128_of_uint32"
  external of_uint64 : uint64 -> uint128 = "uint128_of_uint64"
  external of_uint128 : uint128 -> uint128 = "%identity"
  external to_int8 : uint128 -> int8 = "int8_of_uint128"
  external to_int16 : uint128 -> int16 = "int16_of_uint128"
  external to_int32 : uint128 -> int32 = "int32_of_uint128"
  external to_int64 : uint128 -> int64 = "int64_of_uint128"
  external to_int128 : uint128 -> int128 = "int128_of_uint128"
  external to_uint8 : uint128 -> uint8 = "uint8_of_uint128"
  external to_uint16 : uint128 -> uint16 = "uint16_of_uint128"
  external to_uint32 : uint128 -> uint32 = "uint32_of_uint128"
  external to_uint64 : uint128 -> uint64 = "uint64_of_uint128"
  external to_uint128 : uint128 -> uint128 = "%identity"

  external max_int_fun : unit -> uint128 = "uint128_max_int"
  external min_int_fun : unit -> uint128 = "uint128_min_int"

  let zero = of_int 0
  let one = of_int 1
  let succ = add one
  let pred x = sub x one
  let max_int = max_int_fun ()
  let min_int = zero
  let lognot = logxor max_int
  let compare = Pervasives.compare
  let bits = 128

  module Conv = Str_conv.Make(struct
    type t      = uint128
    let fmt     = "ULL"
    let name    = "Int1128"
    let zero    = zero
    let max_int = max_int
    let min_int = min_int
    let bits    = bits
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

  module Endian = Bytes_conv.Make(struct
    type t      = uint128
    let zero    = zero
    let bits    = bits
    let of_int  = of_int
    let to_int  = to_int
    let logand  = logand
    let logor   = logor
    let shift_left = shift_left
    let shift_right_logical = shift_right_logical
  end)
  let of_bytes_big_endian = Endian.of_bytes_big_endian
  let of_bytes_little_endian = Endian.of_bytes_little_endian
  let to_bytes_big_endian = Endian.to_bytes_big_endian
  let to_bytes_little_endian = Endian.to_bytes_little_endian

  external init_custom_ops : unit -> unit = "uint128_init_custom_ops"
  let () = init_custom_ops ()
end
(*
module Endian = struct
  module type S = sig
    val to_uint8 : Bytes.t -> int -> Uint8.t
    val to_uint16 : Bytes.t -> int -> Uint16.t
    val to_uint32 : Bytes.t -> int -> Uint32.t
    val to_uint64 : Bytes.t -> int -> Uint64.t
    val to_uint128 : Bytes.t -> int -> Uint128.t

    val to_int8 : Bytes.t -> int -> Int8.t
    val to_int16 : Bytes.t -> int -> Int16.t
    val to_int32 : Bytes.t -> int -> Int32.t
    val to_int64 : Bytes.t -> int -> Int64.t
    val to_int128 : Bytes.t -> int -> Int128.t

    val of_uint8 : Uint8.t -> Bytes.t -> int -> unit
    val of_uint16 : Uint16.t -> Bytes.t -> int -> unit
    val of_uint32 : Uint32.t -> Bytes.t -> int -> unit
    val of_uint64 : Uint64.t -> Bytes.t -> int -> unit
    val of_uint128 : Uint128.t -> Bytes.t -> int -> unit

    val of_int8 : Int8.t -> Bytes.t -> int -> unit
    val of_int16 : Int16.t -> Bytes.t -> int -> unit
    val of_int32 : Int32.t -> Bytes.t -> int -> unit
    val of_int64 : Int64.t -> Bytes.t -> int -> unit
    val of_int128 : Int128.t -> Bytes.t -> int -> unit
  end

  let int_of_pos buffer offset =
    Char.code (Bytes.get buffer offset)

  module Big = struct
    let to_uint8 buffer offset =
      Uint8.of_int (int_of_pos buffer offset)

    let to_uint16 buffer offset =
      let lsb = Uint16.of_int (int_of_pos buffer (offset + 1)) in
      let msb = Uint16.of_int (int_of_pos buffer offset) in
      Uint16.add (Uint16.shift_left msb 8) lsb

(*

    let to_uint32 buffer offset =
      let f n p = Uint32.shift_left (Uint32.of_int (Char.code (Bytes.get buffer (buffer + n)))) p in
      let lsb = f 3 0 in
      let ib1 = f 2 8 in
      let ib2 = f 1 16 in
      let msb = f 0 24 in
      Uint32.add lsb (Uint32.add ib1 (Uint32.add ib2 msb))
    let to_uint64 buffer offset =
      

    let to_uint128 : Bytes.t -> int -> Uint128.t

    let to_int8 : Bytes.t -> int -> Int8.t
    let to_int16 : Bytes.t -> int -> Int16.t
    let to_int32 : Bytes.t -> int -> Int32.t
    let to_int64 : Bytes.t -> int -> Int64.t
    let to_int128 : Bytes.t -> int -> Int128.t

    let of_uint8 : Uint8.t -> Bytes.t -> int -> unit
    let of_uint16 : Uint16.t -> Bytes.t -> int -> unit
    let of_uint32 : Uint32.t -> Bytes.t -> int -> unit
    let of_uint64 : Uint64.t -> Bytes.t -> int -> unit
    let of_uint128 : Uint128.t -> Bytes.t -> int -> unit

    let of_int8 : Int8.t -> Bytes.t -> int -> unit
    let of_int16 : Int16.t -> Bytes.t -> int -> unit
    let of_int32 : Int32.t -> Bytes.t -> int -> unit
    let of_int64 : Int64.t -> Bytes.t -> int -> unit
    let of_int128 : Int128.t -> Bytes.t -> int -> unit
*)
  end

  module Make (I : Int) = struct
    let of_bytes_big_endian buffer offset =
      let rec loop buffer i n =
        if i = (I.bits / 8) then n
        else
          let b = I.of_int (int_of_pos buffer (offset + i)) in
          let n' = I.logor (I.shift_left n 8) b in
          loop buffer (i + 1) n'
      in
      loop buffer 0 I.zero

    let of_bytes_little_endian buffer offset =
      let rec loop buffer i n =
        if i = 0 then n
        else
          let b = I.of_int (int_of_pos buffer (offset + i - 1)) in
          let n' = I.logor (I.shift_left n 8) b in
          loop buffer (i - 1) n'
      in
      loop buffer (I.bits / 8) I.zero

    let to_bytes_big_endian v buffer offset =
      let rec loop buffer i n =
        if i = 0 then ()
        else
          let b = Char.chr (I.to_int (I.logand (I.of_int 0xFF) n)) in
          let () = Bytes.set buffer (offset + i - 1) b in
          let n' = I.shift_right_logical n 8 in
          loop buffer (i - 1) n'
      in
      loop buffer (I.bits / 8) v

    let to_bytes_little_endian v buffer offset =
      let rec loop buffer i n =
        if i = (I.bits / 8) then ()
        else
          let b = Char.chr (I.to_int (I.logand (I.of_int 0xFF) n)) in
          let () = Bytes.set buffer (offset + i) b in
          let n' = I.shift_right_logical n 8 in
          loop buffer (i + 1) n'
      in
      loop buffer 0 v
  end
end
*)
