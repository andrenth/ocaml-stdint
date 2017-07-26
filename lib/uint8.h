#ifndef OCAML_UINT8_H
#define OCAML_UINT8_H

#define Uint8_val(x) ((uint8_t)(Unsigned_long_val(x)))
#define Val_uint8(x) (Val_long((x) & 0xFF))

#endif

