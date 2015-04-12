#ifndef OCAML_UINT16_H
#define OCAML_UINT16_H

#define Uint8_val(v) (*((uint8_t *)Data_custom_val(v)))

CAMLextern value copy_uint8(uint8_t i);
#endif
