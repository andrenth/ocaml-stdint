open Stdint

let () =
  let i = Int128.of_string "123123" in
  let f = Int128.to_float i in
  Printf.printf "%g\n" f
