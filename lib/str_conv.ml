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
  val of_substring : string -> pos:int -> (t * int)
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

  exception EndOfNumber of I.t * int

  (** Base function for *of_string* and *of_substring*
    * functions *)
  let _of_substring start_off s func_name =
    let fail () = invalid_arg (I.name ^ func_name) in
    if start_off >= String.length s then fail ();
    (* is this supposed to be a negative number? *)
    let negative, off =
      if s.[start_off] = '-' then
        true, 1+start_off
      else if s.[start_off] = '+' then
        false, 1+start_off
      else
        false, start_off in
    let len = String.length s in
    if len <= off then fail ();
    (* does the string have a base-prefix and what base is it? *)
    let base, off =
      let is_digit ~base c =
        if base <= 10 then (
          Char.(code c - code '0') < base
        ) else (
          (c >= '0' && c <= '9') ||
          (10 + Char.(code (lowercase_ascii c) - code 'a') < base)
        ) in
      if len - off < 3 then (* no space for a prefix in there *)
        10, off
      else if s.[off] = '0' then
        match Char.lowercase_ascii s.[off + 1] with
        | 'b' when is_digit ~base:2 s.[off+2] -> 2, off + 2
        | 'o' when is_digit ~base:8 s.[off+2] ->  8, off + 2
        | 'x' when is_digit ~base:16 s.[off+2] -> 16, off + 2
        | _ -> 10, off
      else 10, off in
    let base = I.of_int base in
    (* operators that are different for parsing negative and positive numbers *)
    let (thresh, rem), join, cmp_safe =
      if negative then
        (I.divmod I.min_int base, I.sub, 1)
      else
        (I.divmod I.max_int base, I.add, -1) in
    let rec loop off (n : I.t) =
      if off = len then
        n, off
      else begin
        let c = s.[off] in
        if c <> '_' then begin
          let disp =
            if c >= '0' && c <= '9' then 48
            else if c >= 'A' && c <= 'F' then 55
            else if c >= 'a' && c <= 'f' then 87
            else raise (EndOfNumber (n, off)) in
          let disp = int_of_char c - disp in
          let d = I.of_int disp in
          (* do not accept digit larger than the base *)
          if d >= base then raise (EndOfNumber (n, off));
          (* will we overflow? *)
          (match compare n thresh with
          | 0 ->
            let r = compare d rem in
            if r <> cmp_safe && r <> 0 then raise (EndOfNumber (n, off));
          | r ->
            if r <> cmp_safe then raise (EndOfNumber (n, off)));
          (* shift the existing number, join the new digit *)
          let res = join (I.mul n base) d in
          loop (off + 1) res
        end else
          loop (off + 1) n
      end
    in
    loop off I.zero

  let of_substring s ~pos =
    try
      _of_substring pos s ".of_substring"
    with
      | EndOfNumber (n, off) -> n, off

  let of_string s =
    try
      let n, _ = _of_substring 0 s ".of_string" in n
    with
      | EndOfNumber _ -> invalid_arg (I.name ^ ".of_string")

  let to_string_base base prefix x =
    let prefixlen = String.length prefix in
    let base = I.of_int base in
    let conv = "0123456789abcdef" in
    if x = I.zero then
      prefix ^ "0"
    else begin
      (* worst-case: 1 (signed) + length prefix + 1 char-per-bit *)
      let maxlen = 1 + prefixlen + I.bits in
      let buffer = Bytes.create maxlen in
      (* create the number starting at the end of the buffer, working towards
       * its start. *)
      let off = ref (maxlen - 1) in
      let rec loop n =
        if n <> I.zero then begin
          let n', digit = I.divmod n base in
          let digit = (I.to_int digit) in
          Bytes.set buffer !off conv.[abs digit];
          decr off;
          loop n'
        end in
      loop x;
      (* add prefix -- in reverse order *)
      for i = prefixlen - 1 downto 0 do
        Bytes.set buffer !off (String.get prefix i);
        decr off
      done;
      if x < I.zero then begin
        Bytes.set buffer !off '-';
        decr off
      end;
      Bytes.sub_string buffer (!off + 1) (maxlen - !off - 1)
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
