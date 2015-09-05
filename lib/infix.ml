module type IntSig = sig
  type t
  val add : t -> t -> t
  val sub : t -> t -> t
  val mul : t -> t -> t
  val div : t -> t -> t
end

module type S = sig
  type t
  val ( + ) : t -> t -> t
  val ( - ) : t -> t -> t
  val ( * ) : t -> t -> t
  val ( / ) : t -> t -> t
end

module Make (I : IntSig) = struct
  type t = I.t

  let ( + ) = I.add
  let ( - ) = I.sub
  let ( * ) = I.mul
  let ( / ) = I.div
end

