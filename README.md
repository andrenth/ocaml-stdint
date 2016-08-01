# ocaml-stdint
This OCaml library provides integer types having specified widths.

It provides the following unsigned integer types:
* uint8
* uint16
* uint24
* uint32
* uint40
* uint48
* uint56
* uint64
* uint128

and the following list of signed integer types:
* int8
* int16
* int24
* int32 (identical to int32 from the base library)
* int40
* int48
* int56
* int64 (identical to int64 from the base library)
* int128

There is a module for every integer type that implements the Int interface.
This interface is similar to Int32 and Int64 from the base library but provides more functions and constants like
* arithmetic and bit-wise operations
* constants like maximum and minimum value
* infix operators
* conversion to and from every other integer type (including int, float and nativeint)
* parsing from and conversion to readable strings (binary, octal, decimal, hexademical)
* conversion to and from buffers in both big endian and little endian byte order

The library also comes with C header files that allow easy access to the integer values in C bindings.
The functions are modeled on base of the int32 and int64 access functions provided by the base library.
The semantics of all operations is identical to the Int32, Int64 modules, C, C++, Java etc.: Conversion will silently truncate larger values as will other operations leading to overflowing integer values.

The [API of stdint](http://stdint.forge.ocamlcore.org/doc/) can be found online at the [OCaml forge](https://forge.ocamlcore.org/).

To use the integer types, we recommend to ```open Stdint``` but not the individual modules:
```ocaml
open Stdint

let _ =
  let a = Uint8.of_int 21 in
  let x = Uint8.(a * (one + one)) in
  print_endline (Uint8.to_string x)
```

The 128 bit integer types are currently only available on 64 bit platforms; the compatibility layer for 32 bit platforms is not yet fully implemented and will raise `Failure` for several functions.

## Implementation

The representation of integers depends on their size:
* Signed integers smaller than the standard integer type are stored in a standard ```int```. They are left-aligned so that most arithmetic operations are just the same as the ones on normal integers. The standard OCaml integer type is 31 bit on 32 bit machines and 63 bit on 64 bit machines. Operations like addition and division require an extra shift; others like xor require an additional mask to keep the unused bits (at the right) at ```0```.
* Unsigned integers smaller than the standard integer types are stored in the standard ```int```, too. They are right-aligned making most arithmetic operations compatible to standard integer operations. Operations like addition require an additional mask operation to keep the unused bits (at the left) at ```0```.
* ```uint32``` and ```uint64``` have their custom in-memory representation implemented in C
* Signed integers larger than the standard integer but smaller than ```int64``` are stored in the latter. The requirements are otherwise identical to small signed integers store in the standard integer.
* Unsigned integers larger than the standard integer but smaller then ```uint64``` are stored in the latter. The requirements are otherwise identical to small unsigned integers store in the standard integer.
* 128 Bit integers have a custom in-memory representation implemented in C. On 64 Bit platforms they use the specialized arithmetic operations provided by the C compiler that are much faster than manual operations, to which a fallback solution exists on 32 Bit platforms.

## Copyright

The stdint library is written by Andre Nathan, Jeff Shaw, [Markus Weissmann](http://www.mweissmann.de) and Florian Pichlmeier.
It is based on the [ocaml-uint](https://github.com/andrenth/ocaml-uint/) library.

The source-code of stdint is available under the MIT license.
