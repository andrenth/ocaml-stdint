module type Str_conv_sig = sig
  module type IntSig = sig
    type t
    val name    : string
    val fmt     : string
    val zero    : t
    val max_int : t
    val min_int : t
    val bits    : int
    val of_int  : int -> t
    val to_int  : t -> int
    val add     : t -> t -> t
    val sub     : t -> t -> t
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

  module Make (I : IntSig) : S with type t = I.t
end

module Str_conv : Str_conv_sig = struct
  module type IntSig = sig
    type t
    val name    : string
    val fmt     : string
    val zero    : t
    val max_int : t
    val min_int : t
    val bits    : int
    val of_int  : int -> t
    val to_int  : t -> int
    val add     : t -> t -> t
    val sub     : t -> t -> t
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

  module Make (I : IntSig) : S with type t = I.t = struct
    type t = I.t

    let digit_of_char c =
      let disp =
        if c >= '0' && c <= '9' then 48
        else if c >= 'A' && c <= 'F' then 55
        else if c >= 'a' && c <= 'f' then 87
        else failwith (I.name ^ ".of_string") in
      int_of_char c - disp

    let of_string s =
      let fail () = invalid_arg (I.name ^ ".of_string") in
      let len = String.length s in
      (* is this supposed to be a negative number? *)
      let negative, offset =
        let () = if (len = 0) then fail () else () in
        if s.[0] = '-' then
          true, 1
        else
          false, 0
      in
      (* does the string have a base-prefix and what base is it? *)
      let base, offset =
        if (len - offset) < 3 then (* no space for a prefix in there *)
          10, offset
        else if s.[offset] = '0' && (s.[offset + 1] < '0' || s.[offset + 1] > '9') then
          let base =
            begin match s.[offset + 1] with
              | 'b' | 'B' -> 2
              | 'o' | 'O' -> 8
              | 'x' | 'X' -> 16
              | _ -> fail ()
            end
          in
          base, (offset + 2)
        else
          10, offset
      in
      let base = I.of_int base in
      (* operators that are different for parsing negative and positive numbers *)
      let thresh, join, cmp =
        if negative then
          (fst (I.divmod I.min_int base), I.sub, (>))
        else
          (fst (I.divmod I.max_int base), I.add, (<))
      in
      let rec loop offset (n : I.t) =
        if offset = len then n
        else begin
          (* will shifting the current value result in an overflow? *)
          let () = if (n < thresh) then fail () else () in
          let c = s.[offset] in
          if c <> '_' then
            let d = I.of_int (digit_of_char c) in
            (* shift the existing number, join the new digit *)
            let res = join (I.mul n base) d in
            (* did we just have an overflow though? *)
            let () = if (cmp res d) then fail () else () in
            loop (offset + 1) res
          else
            loop (offset + 1) n
        end
      in
      loop offset I.zero

    let to_string_base base prefix x =
      let base = I.of_int base in
      let conv = "0123456789abcdef" in
      if x = I.zero then
        prefix ^ "0"
      else begin
        let maxlen = 3 + I.bits in (* worst-case: 1 (signed) + 2 (prefix) + 1 char-per-bit *)
        let buffer = String.create maxlen in
        let offset = ref (maxlen - 1) in
        let rec loop n =
          if n = I.zero then ()
          else
            let n', digit = I.divmod n base in
            let () = buffer.[!offset] <- conv.[abs (I.to_int digit)] in
            let () = decr offset in
            loop n'
        in
        let () = loop x in
        let () = String.iter (fun c -> let () = buffer.[!offset] <- c in decr offset) prefix in
        let () = if x < I.zero then let () = buffer.[!offset] <- '-' in decr offset else () in
        String.sub buffer !offset (3 + I.bits - !offset)
      end

    let to_string = to_string_base 10 ""
    let to_string_bin = to_string_base 2 "0b"
    let to_string_oct = to_string_base 8 "0o"
    let to_string_hex = to_string_base 16 "0x"

    let print_with f fmt x =
      Format.fprintf fmt "@[%s@]" (f x ^ I.fmt)

    let printer = print_with to_string
    let printer_bin = print_with to_string_bin
    let printer_oct = print_with to_string_oct
    let printer_hex = print_with to_string_hex
  end
end
