#ifndef OCAML_UINT32_H
#define OCAML_UINT32_H

#define Uint32_val(v) (*((uint32 *)Data_custom_val(v)))

CAMLextern value copy_uint32(uint32 i);
#endif
