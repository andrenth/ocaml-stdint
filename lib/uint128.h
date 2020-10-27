#ifndef OCAML_UINT128_H
#define OCAML_UINT128_H

#if defined(__SIZEOF_INT128__) 

#define HAVE_UINT128
typedef __uint128_t uint128;
#define Uint128_val(v) (*((__uint128_t *)((uintnat *)Data_custom_val(v) + (3 & (0 - ((uintptr_t)Data_custom_val(v) & 0x8) >> 3)))))

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
