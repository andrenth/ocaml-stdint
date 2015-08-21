#ifndef OCAML_UINT56_H
#define OCAML_UINT56_H

#include "uint64.h"

#define Uint56_val(v) ((*((uint64_t *)Data_custom_val(v))) >> 8)

#define copy_uint56(v) copy_uint64(v)

#endif
