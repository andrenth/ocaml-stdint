#ifndef OCAML_UINT128_H
#define OCAML_UINT128_H

#define next_aligned(p) (void *)((((intptr_t)p)+8) & ~15ULL)

#if defined(__SIZEOF_INT128__)
#define HAVE_UINT128
typedef __uint128_t uint128;
#else
typedef struct { uint64_t high; uint64_t low; } uint128;
#endif

#define Uint128_val(v) (*((uint128 *)next_aligned(Data_custom_val(v))))

CAMLextern value copy_uint128(uint128 i);
CAMLextern value suint128_add(value v1, value v2, CAMLprim value (*)(uint128));
CAMLextern value suint128_sub(value v1, value v2, CAMLprim value (*)(uint128));
CAMLextern value suint128_mul(value v1, value v2, CAMLprim value (*)(uint128));
CAMLextern value suint128_and(value v1, value v2, CAMLprim value (*)(uint128));
CAMLextern value suint128_or(value v1, value v2, CAMLprim value (*)(uint128));
CAMLextern value suint128_xor(value v1, value v2, CAMLprim value (*)(uint128));
CAMLextern value suint128_shift_left(value v1, value v2, CAMLprim value (*)(uint128));

#endif

