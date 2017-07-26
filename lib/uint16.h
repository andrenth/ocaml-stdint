#ifndef OCAML_UINT16_H
#define OCAML_UINT16_H

#define Uint16_val(x) ((uint16_t)(Unsigned_long_val(x)))
#define Val_uint16(x) (Val_long((x) & 0xFFFF))

#endif

