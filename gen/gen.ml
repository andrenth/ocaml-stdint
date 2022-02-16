#!/usr/bin/env ocaml
type i =
  | N
  | I
  | F
  | I8
  | I16
  | I24
  | I32
  | I40
  | I48
  | I56
  | I64
  | I128
  | U8
  | U16
  | U24
  | U32
  | U40
  | U48
  | U56
  | U64
  | U128

let name = function
  | N -> "nativeint"
  | I -> "int"
  | F -> "float"
  | I8 -> "int8"
  | I16 -> "int16"
  | I24 -> "int24"
  | I32 -> "int32"
  | I40 -> "int40"
  | I48 -> "int48"
  | I56 -> "int56"
  | I64 -> "int64"
  | I128 -> "int128"
  | U8 -> "uint8"
  | U16 -> "uint16"
  | U24 -> "uint24"
  | U32 -> "uint32"
  | U40 -> "uint40"
  | U48 -> "uint48"
  | U56 -> "uint56"
  | U64 -> "uint64"
  | U128 -> "uint128"

let ctype = function
  | N -> "int"
  | I -> "int"
  | F -> "double"
  | I8 -> "int8_t"
  | I16 -> "int16_t"
  | I24 -> "int32_t"
  | I32 -> "int32_t"
  | I40 -> "int64_t"
  | I48 -> "int64_t"
  | I56 -> "int64_t"
  | I64 -> "int64_t"
  | I128 -> "__int128_t"
  | U8 -> "uint8_t"
  | U16 -> "uint16_t"
  | U24 -> "uint32_t"
  | U32 -> "uint32_t"
  | U40 -> "uint64_t"
  | U48 -> "uint64_t"
  | U56 -> "uint64_t"
  | U64 -> "uint64_t"
  | U128 -> "__uint128_t"

let valf x = let r = match x with
  | I -> "Int"
  | N -> "Nativeint"
  | F -> "Double"
  | I8 -> "Int8"
  | I16 -> "Int16"
  | I24 -> "Int24"
  | I32 -> "Int32"
  | I40 -> "Int40"
  | I48 -> "Int48"
  | I56 -> "Int56"
  | I64 -> "Int64"
  | I128 -> "Int128"
  | U8 -> "Uint8"
  | U16 -> "Uint16"
  | U24 -> "Uint24"
  | U32 -> "Uint32"
  | U40 -> "Uint40"
  | U48 -> "Uint48"
  | U56 -> "Uint56"
  | U64 -> "Uint64"
  | U128 -> "Uint128"
  in r ^ "_val"

let copyf : i -> (('a -> 'b, unit, string) format) = function
  | N -> "caml_copy_nativeint(%s)"
  | I -> "Val_int(%s)"
  | F -> "caml_copy_double(%s)"
  | I8 -> "copy_int8(%s)"
  | I16 -> "copy_int16(%s)"
  | I24 -> "caml_copy_int32((%s) << 8)"
  | I32 -> "caml_copy_int32(%s)"
  | I40 -> "caml_copy_int64((%s) << 24)"
  | I48 -> "caml_copy_int64((%s) << 16)"
  | I56 -> "caml_copy_int64((%s) << 8)"
  | I64 -> "caml_copy_int64(%s)"
  | I128 -> "copy_int128(%s)"
  | U8 -> "copy_uint8(%s)"
  | U16 -> "copy_uint16(%s)"
  | U24 -> "copy_uint32((%s) << 8)"
  | U32 -> "copy_uint32(%s)"
  | U40 -> "copy_uint64((%s) << 24)"
  | U48 -> "copy_uint64((%s) << 16)"
  | U56 -> "copy_uint64((%s) << 8)"
  | U64 -> "copy_uint64(%s)"
  | U128 -> "copy_uint128(%s)"

let is_base = function
  | N | I | F -> true
  | _ -> false

let in_mltypes = function
  | N | I | F | I32 | I64 -> true
  | _ -> false

let all_types = [I; N; F; I8; I16; I24; I32; I40; I48; I56; I64; I128; U8; U16; U24; U32; U40; U48; U56; U64; U128]

let prefix =
  let includes1 =
    ["assert"; "stdint"; "string"; "inttypes"; "caml/alloc"; "caml/custom"; "caml/fail"; "caml/intext"; "caml/memory"; "caml/mlvalues"] |>
    List.fold_left (fun str elt -> Printf.sprintf "%s#include <%s.h>\n" str elt) ""
  in
  let includes2 =
    List.filter (fun x -> not (in_mltypes x)) all_types |>
    List.fold_left (fun str elt -> Printf.sprintf "%s#include \"%s.h\"\n" str (name elt)) ""
  in
  includes1 ^ "\n" ^ includes2

let f dst src =
  if dst = src then "" else
  if (is_base dst) && (is_base src) then "" else
  let arg = Printf.sprintf "(%s)%s(v)" (ctype dst) (valf src) in
  let body = Printf.sprintf (copyf dst) arg in
  "CAMLprim value\n" ^
  (Printf.sprintf "%s_of_%s(value v)\n{\n" (name dst) (name src)) ^
  "  CAMLparam1(v);\n" ^
  (Printf.sprintf "  CAMLreturn (%s);\n}\n\n" body)

let convc btype =
  let filename = (name btype) ^ "_conv.c" in
  let oc = open_out filename in
  let () = Printf.fprintf oc "%s\n" prefix in
  let () = List.iter (fun x -> Printf.fprintf oc "%s" (f btype x)) all_types in
  close_out oc

let conv_of base other : string =
  let ofname = if base = other then "%identity" else Printf.sprintf "%s_of_%s" (name base) (name other) in
  Printf.sprintf "    external of_%-9s : %9s -> %9s = \"%s\"\n" (name other) (name other) (name base) ofname

let conv_to base other : string =
  let ofname = if base = other then "%identity" else Printf.sprintf "%s_of_%s" (name other) (name base) in
  Printf.sprintf "    external to_%-9s : %9s -> %9s = \"%s\"\n" (name other) (name base) (name other) ofname

let extml btype =
  if is_base btype then ()
  else
    let filename = (name btype) ^ "_conv_ext.ml" in
    let oc = open_out filename in
    let () = List.iter (fun x -> Printf.fprintf oc "%s" (conv_of btype x)) all_types in
    let () = Printf.fprintf oc "\n" in
    let () = List.iter (fun x -> Printf.fprintf oc "%s" (conv_to btype x)) all_types in
    close_out oc

let _ =
  let () = List.iter extml all_types in
  let () = List.iter convc all_types in
  ()

