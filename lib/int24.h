#ifndef OCAML_INT24_H
#define OCAML_INT24_H

#ifdef ARCH_SIXTYFOUR

#define Int24_val(x) ((int32_t)(((intnat)(x)) >> 40))
#define Val_int24(x) (((intnat)(x) << 40) + 1)

#else

#define Int24_val(x) ((int32_t)(((intnat)(x)) >> 8))
#define Val_int24(x) (((intnat)(x) << 8) + 1)

#endif

#endif

