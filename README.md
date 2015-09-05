# ocaml-stdint
This OCaml library provides integer types having specified widths.

It provides the following unsigned integer types:
* uint8
* uint16
* uint24
* uint32
* uint40
* uint48
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
* int48
* int56
* int64 (identical to int64 from the base library)
* int128

There is a module for every integer type that implements the Int interface.
This interface is similar to Int32 and Int64 from the base library but provides more functions and constants like
* arithmetic and bit-wise operations
* constants like maximum and minimum value
* conversion to and from every other integer type (including int, float and nativeint)
* parsing from and conversion to readable strings (binary, octal, decimal, hexademical)
* conversion to and from buffers in both big endian and little endian byte order

The library also comes with C header files that allow easy access to the integer values in C bindings.
The functions are modeled on base of the int32 and int64 access functions provided by the base library.

The stdint library is written by Andre Nathan, Jeff Shaw, [Markus Weissmann](http://www.mweissmann.de) and Florian Pichlmeier.
It is based on the [ocaml-uint](https://github.com/andrenth/ocaml-uint/) library.

The source-code of stdint is available under the MIT license.
