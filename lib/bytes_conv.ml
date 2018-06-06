module type IntSig = sig
  type t
  val zero    : t
  val bits    : int
  val of_int  : int -> t
  val to_int  : t -> int
  val logand  : t -> t -> t
  val logor   : t -> t -> t
  val shift_left : t -> int -> t
  val shift_right_logical : t -> int -> t
end

module type S = sig
  type t
  val of_bytes_big_endian : Bytes.t -> int -> t
  val of_bytes_little_endian : Bytes.t -> int -> t
  val to_bytes_big_endian : t -> Bytes.t -> int -> unit
  val to_bytes_little_endian : t -> Bytes.t -> int -> unit
end

let int_of_pos buffer offset = Char.code (Bytes.get buffer offset)

module Make (I : IntSig) = struct
  type t = I.t

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
        let b = Char.unsafe_chr (I.to_int (I.logand (I.of_int 0xFF) n)) in
        let () = Bytes.set buffer (offset + i - 1) b in
        let n' = I.shift_right_logical n 8 in
        loop buffer (i - 1) n'
    in
    loop buffer (I.bits / 8) v

  let to_bytes_little_endian v buffer offset =
    let rec loop buffer i n =
      if i = (I.bits / 8) then ()
      else
        let b = Char.unsafe_chr (I.to_int (I.logand (I.of_int 0xFF) n)) in
        let () = Bytes.set buffer (offset + i) b in
        let n' = I.shift_right_logical n 8 in
        loop buffer (i + 1) n'
    in
    loop buffer 0 v
end

