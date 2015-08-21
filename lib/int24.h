#ifndef OCAML_INT24_H
#define OCAML_INT24_H

#define Int24_val(v) ((*((int32_t *)Data_custom_val(v))) >> 8)

#define copy_int24(v) copy_int32(v)

#endif
