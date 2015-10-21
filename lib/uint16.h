#ifndef OCAML_UINT16_H
#define OCAML_UINT16_H

#define Uint16_val(x) ((uint16_t)(((intnat)(x))))
#define Val_uint16(x) (((intnat)((x) & 0xFFFF) << 1) + 1)

#endif

