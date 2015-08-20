#ifndef OCAML_UINT8_H
#define OCAML_UINT8_H

#define Uint8_val(v) (*((uint8_t *)Data_custom_val(v)))

CAMLextern value copy_uint8(uint8_t i);
#endif
