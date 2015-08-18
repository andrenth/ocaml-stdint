#ifndef OCAML_INT8_H
#define OCAML_INT8_H

#define Int8_val(v) (*((int8_t *)Data_custom_val(v)))

CAMLextern value copy_int8(int8_t i);

#endif
