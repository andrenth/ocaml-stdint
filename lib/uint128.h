#ifndef OCAML_UINT128_H
#define OCAML_UINT128_H

#if defined(__SIZEOF_INT128__) 
typedef __uint128_t uint128;
#else
typedef struct { uint64_t high; uint64_t low; } uint128;
#endif

#define Uint128_val(v) (*((uint128 *)Data_custom_val(v)))

CAMLextern value copy_uint128(uint128 i);

#endif

