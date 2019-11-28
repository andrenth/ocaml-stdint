type int8 = int
type int16 = int
type int32 = Int32.t
type int24 = int
type int64 = Int64.t
type int40 = int64
type int48 = int64
type int56 = int64
type int128
type uint8 = int
type uint16 = int
type uint24 = int
type uint32
type uint64
type uint40 = uint64
type uint48 = uint64
type uint56 = uint64
type uint128

module type Int = sig
  type t

  val zero : t
  val one : t
  val max_int : t
  val min_int : t
  val bits : int

  val ( + ) : t -> t -> t
  val ( - ) : t -> t -> t
  val ( * ) : t -> t -> t
  val ( / ) : t -> t -> t

  val add : t -> t -> t
  val sub : t -> t -> t
  val mul : t -> t -> t
  val div : t -> t -> t
  val rem : t -> t -> t
  val succ : t -> t
  val pred : t -> t
  val abs : t -> t
  val neg : t -> t
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
  val of_int24 : int24 -> t
  val to_int24 : t -> int24
  val of_int32 : int32 -> t
  val to_int32 : t -> int32
  val of_int40 : int40 -> t
  val to_int40 : t -> int40
  val of_int48 : int48 -> t
  val to_int48 : t -> int48
  val of_int56 : int56 -> t
  val to_int56 : t -> int56
  val of_int64 : int64 -> t
  val to_int64 : t -> int64
  val of_int128 : int128 -> t
  val to_int128 : t -> int128

  val of_uint8 : uint8 -> t
  val to_uint8 : t -> uint8
  val of_uint16 : uint16 -> t
  val to_uint16 : t -> uint16
  val of_uint24 : uint24 -> t
  val to_uint24 : t -> uint24
  val of_uint32 : uint32 -> t
  val to_uint32 : t -> uint32
  val of_uint40 : uint40 -> t
  val to_uint40 : t -> uint40
  val of_uint48 : uint48 -> t
  val to_uint48 : t -> uint48
  val of_uint56 : uint56 -> t
  val to_uint56 : t -> uint56
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
  module Base = struct
    include Int_wrapper.Make_signed(struct let bits = 8 end)
    let fmt = "hh"
    let name = "Int8"
  end
  include Base

  external of_nativeint : nativeint ->      int8 = "int8_of_nativeint"
  external of_float     :     float ->      int8 = "int8_of_float"
  external of_int8      :      int8 ->      int8 = "%identity"
  external of_int16     :     int16 ->      int8 = "int8_of_int16"
  external of_int24     :     int24 ->      int8 = "int8_of_int24"
  external of_int32     :     int32 ->      int8 = "int8_of_int32"
  external of_int40     :     int40 ->      int8 = "int8_of_int40"
  external of_int48     :     int48 ->      int8 = "int8_of_int48"
  external of_int56     :     int56 ->      int8 = "int8_of_int56"
  external of_int64     :     int64 ->      int8 = "int8_of_int64"
  external of_int128    :    int128 ->      int8 = "int8_of_int128"
  external of_uint8     :     uint8 ->      int8 = "int8_of_uint8"
  external of_uint16    :    uint16 ->      int8 = "int8_of_uint16"
  external of_uint24    :    uint24 ->      int8 = "int8_of_uint24"
  external of_uint32    :    uint32 ->      int8 = "int8_of_uint32"
  external of_uint40    :    uint40 ->      int8 = "int8_of_uint40"
  external of_uint48    :    uint48 ->      int8 = "int8_of_uint48"
  external of_uint56    :    uint56 ->      int8 = "int8_of_uint56"
  external of_uint64    :    uint64 ->      int8 = "int8_of_uint64"
  external of_uint128   :   uint128 ->      int8 = "int8_of_uint128"

  external to_nativeint :      int8 -> nativeint = "nativeint_of_int8"
  external to_float     :      int8 ->     float = "float_of_int8"
  external to_int8      :      int8 ->      int8 = "%identity"
  external to_int16     :      int8 ->     int16 = "int16_of_int8"
  external to_int24     :      int8 ->     int24 = "int24_of_int8"
  external to_int32     :      int8 ->     int32 = "int32_of_int8"
  external to_int40     :      int8 ->     int40 = "int40_of_int8"
  external to_int48     :      int8 ->     int48 = "int48_of_int8"
  external to_int56     :      int8 ->     int56 = "int56_of_int8"
  external to_int64     :      int8 ->     int64 = "int64_of_int8"
  external to_int128    :      int8 ->    int128 = "int128_of_int8"
  external to_uint8     :      int8 ->     uint8 = "uint8_of_int8"
  external to_uint16    :      int8 ->    uint16 = "uint16_of_int8"
  external to_uint24    :      int8 ->    uint24 = "uint24_of_int8"
  external to_uint32    :      int8 ->    uint32 = "uint32_of_int8"
  external to_uint40    :      int8 ->    uint40 = "uint40_of_int8"
  external to_uint48    :      int8 ->    uint48 = "uint48_of_int8"
  external to_uint56    :      int8 ->    uint56 = "uint56_of_int8"
  external to_uint64    :      int8 ->    uint64 = "uint64_of_int8"
  external to_uint128   :      int8 ->   uint128 = "uint128_of_int8"

  external bits_of_float : float -> int8 = "int8_bits_of_float"
  external float_of_bits : int8 -> float = "int8_float_of_bits"

  module Conv = Str_conv.Make(Base)
  include (Conv : module type of Conv with type t := int8)

  module Endian = Bytes_conv.Make(Base)
  include (Endian : module type of Endian with type t := int8)

  module Inf = Infix.Make(Base)
  include (Inf : module type of Inf with type t := int8)
end

module Int16 = struct
  module Base = struct
    include Int_wrapper.Make_signed(struct let bits = 16 end)
    let fmt = "h"
    let name = "int16"
  end
  include Base

  external of_nativeint : nativeint ->     int16 = "int16_of_nativeint"
  external of_float     :     float ->     int16 = "int16_of_float"
  external of_int8      :      int8 ->     int16 = "int16_of_int8"
  external of_int16     :     int16 ->     int16 = "%identity"
  external of_int24     :     int24 ->     int16 = "int16_of_int24"
  external of_int32     :     int32 ->     int16 = "int16_of_int32"
  external of_int40     :     int40 ->     int16 = "int16_of_int40"
  external of_int48     :     int48 ->     int16 = "int16_of_int48"
  external of_int56     :     int56 ->     int16 = "int16_of_int56"
  external of_int64     :     int64 ->     int16 = "int16_of_int64"
  external of_int128    :    int128 ->     int16 = "int16_of_int128"
  external of_uint8     :     uint8 ->     int16 = "int16_of_uint8"
  external of_uint16    :    uint16 ->     int16 = "int16_of_uint16"
  external of_uint24    :    uint24 ->     int16 = "int16_of_uint24"
  external of_uint32    :    uint32 ->     int16 = "int16_of_uint32"
  external of_uint40    :    uint40 ->     int16 = "int16_of_uint40"
  external of_uint48    :    uint48 ->     int16 = "int16_of_uint48"
  external of_uint56    :    uint56 ->     int16 = "int16_of_uint56"
  external of_uint64    :    uint64 ->     int16 = "int16_of_uint64"
  external of_uint128   :   uint128 ->     int16 = "int16_of_uint128"

  external to_nativeint :     int16 -> nativeint = "nativeint_of_int16"
  external to_float     :     int16 ->     float = "float_of_int16"
  external to_int8      :     int16 ->      int8 = "int8_of_int16"
  external to_int16     :     int16 ->     int16 = "%identity"
  external to_int24     :     int16 ->     int24 = "int24_of_int16"
  external to_int32     :     int16 ->     int32 = "int32_of_int16"
  external to_int40     :     int16 ->     int40 = "int40_of_int16"
  external to_int48     :     int16 ->     int48 = "int48_of_int16"
  external to_int56     :     int16 ->     int56 = "int56_of_int16"
  external to_int64     :     int16 ->     int64 = "int64_of_int16"
  external to_int128    :     int16 ->    int128 = "int128_of_int16"
  external to_uint8     :     int16 ->     uint8 = "uint8_of_int16"
  external to_uint16    :     int16 ->    uint16 = "uint16_of_int16"
  external to_uint24    :     int16 ->    uint24 = "uint24_of_int16"
  external to_uint32    :     int16 ->    uint32 = "uint32_of_int16"
  external to_uint40    :     int16 ->    uint40 = "uint40_of_int16"
  external to_uint48    :     int16 ->    uint48 = "uint48_of_int16"
  external to_uint56    :     int16 ->    uint56 = "uint56_of_int16"
  external to_uint64    :     int16 ->    uint64 = "uint64_of_int16"
  external to_uint128   :     int16 ->   uint128 = "uint128_of_int16"

  external bits_of_float : float -> int16 = "int16_bits_of_float"
  external float_of_bits : int16 -> float = "int16_float_of_bits"

  module Conv = Str_conv.Make(Base)
  include (Conv : module type of Conv with type t := int16)

  module Endian = Bytes_conv.Make(Base)
  include (Endian : module type of Endian with type t := int16)

  module Inf = Infix.Make(Base)
  include (Inf : module type of Inf with type t := int16)
end

module Int24 = struct
  module Base = struct
    include Int_wrapper.Make_signed(struct let bits = 24 end)
    let fmt = "l"
    let name = "Int24"
  end
  include Base

  external of_nativeint : nativeint ->     int24 = "int24_of_nativeint"
  external of_float     :     float ->     int24 = "int24_of_float"
  external of_int8      :      int8 ->     int24 = "int24_of_int8"
  external of_int16     :     int16 ->     int24 = "int24_of_int16"
  external of_int24     :     int24 ->     int24 = "%identity"
  external of_int32     :     int32 ->     int24 = "int24_of_int32"
  external of_int40     :     int40 ->     int24 = "int24_of_int40"
  external of_int48     :     int48 ->     int24 = "int24_of_int48"
  external of_int56     :     int56 ->     int24 = "int24_of_int56"
  external of_int64     :     int64 ->     int24 = "int24_of_int64"
  external of_int128    :    int128 ->     int24 = "int24_of_int128"
  external of_uint8     :     uint8 ->     int24 = "int24_of_uint8"
  external of_uint16    :    uint16 ->     int24 = "int24_of_uint16"
  external of_uint24    :    uint24 ->     int24 = "int24_of_uint24"
  external of_uint32    :    uint32 ->     int24 = "int24_of_uint32"
  external of_uint40    :    uint40 ->     int24 = "int24_of_uint40"
  external of_uint48    :    uint48 ->     int24 = "int24_of_uint48"
  external of_uint56    :    uint56 ->     int24 = "int24_of_uint56"
  external of_uint64    :    uint64 ->     int24 = "int24_of_uint64"
  external of_uint128   :   uint128 ->     int24 = "int24_of_uint128"

  external to_nativeint :     int24 -> nativeint = "nativeint_of_int24"
  external to_float     :     int24 ->     float = "float_of_int24"
  external to_int8      :     int24 ->      int8 = "int8_of_int24"
  external to_int16     :     int24 ->     int16 = "int16_of_int24"
  external to_int24     :     int24 ->     int24 = "%identity"
  external to_int32     :     int24 ->     int32 = "int32_of_int24"
  external to_int40     :     int24 ->     int40 = "int40_of_int24"
  external to_int48     :     int24 ->     int48 = "int48_of_int24"
  external to_int56     :     int24 ->     int56 = "int56_of_int24"
  external to_int64     :     int24 ->     int64 = "int64_of_int24"
  external to_int128    :     int24 ->    int128 = "int128_of_int24"
  external to_uint8     :     int24 ->     uint8 = "uint8_of_int24"
  external to_uint16    :     int24 ->    uint16 = "uint16_of_int24"
  external to_uint24    :     int24 ->    uint24 = "uint24_of_int24"
  external to_uint32    :     int24 ->    uint32 = "uint32_of_int24"
  external to_uint40    :     int24 ->    uint40 = "uint40_of_int24"
  external to_uint48    :     int24 ->    uint48 = "uint48_of_int24"
  external to_uint56    :     int24 ->    uint56 = "uint56_of_int24"
  external to_uint64    :     int24 ->    uint64 = "uint64_of_int24"
  external to_uint128   :     int24 ->   uint128 = "uint128_of_int24"

  module Conv = Str_conv.Make(Base)
  include (Conv : module type of Conv with type t := int24)

  module Endian = Bytes_conv.Make(Base)
  include (Endian : module type of Endian with type t := int24)

  module Inf = Infix.Make(Base)
  include (Inf : module type of Inf with type t := int24)
end

module Int32 = struct
  module Base = struct
    include Int32
    let bits    = 32
    let fmt     = "l"
    let name    = "int32"

    let divmod  = (fun x y -> div x y, rem x y)
  end
  include Base

  let of_nativeint = Nativeint.to_int32
  let to_nativeint = Nativeint.of_int32

  external of_int8      :      int8 ->     int32 = "int32_of_int8"
  external of_int16     :     int16 ->     int32 = "int32_of_int16"
  external of_int24     :     int24 ->     int32 = "int32_of_int24"
  external of_int32     :     int32 ->     int32 = "%identity"
  external of_int40     :     int40 ->     int32 = "int32_of_int40"
  external of_int48     :     int48 ->     int32 = "int32_of_int48"
  external of_int56     :     int56 ->     int32 = "int32_of_int56"
  external of_int64     :     int64 ->     int32 = "int32_of_int64"
  external of_int128    :    int128 ->     int32 = "int32_of_int128"
  external of_uint8     :     uint8 ->     int32 = "int32_of_uint8"
  external of_uint16    :    uint16 ->     int32 = "int32_of_uint16"
  external of_uint24    :    uint24 ->     int32 = "int32_of_uint24"
  external of_uint32    :    uint32 ->     int32 = "int32_of_uint32"
  external of_uint40    :    uint40 ->     int32 = "int32_of_uint40"
  external of_uint48    :    uint48 ->     int32 = "int32_of_uint48"
  external of_uint56    :    uint56 ->     int32 = "int32_of_uint56"
  external of_uint64    :    uint64 ->     int32 = "int32_of_uint64"
  external of_uint128   :   uint128 ->     int32 = "int32_of_uint128"

  external to_int8      :     int32 ->      int8 = "int8_of_int32"
  external to_int16     :     int32 ->     int16 = "int16_of_int32"
  external to_int24     :     int32 ->     int24 = "int24_of_int32"
  external to_int32     :     int32 ->     int32 = "%identity"
  external to_int40     :     int32 ->     int40 = "int40_of_int32"
  external to_int48     :     int32 ->     int48 = "int48_of_int32"
  external to_int56     :     int32 ->     int56 = "int56_of_int32"
  external to_int64     :     int32 ->     int64 = "int64_of_int32"
  external to_int128    :     int32 ->    int128 = "int128_of_int32"
  external to_uint8     :     int32 ->     uint8 = "uint8_of_int32"
  external to_uint16    :     int32 ->    uint16 = "uint16_of_int32"
  external to_uint24    :     int32 ->    uint24 = "uint24_of_int32"
  external to_uint32    :     int32 ->    uint32 = "uint32_of_int32"
  external to_uint40    :     int32 ->    uint40 = "uint40_of_int32"
  external to_uint48    :     int32 ->    uint48 = "uint48_of_int32"
  external to_uint56    :     int32 ->    uint56 = "uint56_of_int32"
  external to_uint64    :     int32 ->    uint64 = "uint64_of_int32"
  external to_uint128   :     int32 ->   uint128 = "uint128_of_int32"

  module Conv = Str_conv.Make(Base)
  include (Conv : module type of Conv with type t := int32)

  module Endian = Bytes_conv.Make(Base)
  include (Endian : module type of Endian with type t := int32)

  module Inf = Infix.Make(Base)
  include (Inf : module type of Inf with type t := int32)
end

module Int64 = struct
  module Base = struct
    include Int64
    let bits = 64
    let fmt = "ll"
    let name = "int64"
    let divmod  = (fun x y -> div x y, rem x y)
  end
  include Base

  external of_int8      :      int8 ->     int64 = "int64_of_int8"
  external of_int16     :     int16 ->     int64 = "int64_of_int16"
  external of_int24     :     int24 ->     int64 = "int64_of_int24"
  external of_int32     :     int32 ->     int64 = "int64_of_int32"
  external of_int40     :     int40 ->     int64 = "int64_of_int40"
  external of_int48     :     int48 ->     int64 = "int64_of_int48"
  external of_int56     :     int56 ->     int64 = "int64_of_int56"
  external of_int64     :     int64 ->     int64 = "%identity"
  external of_int128    :    int128 ->     int64 = "int64_of_int128"
  external of_uint8     :     uint8 ->     int64 = "int64_of_uint8"
  external of_uint16    :    uint16 ->     int64 = "int64_of_uint16"
  external of_uint24    :    uint24 ->     int64 = "int64_of_uint24"
  external of_uint32    :    uint32 ->     int64 = "int64_of_uint32"
  external of_uint40    :    uint40 ->     int64 = "int64_of_uint40"
  external of_uint48    :    uint48 ->     int64 = "int64_of_uint48"
  external of_uint56    :    uint56 ->     int64 = "int64_of_uint56"
  external of_uint64    :    uint64 ->     int64 = "int64_of_uint64"
  external of_uint128   :   uint128 ->     int64 = "int64_of_uint128"

  external to_int8      :     int64 ->      int8 = "int8_of_int64"
  external to_int16     :     int64 ->     int16 = "int16_of_int64"
  external to_int24     :     int64 ->     int24 = "int24_of_int64"
  external to_int32     :     int64 ->     int32 = "int32_of_int64"
  external to_int40     :     int64 ->     int40 = "int40_of_int64"
  external to_int48     :     int64 ->     int48 = "int48_of_int64"
  external to_int56     :     int64 ->     int56 = "int56_of_int64"
  external to_int64     :     int64 ->     int64 = "%identity"
  external to_int128    :     int64 ->    int128 = "int128_of_int64"
  external to_uint8     :     int64 ->     uint8 = "uint8_of_int64"
  external to_uint16    :     int64 ->    uint16 = "uint16_of_int64"
  external to_uint24    :     int64 ->    uint24 = "uint24_of_int64"
  external to_uint32    :     int64 ->    uint32 = "uint32_of_int64"
  external to_uint40    :     int64 ->    uint40 = "uint40_of_int64"
  external to_uint48    :     int64 ->    uint48 = "uint48_of_int64"
  external to_uint56    :     int64 ->    uint56 = "uint56_of_int64"
  external to_uint64    :     int64 ->    uint64 = "uint64_of_int64"
  external to_uint128   :     int64 ->   uint128 = "uint128_of_int64"

  module Conv = Str_conv.Make(Base)
  include (Conv : module type of Conv with type t := int64)

  module Endian = Bytes_conv.Make(Base)
  include (Endian : module type of Endian with type t := int64)

  module Inf = Infix.Make(Base)
  include (Inf : module type of Inf with type t := int64)
end

module Int40 = struct
  (* int40 is modeled as int64, where only the UPPER 40 bits are used;
     this has the advantage that most operations are identical to the int64 ones.
     The post-condition of all int40 opertaions is, that the LOWER 24 bit are 0x000000.
     Only operations that are not identical or do not preserve the post-condition are implemented.
  *)
  module Base = struct
    include Int64.Base
    let bits = 40
    let fmt = "ll"
    let name = "Int40"

    external mul : int40 -> int40 -> int40 = "uint40_mul"
    external div : int40 -> int40 -> int40 = "int40_div"
    external logxor : int40 -> int40 -> int40 = "uint40_xor"
    external shift_right : int40 -> int -> int40 = "uint40_shift_right"
    external shift_right_logical : int40 -> int -> int40 = "int40_shift_right"

    external of_int       :       int ->     int40 = "int40_of_int"
    external of_nativeint : nativeint ->     int40 = "int40_of_nativeint"
    external of_float     :     float ->     int40 = "int40_of_float"
    external of_int8      :      int8 ->     int40 = "int40_of_int8"
    external of_int16     :     int16 ->     int40 = "int40_of_int16"
    external of_int24     :     int24 ->     int40 = "int40_of_int24"
    external of_int32     :     int32 ->     int40 = "int40_of_int32"
    external of_int40     :     int40 ->     int40 = "%identity"
    external of_int48     :     int48 ->     int40 = "int40_of_int48"
    external of_int56     :     int56 ->     int40 = "int40_of_int56"
    external of_int64     :     int64 ->     int40 = "int40_of_int64"
    external of_int128    :    int128 ->     int40 = "int40_of_int128"
    external of_uint8     :     uint8 ->     int40 = "int40_of_uint8"
    external of_uint16    :    uint16 ->     int40 = "int40_of_uint16"
    external of_uint24    :    uint24 ->     int40 = "int40_of_uint24"
    external of_uint32    :    uint32 ->     int40 = "int40_of_uint32"
    external of_uint40    :    uint40 ->     int40 = "int40_of_uint40"
    external of_uint48    :    uint48 ->     int40 = "int40_of_uint48"
    external of_uint56    :    uint56 ->     int40 = "int40_of_uint56"
    external of_uint64    :    uint64 ->     int40 = "int40_of_uint64"
    external of_uint128   :   uint128 ->     int40 = "int40_of_uint128"

    external to_int       :     int40 ->       int = "int_of_int40"
    external to_nativeint :     int40 -> nativeint = "nativeint_of_int40"
    external to_float     :     int40 ->     float = "float_of_int40"
    external to_int8      :     int40 ->      int8 = "int8_of_int40"
    external to_int16     :     int40 ->     int16 = "int16_of_int40"
    external to_int24     :     int40 ->     int24 = "int24_of_int40"
    external to_int32     :     int40 ->     int32 = "int32_of_int40"
    external to_int40     :     int40 ->     int40 = "%identity"
    external to_int48     :     int40 ->     int48 = "int48_of_int40"
    external to_int56     :     int40 ->     int56 = "int56_of_int40"
    external to_int64     :     int40 ->     int64 = "int64_of_int40"
    external to_int128    :     int40 ->    int128 = "int128_of_int40"
    external to_uint8     :     int40 ->     uint8 = "uint8_of_int40"
    external to_uint16    :     int40 ->    uint16 = "uint16_of_int40"
    external to_uint24    :     int40 ->    uint24 = "uint24_of_int40"
    external to_uint32    :     int40 ->    uint32 = "uint32_of_int40"
    external to_uint40    :     int40 ->    uint40 = "uint40_of_int40"
    external to_uint48    :     int40 ->    uint48 = "uint48_of_int40"
    external to_uint56    :     int40 ->    uint56 = "uint56_of_int40"
    external to_uint64    :     int40 ->    uint64 = "uint64_of_int40"
    external to_uint128   :     int40 ->   uint128 = "uint128_of_int40"

    external max_int_fun : unit -> int40 = "int40_max_int"
    external min_int_fun : unit -> int40 = "int40_min_int"
    let one = of_int 1
    let max_int = max_int_fun ()
    let min_int = min_int_fun ()
    let lognot = logxor max_int
    let compare = Stdlib.compare
    let divmod  = (fun x y -> div x y, rem x y)
  end

  include Base

  module Conv = Str_conv.Make(Base)
  include (Conv : module type of Conv with type t := int40)

  module Endian = Bytes_conv.Make(Base)
  include (Endian : module type of Endian with type t := int40)

  module Inf = Infix.Make(Base)
  include (Inf : module type of Inf with type t := int40)
end

module Int48 = struct
  (* int48 is modeled as int64, where only the UPPER 48 bits are used;
     this has the advantage that most operations are identical to the int64 ones.
     The post-condition of all int48 opertaions is, that the LOWER 16 bit are 0x0000.
     Only operations that are not identical or do not preserve the post-condition are implemented.
  *)
  module Base = struct
    include Int64.Base
    let bits = 48
    let fmt = "ll"
    let name = "Int48"

    external mul : int48 -> int48 -> int48 = "uint48_mul"
    external div : int48 -> int48 -> int48 = "int48_div"
    external logxor : int48 -> int48 -> int48 = "uint48_xor"
    external shift_right : int48 -> int -> int48 = "uint48_shift_right"
    external shift_right_logical : int48 -> int -> int48 = "int48_shift_right"

    external of_int       :       int ->     int48 = "int48_of_int"
    external of_nativeint : nativeint ->     int48 = "int48_of_nativeint"
    external of_float     :     float ->     int48 = "int48_of_float"
    external of_int8      :      int8 ->     int48 = "int48_of_int8"
    external of_int16     :     int16 ->     int48 = "int48_of_int16"
    external of_int24     :     int24 ->     int48 = "int48_of_int24"
    external of_int32     :     int32 ->     int48 = "int48_of_int32"
    external of_int40     :     int40 ->     int48 = "int48_of_int40"
    external of_int48     :     int48 ->     int48 = "%identity"
    external of_int56     :     int56 ->     int48 = "int48_of_int56"
    external of_int64     :     int64 ->     int48 = "int48_of_int64"
    external of_int128    :    int128 ->     int48 = "int48_of_int128"
    external of_uint8     :     uint8 ->     int48 = "int48_of_uint8"
    external of_uint16    :    uint16 ->     int48 = "int48_of_uint16"
    external of_uint24    :    uint24 ->     int48 = "int48_of_uint24"
    external of_uint32    :    uint32 ->     int48 = "int48_of_uint32"
    external of_uint40    :    uint40 ->     int48 = "int48_of_uint40"
    external of_uint48    :    uint48 ->     int48 = "int48_of_uint48"
    external of_uint56    :    uint56 ->     int48 = "int48_of_uint56"
    external of_uint64    :    uint64 ->     int48 = "int48_of_uint64"
    external of_uint128   :   uint128 ->     int48 = "int48_of_uint128"

    external to_int       :     int48 ->       int = "int_of_int48"
    external to_nativeint :     int48 -> nativeint = "nativeint_of_int48"
    external to_float     :     int48 ->     float = "float_of_int48"
    external to_int8      :     int48 ->      int8 = "int8_of_int48"
    external to_int16     :     int48 ->     int16 = "int16_of_int48"
    external to_int24     :     int48 ->     int24 = "int24_of_int48"
    external to_int32     :     int48 ->     int32 = "int32_of_int48"
    external to_int40     :     int48 ->     int40 = "int40_of_int48"
    external to_int48     :     int48 ->     int48 = "%identity"
    external to_int56     :     int48 ->     int56 = "int56_of_int48"
    external to_int64     :     int48 ->     int64 = "int64_of_int48"
    external to_int128    :     int48 ->    int128 = "int128_of_int48"
    external to_uint8     :     int48 ->     uint8 = "uint8_of_int48"
    external to_uint16    :     int48 ->    uint16 = "uint16_of_int48"
    external to_uint24    :     int48 ->    uint24 = "uint24_of_int48"
    external to_uint32    :     int48 ->    uint32 = "uint32_of_int48"
    external to_uint40    :     int48 ->    uint40 = "uint40_of_int48"
    external to_uint48    :     int48 ->    uint48 = "uint48_of_int48"
    external to_uint56    :     int48 ->    uint56 = "uint56_of_int48"
    external to_uint64    :     int48 ->    uint64 = "uint64_of_int48"
    external to_uint128   :     int48 ->   uint128 = "uint128_of_int48"

    external max_int_fun : unit -> int48 = "int48_max_int"
    external min_int_fun : unit -> int48 = "int48_min_int"
    let one = of_int 1
    let max_int = max_int_fun ()
    let min_int = min_int_fun ()
    let lognot = logxor max_int
    let compare = Stdlib.compare
    let divmod  = (fun x y -> div x y, rem x y)
  end

  include Base

  module Conv = Str_conv.Make(Base)
  include (Conv : module type of Conv with type t := int48)

  module Endian = Bytes_conv.Make(Base)
  include (Endian : module type of Endian with type t := int48)

  module Inf = Infix.Make(Base)
  include (Inf : module type of Inf with type t := int48)
end

module Int56 = struct
  (* int56 is modeled as int64, where only the UPPER 56 bits are used;
     this has the advantage that most operations are identical to the int64 ones.
     The post-condition of all int56 opertaions is, that the LOWER 8 bit are 0x00.
     Only operations that are not identical or do not preserve the post-condition are implemented.
  *)
  module Base = struct
    include Int64.Base
    let bits = 56
    let fmt = "ll"
    let name = "Int56"

    external mul : int56 -> int56 -> int56 = "uint56_mul"
    external div : int56 -> int56 -> int56 = "int56_div"
    external logxor : int56 -> int56 -> int56 = "uint56_xor"
    external shift_right : int56 -> int -> int56 = "uint56_shift_right"
    external shift_right_logical : int56 -> int -> int56 = "int56_shift_right"

    external of_int       :       int ->     int56 = "int56_of_int"
    external of_nativeint : nativeint ->     int56 = "int56_of_nativeint"
    external of_float     :     float ->     int56 = "int56_of_float"
    external of_int8      :      int8 ->     int56 = "int56_of_int8"
    external of_int16     :     int16 ->     int56 = "int56_of_int16"
    external of_int24     :     int24 ->     int56 = "int56_of_int24"
    external of_int32     :     int32 ->     int56 = "int56_of_int32"
    external of_int40     :     int40 ->     int56 = "int56_of_int40"
    external of_int48     :     int48 ->     int56 = "int56_of_int48"
    external of_int56     :     int56 ->     int56 = "%identity"
    external of_int64     :     int64 ->     int56 = "int56_of_int64"
    external of_int128    :    int128 ->     int56 = "int56_of_int128"
    external of_uint8     :     uint8 ->     int56 = "int56_of_uint8"
    external of_uint16    :    uint16 ->     int56 = "int56_of_uint16"
    external of_uint24    :    uint24 ->     int56 = "int56_of_uint24"
    external of_uint32    :    uint32 ->     int56 = "int56_of_uint32"
    external of_uint40    :    uint40 ->     int56 = "int56_of_uint40"
    external of_uint48    :    uint48 ->     int56 = "int56_of_uint48"
    external of_uint56    :    uint56 ->     int56 = "int56_of_uint56"
    external of_uint64    :    uint64 ->     int56 = "int56_of_uint64"
    external of_uint128   :   uint128 ->     int56 = "int56_of_uint128"

    external to_int       :     int56 ->       int = "int_of_int56"
    external to_nativeint :     int56 -> nativeint = "nativeint_of_int56"
    external to_float     :     int56 ->     float = "float_of_int56"
    external to_int8      :     int56 ->      int8 = "int8_of_int56"
    external to_int16     :     int56 ->     int16 = "int16_of_int56"
    external to_int24     :     int56 ->     int24 = "int24_of_int56"
    external to_int32     :     int56 ->     int32 = "int32_of_int56"
    external to_int40     :     int56 ->     int40 = "int40_of_int56"
    external to_int48     :     int56 ->     int48 = "int48_of_int56"
    external to_int56     :     int56 ->     int56 = "%identity"
    external to_int64     :     int56 ->     int64 = "int64_of_int56"
    external to_int128    :     int56 ->    int128 = "int128_of_int56"
    external to_uint8     :     int56 ->     uint8 = "uint8_of_int56"
    external to_uint16    :     int56 ->    uint16 = "uint16_of_int56"
    external to_uint24    :     int56 ->    uint24 = "uint24_of_int56"
    external to_uint32    :     int56 ->    uint32 = "uint32_of_int56"
    external to_uint40    :     int56 ->    uint40 = "uint40_of_int56"
    external to_uint48    :     int56 ->    uint48 = "uint48_of_int56"
    external to_uint56    :     int56 ->    uint56 = "uint56_of_int56"
    external to_uint64    :     int56 ->    uint64 = "uint64_of_int56"
    external to_uint128   :     int56 ->   uint128 = "uint128_of_int56"

    external max_int_fun : unit -> int56 = "int56_max_int"
    external min_int_fun : unit -> int56 = "int56_min_int"
    let one = of_int 1
    let max_int = max_int_fun ()
    let min_int = min_int_fun ()
    let lognot = logxor max_int
    let compare = Stdlib.compare
    let divmod  = (fun x y -> div x y, rem x y)
  end

  include Base

  module Conv = Str_conv.Make(Base)
  include (Conv : module type of Conv with type t := int56)

  module Endian = Bytes_conv.Make(Base)
  include (Endian : module type of Endian with type t := int56)

  module Inf = Infix.Make(Base)
  include (Inf : module type of Inf with type t := int56)
end

module Int128 = struct
  module Base = struct
    type t = int128
    let bits = 128
    let fmt = "LL"
    let name = "Int128"

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
    external shift_right_logical : int128 -> int -> int128 = "int128_shift_right"
    external abs : int128 -> int128 = "int128_abs"
    external neg : int128 -> int128 = "int128_neg"

    external of_int       :       int ->    int128 = "int128_of_int"
    external of_nativeint : nativeint ->    int128 = "int128_of_nativeint"
    external of_float     :     float ->    int128 = "int128_of_float"
    external of_int8      :      int8 ->    int128 = "int128_of_int8"
    external of_int16     :     int16 ->    int128 = "int128_of_int16"
    external of_int24     :     int24 ->    int128 = "int128_of_int24"
    external of_int32     :     int32 ->    int128 = "int128_of_int32"
    external of_int40     :     int40 ->    int128 = "int128_of_int40"
    external of_int48     :     int48 ->    int128 = "int128_of_int48"
    external of_int56     :     int56 ->    int128 = "int128_of_int56"
    external of_int64     :     int64 ->    int128 = "int128_of_int64"
    external of_int128    :    int128 ->    int128 = "%identity"
    external of_uint8     :     uint8 ->    int128 = "int128_of_uint8"
    external of_uint16    :    uint16 ->    int128 = "int128_of_uint16"
    external of_uint24    :    uint24 ->    int128 = "int128_of_uint24"
    external of_uint32    :    uint32 ->    int128 = "int128_of_uint32"
    external of_uint40    :    uint40 ->    int128 = "int128_of_uint40"
    external of_uint48    :    uint48 ->    int128 = "int128_of_uint48"
    external of_uint56    :    uint56 ->    int128 = "int128_of_uint56"
    external of_uint64    :    uint64 ->    int128 = "int128_of_uint64"
    external of_uint128   :   uint128 ->    int128 = "int128_of_uint128"

    external to_int       :    int128 ->       int = "int_of_int128"
    external to_nativeint :    int128 -> nativeint = "nativeint_of_int128"
    external to_float     :    int128 ->     float = "float_of_int128"
    external to_int8      :    int128 ->      int8 = "int8_of_int128"
    external to_int16     :    int128 ->     int16 = "int16_of_int128"
    external to_int24     :    int128 ->     int24 = "int24_of_int128"
    external to_int32     :    int128 ->     int32 = "int32_of_int128"
    external to_int40     :    int128 ->     int40 = "int40_of_int128"
    external to_int48     :    int128 ->     int48 = "int48_of_int128"
    external to_int56     :    int128 ->     int56 = "int56_of_int128"
    external to_int64     :    int128 ->     int64 = "int64_of_int128"
    external to_int128    :    int128 ->    int128 = "%identity"
    external to_uint8     :    int128 ->     uint8 = "uint8_of_int128"
    external to_uint16    :    int128 ->    uint16 = "uint16_of_int128"
    external to_uint24    :    int128 ->    uint24 = "uint24_of_int128"
    external to_uint32    :    int128 ->    uint32 = "uint32_of_int128"
    external to_uint40    :    int128 ->    uint40 = "uint40_of_int128"
    external to_uint48    :    int128 ->    uint48 = "uint48_of_int128"
    external to_uint56    :    int128 ->    uint56 = "uint56_of_int128"
    external to_uint64    :    int128 ->    uint64 = "uint64_of_int128"
    external to_uint128   :    int128 ->   uint128 = "uint128_of_int128"

    external max_int_fun : unit -> int128 = "int128_max_int"
    external min_int_fun : unit -> int128 = "int128_min_int"

    let zero = of_int 0
    let one = of_int 1
    let succ = add one
    let pred x = sub x one
    let max_int = max_int_fun ()
    let min_int = min_int_fun ()
    let lognot = logxor max_int
    let compare = Stdlib.compare
    let divmod  = (fun x y -> div x y, rem x y)

    external init_custom_ops : unit -> unit = "int128_init_custom_ops"
    let () = init_custom_ops ()
  end

  include Base

  module Conv = Str_conv.Make(Base)
  include (Conv : module type of Conv with type t := int128)

  module Endian = Bytes_conv.Make(Base)
  include (Endian : module type of Endian with type t := int128)

  module Inf = Infix.Make(Base)
  include (Inf : module type of Inf with type t := int128)
end

module Uint8 = struct
  module Base = struct
    include Int_wrapper.Make_unsigned(struct let bits = 8 end)
    let fmt = "Uhh"
    let name = "Uint8"
  end
  include Base

  external of_nativeint : nativeint ->     uint8 = "uint8_of_nativeint"
  external of_float     :     float ->     uint8 = "uint8_of_float"
  external of_int8      :      int8 ->     uint8 = "uint8_of_int8"
  external of_int16     :     int16 ->     uint8 = "uint8_of_int16"
  external of_int24     :     int24 ->     uint8 = "uint8_of_int24"
  external of_int32     :     int32 ->     uint8 = "uint8_of_int32"
  external of_int40     :     int40 ->     uint8 = "uint8_of_int40"
  external of_int48     :     int48 ->     uint8 = "uint8_of_int48"
  external of_int56     :     int56 ->     uint8 = "uint8_of_int56"
  external of_int64     :     int64 ->     uint8 = "uint8_of_int64"
  external of_int128    :    int128 ->     uint8 = "uint8_of_int128"
  external of_uint8     :     uint8 ->     uint8 = "%identity"
  external of_uint16    :    uint16 ->     uint8 = "uint8_of_uint16"
  external of_uint24    :    uint24 ->     uint8 = "uint8_of_uint24"
  external of_uint32    :    uint32 ->     uint8 = "uint8_of_uint32"
  external of_uint40    :    uint40 ->     uint8 = "uint8_of_uint40"
  external of_uint48    :    uint48 ->     uint8 = "uint8_of_uint48"
  external of_uint56    :    uint56 ->     uint8 = "uint8_of_uint56"
  external of_uint64    :    uint64 ->     uint8 = "uint8_of_uint64"
  external of_uint128   :   uint128 ->     uint8 = "uint8_of_uint128"

  external to_nativeint :     uint8 -> nativeint = "nativeint_of_uint8"
  external to_float     :     uint8 ->     float = "float_of_uint8"
  external to_int8      :     uint8 ->      int8 = "int8_of_uint8"
  external to_int16     :     uint8 ->     int16 = "int16_of_uint8"
  external to_int24     :     uint8 ->     int24 = "int24_of_uint8"
  external to_int32     :     uint8 ->     int32 = "int32_of_uint8"
  external to_int40     :     uint8 ->     int40 = "int40_of_uint8"
  external to_int48     :     uint8 ->     int48 = "int48_of_uint8"
  external to_int56     :     uint8 ->     int56 = "int56_of_uint8"
  external to_int64     :     uint8 ->     int64 = "int64_of_uint8"
  external to_int128    :     uint8 ->    int128 = "int128_of_uint8"
  external to_uint8     :     uint8 ->     uint8 = "%identity"
  external to_uint16    :     uint8 ->    uint16 = "uint16_of_uint8"
  external to_uint24    :     uint8 ->    uint24 = "uint24_of_uint8"
  external to_uint32    :     uint8 ->    uint32 = "uint32_of_uint8"
  external to_uint40    :     uint8 ->    uint40 = "uint40_of_uint8"
  external to_uint48    :     uint8 ->    uint48 = "uint48_of_uint8"
  external to_uint56    :     uint8 ->    uint56 = "uint56_of_uint8"
  external to_uint64    :     uint8 ->    uint64 = "uint64_of_uint8"
  external to_uint128   :     uint8 ->   uint128 = "uint128_of_uint8"

  module Conv = Str_conv.Make(Base)
  include (Conv : module type of Conv with type t := uint8)

  module Endian = Bytes_conv.Make(Base)
  include (Endian : module type of Endian with type t := uint8)

  module Inf = Infix.Make(Base)
  include (Inf : module type of Inf with type t := uint8)
end

module Uint16 = struct
  module Base = struct
    include Int_wrapper.Make_unsigned(struct let bits = 16 end)
    let fmt = "Uh"
    let name = "Uint16"
  end
  include Base

  external of_nativeint : nativeint ->    uint16 = "uint16_of_nativeint"
  external of_float     :     float ->    uint16 = "uint16_of_float"
  external of_int8      :      int8 ->    uint16 = "uint16_of_int8"
  external of_int16     :     int16 ->    uint16 = "uint16_of_int16"
  external of_int24     :     int24 ->    uint16 = "uint16_of_int24"
  external of_int32     :     int32 ->    uint16 = "uint16_of_int32"
  external of_int40     :     int40 ->    uint16 = "uint16_of_int40"
  external of_int48     :     int48 ->    uint16 = "uint16_of_int48"
  external of_int56     :     int56 ->    uint16 = "uint16_of_int56"
  external of_int64     :     int64 ->    uint16 = "uint16_of_int64"
  external of_int128    :    int128 ->    uint16 = "uint16_of_int128"
  external of_uint8     :     uint8 ->    uint16 = "uint16_of_uint8"
  external of_uint16    :    uint16 ->    uint16 = "%identity"
  external of_uint24    :    uint24 ->    uint16 = "uint16_of_uint24"
  external of_uint32    :    uint32 ->    uint16 = "uint16_of_uint32"
  external of_uint40    :    uint40 ->    uint16 = "uint16_of_uint40"
  external of_uint48    :    uint48 ->    uint16 = "uint16_of_uint48"
  external of_uint56    :    uint56 ->    uint16 = "uint16_of_uint56"
  external of_uint64    :    uint64 ->    uint16 = "uint16_of_uint64"
  external of_uint128   :   uint128 ->    uint16 = "uint16_of_uint128"

  external to_nativeint :    uint16 -> nativeint = "nativeint_of_uint16"
  external to_float     :    uint16 ->     float = "float_of_uint16"
  external to_int8      :    uint16 ->      int8 = "int8_of_uint16"
  external to_int16     :    uint16 ->     int16 = "int16_of_uint16"
  external to_int24     :    uint16 ->     int24 = "int24_of_uint16"
  external to_int32     :    uint16 ->     int32 = "int32_of_uint16"
  external to_int40     :    uint16 ->     int40 = "int40_of_uint16"
  external to_int48     :    uint16 ->     int48 = "int48_of_uint16"
  external to_int56     :    uint16 ->     int56 = "int56_of_uint16"
  external to_int64     :    uint16 ->     int64 = "int64_of_uint16"
  external to_int128    :    uint16 ->    int128 = "int128_of_uint16"
  external to_uint8     :    uint16 ->     uint8 = "uint8_of_uint16"
  external to_uint16    :    uint16 ->    uint16 = "%identity"
  external to_uint24    :    uint16 ->    uint24 = "uint24_of_uint16"
  external to_uint32    :    uint16 ->    uint32 = "uint32_of_uint16"
  external to_uint40    :    uint16 ->    uint40 = "uint40_of_uint16"
  external to_uint48    :    uint16 ->    uint48 = "uint48_of_uint16"
  external to_uint56    :    uint16 ->    uint56 = "uint56_of_uint16"
  external to_uint64    :    uint16 ->    uint64 = "uint64_of_uint16"
  external to_uint128   :    uint16 ->   uint128 = "uint128_of_uint16"

  module Conv = Str_conv.Make(Base)
  include (Conv : module type of Conv with type t := uint16)

  module Endian = Bytes_conv.Make(Base)
  include (Endian : module type of Endian with type t := uint16)

  module Inf = Infix.Make(Base)
  include (Inf : module type of Inf with type t := uint16)
end

module Uint24 = struct
  module Base = struct
    include Int_wrapper.Make_unsigned(struct let bits = 24 end)
    let fmt     = "Ul"
    let name    = "Uint24"
  end
  include Base

  external of_nativeint : nativeint ->    uint24 = "uint24_of_nativeint"
  external of_float     :     float ->    uint24 = "uint24_of_float"
  external of_int8      :      int8 ->    uint24 = "uint24_of_int8"
  external of_int16     :     int16 ->    uint24 = "uint24_of_int16"
  external of_int24     :     int24 ->    uint24 = "uint24_of_int24"
  external of_int32     :     int32 ->    uint24 = "uint24_of_int32"
  external of_int40     :     int40 ->    uint24 = "uint24_of_int40"
  external of_int48     :     int48 ->    uint24 = "uint24_of_int48"
  external of_int56     :     int56 ->    uint24 = "uint24_of_int56"
  external of_int64     :     int64 ->    uint24 = "uint24_of_int64"
  external of_int128    :    int128 ->    uint24 = "uint24_of_int128"
  external of_uint8     :     uint8 ->    uint24 = "uint24_of_uint8"
  external of_uint16    :    uint16 ->    uint24 = "uint24_of_uint16"
  external of_uint24    :    uint24 ->    uint24 = "%identity"
  external of_uint32    :    uint32 ->    uint24 = "uint24_of_uint32"
  external of_uint40    :    uint40 ->    uint24 = "uint24_of_uint40"
  external of_uint48    :    uint48 ->    uint24 = "uint24_of_uint48"
  external of_uint56    :    uint56 ->    uint24 = "uint24_of_uint56"
  external of_uint64    :    uint64 ->    uint24 = "uint24_of_uint64"
  external of_uint128   :   uint128 ->    uint24 = "uint24_of_uint128"

  external to_nativeint :    uint24 -> nativeint = "nativeint_of_uint24"
  external to_float     :    uint24 ->     float = "float_of_uint24"
  external to_int8      :    uint24 ->      int8 = "int8_of_uint24"
  external to_int16     :    uint24 ->     int16 = "int16_of_uint24"
  external to_int24     :    uint24 ->     int24 = "int24_of_uint24"
  external to_int32     :    uint24 ->     int32 = "int32_of_uint24"
  external to_int40     :    uint24 ->     int40 = "int40_of_uint24"
  external to_int48     :    uint24 ->     int48 = "int48_of_uint24"
  external to_int56     :    uint24 ->     int56 = "int56_of_uint24"
  external to_int64     :    uint24 ->     int64 = "int64_of_uint24"
  external to_int128    :    uint24 ->    int128 = "int128_of_uint24"
  external to_uint8     :    uint24 ->     uint8 = "uint8_of_uint24"
  external to_uint16    :    uint24 ->    uint16 = "uint16_of_uint24"
  external to_uint24    :    uint24 ->    uint24 = "%identity"
  external to_uint32    :    uint24 ->    uint32 = "uint32_of_uint24"
  external to_uint40    :    uint24 ->    uint40 = "uint40_of_uint24"
  external to_uint48    :    uint24 ->    uint48 = "uint48_of_uint24"
  external to_uint56    :    uint24 ->    uint56 = "uint56_of_uint24"
  external to_uint64    :    uint24 ->    uint64 = "uint64_of_uint24"
  external to_uint128   :    uint24 ->   uint128 = "uint128_of_uint24"

  module Conv = Str_conv.Make(Base)
  include (Conv : module type of Conv with type t := uint24)

  module Endian = Bytes_conv.Make(Base)
  include (Endian : module type of Endian with type t := uint24)

  module Inf = Infix.Make(Base)
  include (Inf : module type of Inf with type t := uint24)
end

module Uint32 = struct
  module Base = struct
    type t = uint32
    let bits = 32
    let fmt = "Ul"
    let name = "Uint32"

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
    external neg : uint32 -> uint32 = "uint32_neg"

    external of_int       :       int ->    uint32 = "uint32_of_int"
    external of_nativeint : nativeint ->    uint32 = "uint32_of_nativeint"
    external of_float     :     float ->    uint32 = "uint32_of_float"
    external of_int8      :      int8 ->    uint32 = "uint32_of_int8"
    external of_int16     :     int16 ->    uint32 = "uint32_of_int16"
    external of_int24     :     int24 ->    uint32 = "uint32_of_int24"
    external of_int32     :     int32 ->    uint32 = "uint32_of_int32"
    external of_int40     :     int40 ->    uint32 = "uint32_of_int40"
    external of_int48     :     int48 ->    uint32 = "uint32_of_int48"
    external of_int56     :     int56 ->    uint32 = "uint32_of_int56"
    external of_int64     :     int64 ->    uint32 = "uint32_of_int64"
    external of_int128    :    int128 ->    uint32 = "uint32_of_int128"
    external of_uint8     :     uint8 ->    uint32 = "uint32_of_uint8"
    external of_uint16    :    uint16 ->    uint32 = "uint32_of_uint16"
    external of_uint24    :    uint24 ->    uint32 = "uint32_of_uint24"
    external of_uint32    :    uint32 ->    uint32 = "%identity"
    external of_uint40    :    uint40 ->    uint32 = "uint32_of_uint40"
    external of_uint48    :    uint48 ->    uint32 = "uint32_of_uint48"
    external of_uint56    :    uint56 ->    uint32 = "uint32_of_uint56"
    external of_uint64    :    uint64 ->    uint32 = "uint32_of_uint64"
    external of_uint128   :   uint128 ->    uint32 = "uint32_of_uint128"

    external to_int       :    uint32 ->       int = "int_of_uint32"
    external to_nativeint :    uint32 -> nativeint = "nativeint_of_uint32"
    external to_float     :    uint32 ->     float = "float_of_uint32"
    external to_int8      :    uint32 ->      int8 = "int8_of_uint32"
    external to_int16     :    uint32 ->     int16 = "int16_of_uint32"
    external to_int24     :    uint32 ->     int24 = "int24_of_uint32"
    external to_int32     :    uint32 ->     int32 = "int32_of_uint32"
    external to_int40     :    uint32 ->     int40 = "int40_of_uint32"
    external to_int48     :    uint32 ->     int48 = "int48_of_uint32"
    external to_int56     :    uint32 ->     int56 = "int56_of_uint32"
    external to_int64     :    uint32 ->     int64 = "int64_of_uint32"
    external to_int128    :    uint32 ->    int128 = "int128_of_uint32"
    external to_uint8     :    uint32 ->     uint8 = "uint8_of_uint32"
    external to_uint16    :    uint32 ->    uint16 = "uint16_of_uint32"
    external to_uint24    :    uint32 ->    uint24 = "uint24_of_uint32"
    external to_uint32    :    uint32 ->    uint32 = "%identity"
    external to_uint40    :    uint32 ->    uint40 = "uint40_of_uint32"
    external to_uint48    :    uint32 ->    uint48 = "uint48_of_uint32"
    external to_uint56    :    uint32 ->    uint56 = "uint56_of_uint32"
    external to_uint64    :    uint32 ->    uint64 = "uint64_of_uint32"
    external to_uint128   :    uint32 ->   uint128 = "uint128_of_uint32"

    external max_int_fun : unit -> uint32 = "uint32_max_int"

    let zero = of_int 0
    let one = of_int 1
    let succ = add one
    let pred x = sub x one
    let max_int = max_int_fun ()
    let min_int = zero
    let lognot = logxor max_int
    let compare = Stdlib.compare
    let divmod  = (fun x y -> div x y, rem x y)

    external init_custom_ops : unit -> unit = "uint32_init_custom_ops"
    let () = init_custom_ops ()
  end

  include Base

  module Conv = Str_conv.Make(Base)
  include (Conv : module type of Conv with type t := uint32)

  module Endian = Bytes_conv.Make(Base)
  include (Endian : module type of Endian with type t := uint32)

  module Inf = Infix.Make(Base)
  include (Inf : module type of Inf with type t := uint32)
end

module Uint64 = struct
  module Base = struct
    type t = uint64
    let bits = 64
    let name    = "Uint64"
    let fmt     = "UL"

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
    external neg : uint64 -> uint64 = "uint64_neg"

    external of_int       :       int ->    uint64 = "uint64_of_int"
    external of_nativeint : nativeint ->    uint64 = "uint64_of_nativeint"
    external of_float     :     float ->    uint64 = "uint64_of_float"
    external of_int8      :      int8 ->    uint64 = "uint64_of_int8"
    external of_int16     :     int16 ->    uint64 = "uint64_of_int16"
    external of_int24     :     int24 ->    uint64 = "uint64_of_int24"
    external of_int32     :     int32 ->    uint64 = "uint64_of_int32"
    external of_int40     :     int40 ->    uint64 = "uint64_of_int40"
    external of_int48     :     int48 ->    uint64 = "uint64_of_int48"
    external of_int56     :     int56 ->    uint64 = "uint64_of_int56"
    external of_int64     :     int64 ->    uint64 = "uint64_of_int64"
    external of_int128    :    int128 ->    uint64 = "uint64_of_int128"
    external of_uint8     :     uint8 ->    uint64 = "uint64_of_uint8"
    external of_uint16    :    uint16 ->    uint64 = "uint64_of_uint16"
    external of_uint24    :    uint24 ->    uint64 = "uint64_of_uint24"
    external of_uint32    :    uint32 ->    uint64 = "uint64_of_uint32"
    external of_uint40    :    uint40 ->    uint64 = "uint64_of_uint40"
    external of_uint48    :    uint48 ->    uint64 = "uint64_of_uint48"
    external of_uint56    :    uint56 ->    uint64 = "uint64_of_uint56"
    external of_uint64    :    uint64 ->    uint64 = "%identity"
    external of_uint128   :   uint128 ->    uint64 = "uint64_of_uint128"

    external to_int       :    uint64 ->       int = "int_of_uint64"
    external to_nativeint :    uint64 -> nativeint = "nativeint_of_uint64"
    external to_float     :    uint64 ->     float = "float_of_uint64"
    external to_int8      :    uint64 ->      int8 = "int8_of_uint64"
    external to_int16     :    uint64 ->     int16 = "int16_of_uint64"
    external to_int24     :    uint64 ->     int24 = "int24_of_uint64"
    external to_int32     :    uint64 ->     int32 = "int32_of_uint64"
    external to_int40     :    uint64 ->     int40 = "int40_of_uint64"
    external to_int48     :    uint64 ->     int48 = "int48_of_uint64"
    external to_int56     :    uint64 ->     int56 = "int56_of_uint64"
    external to_int64     :    uint64 ->     int64 = "int64_of_uint64"
    external to_int128    :    uint64 ->    int128 = "int128_of_uint64"
    external to_uint8     :    uint64 ->     uint8 = "uint8_of_uint64"
    external to_uint16    :    uint64 ->    uint16 = "uint16_of_uint64"
    external to_uint24    :    uint64 ->    uint24 = "uint24_of_uint64"
    external to_uint32    :    uint64 ->    uint32 = "uint32_of_uint64"
    external to_uint40    :    uint64 ->    uint40 = "uint40_of_uint64"
    external to_uint48    :    uint64 ->    uint48 = "uint48_of_uint64"
    external to_uint56    :    uint64 ->    uint56 = "uint56_of_uint64"
    external to_uint64    :    uint64 ->    uint64 = "%identity"
    external to_uint128   :    uint64 ->   uint128 = "uint128_of_uint64"

    external max_int_fun : unit -> uint64 = "uint64_max_int"

    let zero = of_int 0
    let one = of_int 1
    let succ = add one
    let pred x = sub x one
    let max_int = max_int_fun ()
    let min_int = zero
    let lognot = logxor max_int
    let compare = Stdlib.compare
    let divmod  = (fun x y -> div x y, rem x y)

    external init_custom_ops : unit -> unit = "uint64_init_custom_ops"
    let () = init_custom_ops ()
  end

  include Base

  module Conv = Str_conv.Make(Base)
  include (Conv : module type of Conv with type t := uint64)

  module Endian = Bytes_conv.Make(Base)
  include (Endian : module type of Endian with type t := uint64)

  module Inf = Infix.Make(Base)
  include (Inf : module type of Inf with type t := uint64)
end

module Uint40 = struct
  (* uint40 is modeled as uint64, where only the UPPER 40 bits are used;
     this has the advantage that most operations are identical to the uint64 ones.
     The post-condition of all uint40 opertaions is, that the LOWER 24 bit are 0x000000.
     Only operations that are not identical or do not preserve the post-condition are implemented.
  *)
  module Base = struct
    include Uint64.Base
    let bits = 40
    let fmt = "Ul"
    let name = "Uint40"

    external mul : uint40 -> uint40 -> uint40 = "uint40_mul"
    external div : uint40 -> uint40 -> uint40 = "uint40_div"
    external logxor : uint40 -> uint40 -> uint40 = "uint40_xor"
    external shift_right : uint40 -> int -> uint40 = "uint40_shift_right"
    let shift_right_logical = shift_right
    external neg : uint40 -> uint40 = "uint40_neg"

    external of_int       :       int ->    uint40 = "uint40_of_int"
    external of_nativeint : nativeint ->    uint40 = "uint40_of_nativeint"
    external of_float     :     float ->    uint40 = "uint40_of_float"
    external of_int8      :      int8 ->    uint40 = "uint40_of_int8"
    external of_int16     :     int16 ->    uint40 = "uint40_of_int16"
    external of_int24     :     int24 ->    uint40 = "uint40_of_int24"
    external of_int32     :     int32 ->    uint40 = "uint40_of_int32"
    external of_int40     :     int40 ->    uint40 = "uint40_of_int40"
    external of_int48     :     int48 ->    uint40 = "uint40_of_int48"
    external of_int56     :     int56 ->    uint40 = "uint40_of_int56"
    external of_int64     :     int64 ->    uint40 = "uint40_of_int64"
    external of_int128    :    int128 ->    uint40 = "uint40_of_int128"
    external of_uint8     :     uint8 ->    uint40 = "uint40_of_uint8"
    external of_uint16    :    uint16 ->    uint40 = "uint40_of_uint16"
    external of_uint24    :    uint24 ->    uint40 = "uint40_of_uint24"
    external of_uint32    :    uint32 ->    uint40 = "uint40_of_uint32"
    external of_uint40    :    uint40 ->    uint40 = "%identity"
    external of_uint48    :    uint48 ->    uint40 = "uint40_of_uint48"
    external of_uint56    :    uint56 ->    uint40 = "uint40_of_uint56"
    external of_uint64    :    uint64 ->    uint40 = "uint40_of_uint64"
    external of_uint128   :   uint128 ->    uint40 = "uint40_of_uint128"

    external to_int       :    uint40 ->       int = "int_of_uint40"
    external to_nativeint :    uint40 -> nativeint = "nativeint_of_uint40"
    external to_float     :    uint40 ->     float = "float_of_uint40"
    external to_int8      :    uint40 ->      int8 = "int8_of_uint40"
    external to_int16     :    uint40 ->     int16 = "int16_of_uint40"
    external to_int24     :    uint40 ->     int24 = "int24_of_uint40"
    external to_int32     :    uint40 ->     int32 = "int32_of_uint40"
    external to_int40     :    uint40 ->     int40 = "int40_of_uint40"
    external to_int48     :    uint40 ->     int48 = "int48_of_uint40"
    external to_int56     :    uint40 ->     int56 = "int56_of_uint40"
    external to_int64     :    uint40 ->     int64 = "int64_of_uint40"
    external to_int128    :    uint40 ->    int128 = "int128_of_uint40"
    external to_uint8     :    uint40 ->     uint8 = "uint8_of_uint40"
    external to_uint16    :    uint40 ->    uint16 = "uint16_of_uint40"
    external to_uint24    :    uint40 ->    uint24 = "uint24_of_uint40"
    external to_uint32    :    uint40 ->    uint32 = "uint32_of_uint40"
    external to_uint40    :    uint40 ->    uint40 = "%identity"
    external to_uint48    :    uint40 ->    uint48 = "uint48_of_uint40"
    external to_uint56    :    uint40 ->    uint56 = "uint56_of_uint40"
    external to_uint64    :    uint40 ->    uint64 = "uint64_of_uint40"
    external to_uint128   :    uint40 ->   uint128 = "uint128_of_uint40"

    let one = of_int 1
    let max_int = max_int_fun ()
    let lognot = logxor max_int
    let compare = Stdlib.compare
    let divmod  = (fun x y -> div x y, rem x y)
  end

  include Base

  module Conv = Str_conv.Make(Base)
  include (Conv : module type of Conv with type t := uint40)

  module Endian = Bytes_conv.Make(Base)
  include (Endian : module type of Endian with type t := uint40)

  module Inf = Infix.Make(Base)
  include (Inf : module type of Inf with type t := uint40)
end

module Uint48 = struct
  (* uint48 is modeled as uint64, where only the UPPER 48 bits are used;
     this has the advantage that most operations are identical to the uint64 ones.
     The post-condition of all uint48 opertaions is, that the LOWER 16 bit are 0x0000.
     Only operations that are not identical or do not preserve the post-condition are implemented.
  *)
  module Base = struct
    include Uint64.Base
    let bits = 48
    let fmt = "Ul"
    let name = "Uint48"

    external mul : uint48 -> uint48 -> uint48 = "uint48_mul"
    external div : uint48 -> uint48 -> uint48 = "uint48_div"
    external logxor : uint48 -> uint48 -> uint48 = "uint48_xor"
    external shift_right : uint48 -> int -> uint48 = "uint48_shift_right"
    let shift_right_logical = shift_right
    external neg : uint48 -> uint48 = "uint48_neg"

    external of_int       :       int ->    uint48 = "uint48_of_int"
    external of_nativeint : nativeint ->    uint48 = "uint48_of_nativeint"
    external of_float     :     float ->    uint48 = "uint48_of_float"
    external of_int8      :      int8 ->    uint48 = "uint48_of_int8"
    external of_int16     :     int16 ->    uint48 = "uint48_of_int16"
    external of_int24     :     int24 ->    uint48 = "uint48_of_int24"
    external of_int32     :     int32 ->    uint48 = "uint48_of_int32"
    external of_int40     :     int40 ->    uint48 = "uint48_of_int40"
    external of_int48     :     int48 ->    uint48 = "uint48_of_int48"
    external of_int56     :     int56 ->    uint48 = "uint48_of_int56"
    external of_int64     :     int64 ->    uint48 = "uint48_of_int64"
    external of_int128    :    int128 ->    uint48 = "uint48_of_int128"
    external of_uint8     :     uint8 ->    uint48 = "uint48_of_uint8"
    external of_uint16    :    uint16 ->    uint48 = "uint48_of_uint16"
    external of_uint24    :    uint24 ->    uint48 = "uint48_of_uint24"
    external of_uint32    :    uint32 ->    uint48 = "uint48_of_uint32"
    external of_uint40    :    uint40 ->    uint48 = "uint48_of_uint40"
    external of_uint48    :    uint48 ->    uint48 = "%identity"
    external of_uint56    :    uint56 ->    uint48 = "uint48_of_uint56"
    external of_uint64    :    uint64 ->    uint48 = "uint48_of_uint64"
    external of_uint128   :   uint128 ->    uint48 = "uint48_of_uint128"

    external to_int       :    uint48 ->       int = "int_of_uint48"
    external to_nativeint :    uint48 -> nativeint = "nativeint_of_uint48"
    external to_float     :    uint48 ->     float = "float_of_uint48"
    external to_int8      :    uint48 ->      int8 = "int8_of_uint48"
    external to_int16     :    uint48 ->     int16 = "int16_of_uint48"
    external to_int24     :    uint48 ->     int24 = "int24_of_uint48"
    external to_int32     :    uint48 ->     int32 = "int32_of_uint48"
    external to_int40     :    uint48 ->     int40 = "int40_of_uint48"
    external to_int48     :    uint48 ->     int48 = "int48_of_uint48"
    external to_int56     :    uint48 ->     int56 = "int56_of_uint48"
    external to_int64     :    uint48 ->     int64 = "int64_of_uint48"
    external to_int128    :    uint48 ->    int128 = "int128_of_uint48"
    external to_uint8     :    uint48 ->     uint8 = "uint8_of_uint48"
    external to_uint16    :    uint48 ->    uint16 = "uint16_of_uint48"
    external to_uint24    :    uint48 ->    uint24 = "uint24_of_uint48"
    external to_uint32    :    uint48 ->    uint32 = "uint32_of_uint48"
    external to_uint40    :    uint48 ->    uint40 = "uint40_of_uint48"
    external to_uint48    :    uint48 ->    uint48 = "%identity"
    external to_uint56    :    uint48 ->    uint56 = "uint56_of_uint48"
    external to_uint64    :    uint48 ->    uint64 = "uint64_of_uint48"
    external to_uint128   :    uint48 ->   uint128 = "uint128_of_uint48"

    let one = of_int 1
    let max_int = max_int_fun ()
    let lognot = logxor max_int
    let compare = Stdlib.compare
    let divmod  = (fun x y -> div x y, rem x y)
  end

  include Base

  module Conv = Str_conv.Make(Base)
  include (Conv : module type of Conv with type t := uint48)

  module Endian = Bytes_conv.Make(Base)
  include (Endian : module type of Endian with type t := uint48)

  module Inf = Infix.Make(Base)
  include (Inf : module type of Inf with type t := uint48)
end

module Uint56 = struct
  (* uint56 is modeled as uint64, where only the UPPER 56 bits are used;
     this has the advantage that most operations are identical to the uint64 ones.
     The post-condition of all uint56 opertaions is, that the LOWER 8 bit are 0x00.
     Only operations that are not identical or do not preserve the post-condition are implemented.
  *)
  module Base = struct
    include Uint64.Base
    let bits = 56
    let fmt = "Ul"
    let name = "Uint56"

    external mul : uint56 -> uint56 -> uint56 = "uint56_mul"
    external div : uint56 -> uint56 -> uint56 = "uint56_div"
    external logxor : uint56 -> uint56 -> uint56 = "uint56_xor"
    external shift_right : uint56 -> int -> uint56 = "uint56_shift_right"
    let shift_right_logical = shift_right
    external neg : uint56 -> uint56 = "uint56_neg"

    external of_int       :       int ->    uint56 = "uint56_of_int"
    external of_nativeint : nativeint ->    uint56 = "uint56_of_nativeint"
    external of_float     :     float ->    uint56 = "uint56_of_float"
    external of_int8      :      int8 ->    uint56 = "uint56_of_int8"
    external of_int16     :     int16 ->    uint56 = "uint56_of_int16"
    external of_int24     :     int24 ->    uint56 = "uint56_of_int24"
    external of_int32     :     int32 ->    uint56 = "uint56_of_int32"
    external of_int40     :     int40 ->    uint56 = "uint56_of_int40"
    external of_int48     :     int48 ->    uint56 = "uint56_of_int48"
    external of_int56     :     int56 ->    uint56 = "uint56_of_int56"
    external of_int64     :     int64 ->    uint56 = "uint56_of_int64"
    external of_int128    :    int128 ->    uint56 = "uint56_of_int128"
    external of_uint8     :     uint8 ->    uint56 = "uint56_of_uint8"
    external of_uint16    :    uint16 ->    uint56 = "uint56_of_uint16"
    external of_uint24    :    uint24 ->    uint56 = "uint56_of_uint24"
    external of_uint32    :    uint32 ->    uint56 = "uint56_of_uint32"
    external of_uint40    :    uint40 ->    uint56 = "uint56_of_uint40"
    external of_uint48    :    uint48 ->    uint56 = "uint56_of_uint48"
    external of_uint56    :    uint56 ->    uint56 = "%identity"
    external of_uint64    :    uint64 ->    uint56 = "uint56_of_uint64"
    external of_uint128   :   uint128 ->    uint56 = "uint56_of_uint128"

    external to_int       :    uint56 ->       int = "int_of_uint56"
    external to_nativeint :    uint56 -> nativeint = "nativeint_of_uint56"
    external to_float     :    uint56 ->     float = "float_of_uint56"
    external to_int8      :    uint56 ->      int8 = "int8_of_uint56"
    external to_int16     :    uint56 ->     int16 = "int16_of_uint56"
    external to_int24     :    uint56 ->     int24 = "int24_of_uint56"
    external to_int32     :    uint56 ->     int32 = "int32_of_uint56"
    external to_int40     :    uint56 ->     int40 = "int40_of_uint56"
    external to_int48     :    uint56 ->     int48 = "int48_of_uint56"
    external to_int56     :    uint56 ->     int56 = "int56_of_uint56"
    external to_int64     :    uint56 ->     int64 = "int64_of_uint56"
    external to_int128    :    uint56 ->    int128 = "int128_of_uint56"
    external to_uint8     :    uint56 ->     uint8 = "uint8_of_uint56"
    external to_uint16    :    uint56 ->    uint16 = "uint16_of_uint56"
    external to_uint24    :    uint56 ->    uint24 = "uint24_of_uint56"
    external to_uint32    :    uint56 ->    uint32 = "uint32_of_uint56"
    external to_uint40    :    uint56 ->    uint40 = "uint40_of_uint56"
    external to_uint48    :    uint56 ->    uint48 = "uint48_of_uint56"
    external to_uint56    :    uint56 ->    uint56 = "%identity"
    external to_uint64    :    uint56 ->    uint64 = "uint64_of_uint56"
    external to_uint128   :    uint56 ->   uint128 = "uint128_of_uint56"

    let one = of_int 1
    let max_int = max_int_fun ()
    let lognot = logxor max_int
    let compare = Stdlib.compare
    let divmod  = (fun x y -> div x y, rem x y)
  end

  include Base

  module Conv = Str_conv.Make(Base)
  include (Conv : module type of Conv with type t := uint56)

  module Endian = Bytes_conv.Make(Base)
  include (Endian : module type of Endian with type t := uint56)

  module Inf = Infix.Make(Base)
  include (Inf : module type of Inf with type t := uint56)
end

module Uint128 = struct
  module Base = struct
    type t = uint128
    let bits = 128
    let fmt     = "ULL"
    let name    = "Int1128"

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

    external of_int       :       int ->   uint128 = "uint128_of_int"
    external of_nativeint : nativeint ->   uint128 = "uint128_of_nativeint"
    external of_float     :     float ->   uint128 = "uint128_of_float"
    external of_int8      :      int8 ->   uint128 = "uint128_of_int8"
    external of_int16     :     int16 ->   uint128 = "uint128_of_int16"
    external of_int24     :     int24 ->   uint128 = "uint128_of_int24"
    external of_int32     :     int32 ->   uint128 = "uint128_of_int32"
    external of_int40     :     int40 ->   uint128 = "uint128_of_int40"
    external of_int48     :     int48 ->   uint128 = "uint128_of_int48"
    external of_int56     :     int56 ->   uint128 = "uint128_of_int56"
    external of_int64     :     int64 ->   uint128 = "uint128_of_int64"
    external of_int128    :    int128 ->   uint128 = "uint128_of_int128"
    external of_uint8     :     uint8 ->   uint128 = "uint128_of_uint8"
    external of_uint16    :    uint16 ->   uint128 = "uint128_of_uint16"
    external of_uint24    :    uint24 ->   uint128 = "uint128_of_uint24"
    external of_uint32    :    uint32 ->   uint128 = "uint128_of_uint32"
    external of_uint40    :    uint40 ->   uint128 = "uint128_of_uint40"
    external of_uint48    :    uint48 ->   uint128 = "uint128_of_uint48"
    external of_uint56    :    uint56 ->   uint128 = "uint128_of_uint56"
    external of_uint64    :    uint64 ->   uint128 = "uint128_of_uint64"
    external of_uint128   :   uint128 ->   uint128 = "%identity"

    external to_int       :   uint128 ->       int = "int_of_uint128"
    external to_nativeint :   uint128 -> nativeint = "nativeint_of_uint128"
    external to_float     :   uint128 ->     float = "float_of_uint128"
    external to_int8      :   uint128 ->      int8 = "int8_of_uint128"
    external to_int16     :   uint128 ->     int16 = "int16_of_uint128"
    external to_int24     :   uint128 ->     int24 = "int24_of_uint128"
    external to_int32     :   uint128 ->     int32 = "int32_of_uint128"
    external to_int40     :   uint128 ->     int40 = "int40_of_uint128"
    external to_int48     :   uint128 ->     int48 = "int48_of_uint128"
    external to_int56     :   uint128 ->     int56 = "int56_of_uint128"
    external to_int64     :   uint128 ->     int64 = "int64_of_uint128"
    external to_int128    :   uint128 ->    int128 = "int128_of_uint128"
    external to_uint8     :   uint128 ->     uint8 = "uint8_of_uint128"
    external to_uint16    :   uint128 ->    uint16 = "uint16_of_uint128"
    external to_uint24    :   uint128 ->    uint24 = "uint24_of_uint128"
    external to_uint32    :   uint128 ->    uint32 = "uint32_of_uint128"
    external to_uint40    :   uint128 ->    uint40 = "uint40_of_uint128"
    external to_uint48    :   uint128 ->    uint48 = "uint48_of_uint128"
    external to_uint56    :   uint128 ->    uint56 = "uint56_of_uint128"
    external to_uint64    :   uint128 ->    uint64 = "uint64_of_uint128"
    external to_uint128   :   uint128 ->   uint128 = "%identity"

    external max_int_fun : unit -> uint128 = "uint128_max_int"

    let zero = of_int 0
    let one = of_int 1
    let succ = add one
    let pred x = sub x one
    let max_int = max_int_fun ()
    let min_int = zero
    let lognot = logxor max_int
    let compare = Stdlib.compare
    let divmod  = (fun x y -> div x y, rem x y)

    let neg x = add (sub max_int x) one

    external init_custom_ops : unit -> unit = "uint128_init_custom_ops"
    let () = init_custom_ops ()
  end

  include Base

  module Conv = Str_conv.Make(Base)
  include (Conv : module type of Conv with type t := uint128)

  module Endian = Bytes_conv.Make(Base)
  include (Endian : module type of Endian with type t := uint128)

  module Inf = Infix.Make(Base)
  include (Inf : module type of Inf with type t := uint128)
end

