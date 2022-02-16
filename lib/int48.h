#ifndef OCAML_INT48_H
#define OCAML_INT48_H

#define Int48_val(v) ((*((int64_t *)Data_custom_val(v))) >> 16)

#define copy_int48(v) caml_copy_int64(v)

#endif
