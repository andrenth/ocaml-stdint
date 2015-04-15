#ifndef OCAML_UINT16_H
#define OCAML_UINT16_H

#define Uint16_val(v) (*((uint16_t *)Data_custom_val(v)))

CAMLextern value copy_uint16(uint16_t i);
#endif
