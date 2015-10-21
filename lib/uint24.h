#ifndef OCAML_UINT24_H
#define OCAML_UINT24_H

#define Uint24_val(x) ((uint32_t)(((intnat)(x))))
#define Val_uint24(x) (((intnat)((x) & 0xFFFFFF) << 1) + 1)

#endif

