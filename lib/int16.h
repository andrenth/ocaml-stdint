#ifndef OCAML_INT16_H
#define OCAML_INT16_H

#ifdef ARCH_SIXTYFOUR

#define Int16_val(x) ((int16_t)(((intnat)(x)) >> 48))
#define Val_int16(x) (((intnat)(x) << 48) + 1)

#else

#define Int16_val(x) ((int16_t)(((intnat)(x)) >> 16))
#define Val_int16(x) (((intnat)(x) << 16) + 1)

#endif

#endif
