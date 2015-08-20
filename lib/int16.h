#ifndef OCAML_INT16_H
#define OCAML_INT16_H

#define Int16_val(v) (*((int16_t *)Data_custom_val(v)))

CAMLextern value copy_int16(int16_t i);
#endif
