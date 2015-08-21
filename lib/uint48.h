#ifndef OCAML_UINT48_H
#define OCAML_UINT48_H

#include "uint64.h"

#define Uint48_val(v) ((*((uint64_t *)Data_custom_val(v))) >> 16)

#define copy_uint48(v) copy_uint64(v)

#endif
