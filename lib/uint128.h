#ifndef OCAML_UINT128_H
#define OCAML_UINT128_H

#if defined(__SIZEOF_INT128__) 

#define HAVE_UINT128
typedef __uint128_t uint128;
typedef struct { uint64_t low; uint64_t high; } uint128_ocaml;

inline __uint128_t get_uint128(value v)
{
  uint128_ocaml *i = (uint128_ocaml *)Data_custom_val(v);
  return ((__uint128_t)i->high << 64 | i->low);
}

#define Uint128_val(v) get_uint128(v)

#else

typedef struct { uint64_t high; uint64_t low; } uint128;

#define Uint128_val(v) (*((uint128 *)Data_custom_val(v)))

#endif

CAMLextern value copy_uint128(uint128 i);
CAMLextern value suint128_add(value v1, value v2, CAMLprim value (*)(uint128));
CAMLextern value suint128_sub(value v1, value v2, CAMLprim value (*)(uint128));
CAMLextern value suint128_mul(value v1, value v2, CAMLprim value (*)(uint128));
CAMLextern value suint128_and(value v1, value v2, CAMLprim value (*)(uint128));
CAMLextern value suint128_or(value v1, value v2, CAMLprim value (*)(uint128));
CAMLextern value suint128_xor(value v1, value v2, CAMLprim value (*)(uint128));
CAMLextern value suint128_shift_left(value v1, value v2, CAMLprim value (*)(uint128));

#endif
