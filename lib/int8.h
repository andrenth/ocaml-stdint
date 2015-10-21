#ifndef OCAML_INT8_H
#define OCAML_INT8_H

#ifdef ARCH_SIXTYFOUR

#define Int8_val(x) ((int8_t)(((intnat)(x)) >> 56))
#define Val_int8(x) (((intnat)(x) << 56) + 1)

#else

#define Int8_val(x) ((int8_t)(((intnat)(x)) >> 24))
#define Val_int8(x) (((intnat)(x) << 24) + 1)

#endif

#endif
