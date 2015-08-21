#ifndef OCAML_UINT40_H
#define OCAML_UINT40_H

#include "uint64.h"

#define Uint40_val(v) ((*((uint64_t *)Data_custom_val(v))) >> 24)

#define copy_uint40(v) copy_uint64(v)

#endif
