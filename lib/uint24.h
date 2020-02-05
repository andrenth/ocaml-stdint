#ifndef OCAML_UINT24_H
#define OCAML_UINT24_H

#define Uint24_val(x) ((uint32_t)(Unsigned_long_val(x)))
#define Val_uint24(x) (Val_long((x) & 0xFFFFFF))

#endif

