(** Standard integer types *)

type int8
(** Signed 8-bit integer *)

type int16
(** Signed 16-bit integer *)

type int128
(** Signed 128-bit integer *)

type uint8
(** Unsigned 8-bit integer *)

type uint16
(** Unsigned 16-bit integer *)

type uint24
(** Unsigned 24-bit integer *)

type uint32
(** Unsigned 32-bit integer *)

type uint56
(** Unsigned 32-bit integer *)

type uint64
(** Unsigned 64-bit integer *)

type uint128
(** Unsigned 128-bit integer *)

(** The generic integer interface *)
module type Int = sig

  type t

  val zero : t
  (** The value [0] *)

  val one : t
  (** The value [1] *)

  val max_int : t
  (** The greatest representable integer *)

  val min_int : t
  (** The smallest representable integer; for unsigned integers this is [zero]. *)

  val bits : int
  (** The number of bits used by this integer *)

  val add : t -> t -> t
  (** Addition *)

  val sub : t -> t -> t
  (** Subtraction *)

  val mul : t -> t -> t
  (** Multiplication *)

  val div : t -> t -> t
  (** Integer division. Raise [Division_by_zero] if the second argument is zero.
      This division rounds the real quotient of its arguments towards zero, as specified for [(/)]. *)

  val rem : t -> t -> t
  (** Integer remainder. If [y] is not [zero], the result of [rem x y] satisfies the following property:
      [x = add (mul (div x y) y) (rem x y)]. If [y = 0], [rem x y] raises [Division_by_zero]. *)

  val succ : t -> t
  (** Successor. [succ x] is [add x one]. *)

  val pred : t -> t
  (** Predecessor. [pred x] is [sub x one]. *)

  val abs : t -> t
  (** Return the absolute value of its argument. *)

  val logand : t -> t -> t
  (** Bitwise logical and. *)

  val logor : t -> t -> t
  (** Bitwise logical or. *)

  val logxor : t -> t -> t
  (** Bitwise logical exclusive or. *)

  val lognot : t -> t
  (** Bitwise logical negation. *)

  val shift_left : t -> int -> t
  (** [shift_left x y] shifts [x] to the left by [y] bits.
      The result is unspecified if [y < 0] or [y >= bits]. *)

  val shift_right : t -> int -> t
  (** [shift_right x y] shifts [x] to the right by [y] bits.
      If this is a signed integer, this is an arithmetic shift:
      the sign bit of [x] is replicated and inserted in the vacated bits.
      The result is unspecified if [y < 0] or [y >= 64].
      For an unsigned integer, this is identical to [shift_right_logical].  *)

  val shift_right_logical : t -> int -> t
  (** [shift_right_logical x y] shifts [x] to the right by [y] bits.
      This is a logical shift: zeroes are inserted in the vacated bits regardless
      if [x] is a signed or unsiged integer.
      The result is unspecified if [y < 0] or [y >= bits]. *)

  val of_int : int -> t
  (** Convert the given integer (type [int]) to this integer type. *)

  val to_int : t -> int
  (** Convert the given integer (type [t]) to an integer of type [int]. *)

  val of_float : float -> t
  (** Convert the given floating-point number to an integer of type [t]. *)

  val to_float : t -> float
  (** Convert the given integer to a floating-point number. *)

  val of_nativeint : nativeint -> t
  (** Convert the given integer (type [t]) to a native integer. *)

  val to_nativeint : t -> nativeint
  (** Convert the given native integer (type [nativeint]) to an integer (type [t]. *)

  val of_int8 : int8 -> t
  (** Convert an integer of type [int8] to an integer of type [t]. *)

  val to_int8 : t -> int8
  (** Convert an integer of type [t] to an integer of type [int8]. *)

  val of_int16 : int16 -> t
  (** Convert an integer of type [int16] to an integer of type [t]. *)

  val to_int16 : t -> int16
  (** Convert an integer of type [t] to an integer of type [int16]. *)

  val of_int32 : int32 -> t
  (** Convert an integer of type [int32] to an integer of type [t]. *)

  val to_int32 : t -> int32
  (** Convert an integer of type [t] to an integer of type [int32]. *)

  val of_int64 : int64 -> t
  (** Convert an integer of type [int64] to an integer of type [t]. *)

  val to_int64 : t -> int64
  (** Convert an integer of type [t] to an integer of type [int64]. *)

  val of_int128 : int128 -> t
  (** Convert an integer of type [int128] to an integer of type [t]. *)

  val to_int128 : t -> int128
  (** Convert an integer of type [t] to an integer of type [int128]. *)

  val of_uint8 : uint8 -> t
  (** Convert an integer of type [uint8] to an integer of type [t]. *)

  val to_uint8 : t -> uint8
  (** Convert an integer of type [t] to an integer of type [uint8]. *)

  val of_uint16 : uint16 -> t
  (** Convert an integer of type [uint16] to an integer of type [t]. *)

  val to_uint16 : t -> uint16
  (** Convert an integer of type [t] to an integer of type [uint16]. *)

  val of_uint24 : uint24 -> t
  (** Convert an integer of type [uint24] to an integer of type [t]. *)

  val to_uint24 : t -> uint24
  (** Convert an integer of type [t] to an integer of type [uint24]. *)

  val of_uint32 : uint32 -> t
  (** Convert an integer of type [uint32] to an integer of type [t]. *)

  val to_uint32 : t -> uint32
  (** Convert an integer of type [t] to an integer of type [uint32]. *)

  val of_uint56 : uint56 -> t
  (** Convert an integer of type [uint56] to an integer of type [t]. *)

  val to_uint56 : t -> uint56
  (** Convert an integer of type [t] to an integer of type [uint56]. *)

  val of_uint64 : uint64 -> t
  (** Convert an integer of type [uint64] to an integer of type [t]. *)

  val to_uint64 : t -> uint64
  (** Convert an integer of type [t] to an integer of type [uint64]. *)

  val of_uint128 : uint128 -> t
  (** Convert an integer of type [uint128] to an integer of type [t]. *)

  val to_uint128 : t -> uint128
  (** Convert an integer of type [t] to an integer of type [uint128]. *)

  val of_string : string -> t
  (** Convert the given string to an integer of type [t].
      The string is read in decimal (by default) or in hexadecimal, octal
      or binary if the string begins with [0x], [0o] or [0b] respectively.
      Raise [Failure "*_of_string"] if the given string is not a valid
      representation of an integer, or if the integer represented exceeds
      the range of integers representable in type [t]. *)

  val to_string : t -> string
  (** Return the string representation of its argument, in decimal. *)

  val to_string_bin : t -> string
  (** Return the string representation of its argument, in binary (beginning with [0b]) *)

  val to_string_oct : t -> string
  (** Return the string representation of its argument, in octal (beginning with [0o]) *)

  val to_string_hex : t -> string
  (** Return the string representation of its argument, in hex (beginning with [0x]) *)

  val printer : Format.formatter -> t -> unit
  val printer_bin : Format.formatter -> t -> unit
  val printer_oct : Format.formatter -> t -> unit
  val printer_hex : Format.formatter -> t -> unit

  val of_bytes_big_endian : Bytes.t -> int -> t
  (** [of_bytes_big_endian buffer offset] creates an integer value of type [t] from the
      buffer [buffer] starting at offset [offset]. The byte order is interpreted to be
      big endian. If the buffer does not hold enough bytes for this integer, i.e. if
      [(Bytes.length buffer) < (offset + (bits / 8))], the function will raise
      [Invalid_argument "index out of bounds"]. *)

  val of_bytes_little_endian : Bytes.t -> int -> t
  (** [of_bytes_big_endian buffer offset] creates an integer value of type [t] from the
      buffer [buffer] starting at offset [offset]. The byte order is interpreted to be
      little endian. If the buffer does not hold enough bytes for this integer, i.e. if
      [(Bytes.length buffer) < (offset + (bits / 8))], the function will raise
      [Invalid_argument "index out of bounds"]. *)

  val to_bytes_big_endian : t -> Bytes.t -> int -> unit
  (** [to_bytes_big_endian i buffer offset] writes the integer [i] to the buffer [buffer]
      starting at offset [offset]. The byte order used is big endian. If the buffer does
      not hold enough bytes, i.e. if [(Bytes.length buffer) < (offset + (bits / 8))], the
      function will raise [Invalid_argument "index out of bounds"]. *)

  val to_bytes_little_endian : t -> Bytes.t -> int -> unit
  (** [to_bytes_little_endian i buffer offset] writes the integer [i] to the buffer [buffer]
      starting at offset [offset]. The byte order used is little endian. If the buffer does
      not hold enough bytes, i.e. if [(Bytes.length buffer) < (offset + (bits / 8))], the
      function will raise [Invalid_argument "index out of bounds"]. *)

  val compare : t -> t -> int
  (** The comparison function for integers of type [t], with the same specification as compare.
      Along with the type [t], this function compare allows this module to be
      passed as argument to the functors Set.Make and Map.Make. *)
end

module Int8 : Int with type t = int8
module Int16 : Int with type t = int16
module Int32 : Int with type t = int32
module Int64 : Int with type t = int64
module Int128 : Int with type t = int128
module Uint8 : Int with type t = uint8
module Uint16 : Int with type t = uint16
module Uint24 : Int with type t = uint24
module Uint32 : Int with type t = uint32
module Uint56 : Int with type t = uint56
module Uint64 : Int with type t = uint64
module Uint128 : Int with type t = uint128

