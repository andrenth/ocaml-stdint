#ifndef OCAML_UINT24_H
#define OCAML_UINT24_H

#include "uint32.h"

#define Uint24_val(v) ((*((uint32_t *)Data_custom_val(v))) >> 8)

#define copy_uint24(v) copy_uint32(v)

#endif
