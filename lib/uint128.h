#ifndef OCAML_UINT128_H
#define OCAML_UINT128_H

#define Uint128_val(v) (*((__uint128_t *)Data_custom_val(v)))

CAMLextern value copy_uint128(__uint128_t i);

#endif
