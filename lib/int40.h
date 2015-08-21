#ifndef OCAML_INT40_H
#define OCAML_INT40_H

#define Int40_val(v) ((*((int64_t *)Data_custom_val(v))) >> 24)

#define copy_int40(v) copy_int32(v)

#endif
