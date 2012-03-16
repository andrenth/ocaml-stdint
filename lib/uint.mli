module type Str_conv_sig = sig
  module type UintSig = sig
    type t
    val name    : string
    val fmt     : string
    val zero    : t
    val max_int : t
    val bits    : int
    val of_int  : int -> t
    val to_int  : t -> int
    val add     : t -> t -> t
    val mul     : t -> t -> t
    val divmod  : t -> t -> t * t
  end

  module type S = sig
    type t
    val of_string : string -> t
    val to_string : t -> string
    val to_string_bin : t -> string
    val to_string_oct : t -> string
    val to_string_hex : t -> string
    val printer : Format.formatter -> t -> unit
    val printer_bin : Format.formatter -> t -> unit
    val printer_oct : Format.formatter -> t -> unit
    val printer_hex : Format.formatter -> t -> unit
  end

  module Make (U : UintSig) : S with type t = U.t
end

module Str_conv : Str_conv_sig
