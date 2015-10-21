#ifndef OCAML_UINT8_H
#define OCAML_UINT8_H

#define Uint8_val(x) ((uint8_t)(((intnat)(x))))
#define Val_uint8(x) (((intnat)((x) & 0xFF) << 1) + 1)

#endif

