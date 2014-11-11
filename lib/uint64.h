#ifndef OCAML_UINT64_H
#define OCAML_UINT64_H

#define Uint64_val(v) (*((uint64_t *)Data_custom_val(v)))

CAMLextern value copy_uint64(uint64_t i);

#endif
