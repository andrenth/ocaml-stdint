#ifndef OCAML_UINT32_H
#define OCAML_UINT32_H

#define Uint32_val(v) (*((utin32_t *)Data_custom_val(v)))

CAMLextern value copy_uint32(utin32_t i);
#endif
