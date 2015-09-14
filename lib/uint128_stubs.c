#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <inttypes.h>

#include <caml/alloc.h>
#include <caml/custom.h>
#include <caml/fail.h>
#include <caml/intext.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

#include "int8.h"
#include "int16.h"
#include "int128.h"
#include "uint8.h"
#include "uint16.h"
#include "uint32.h"
#include "uint64.h"
#include "uint128.h"

#if defined(__SIZEOF_INT128__) 
// implementation using __uint128 provided on most 64 bit platforms

static int
uint128_cmp(value v1, value v2)
{
    __uint128_t i1 = Uint128_val(v1);
    __uint128_t i2 = Uint128_val(v2);
    return (i1 > i2) - (i1 < i2);
}

static intnat
uint128_hash(value v)
{
    return Uint128_val(v);
}

static void
uint128_serialize(value v, uintnat *wsize_32, uintnat *wsize_64)
{
    caml_failwith("unimplemented");
}

static uintnat
uint128_deserialize(void *dst)
{
    caml_failwith("unimplemented");
    return 16;
}

struct custom_operations uint128_ops = {
    "uint.int128",
    custom_finalize_default,
    uint128_cmp,
    uint128_hash,
    uint128_serialize,
    uint128_deserialize
};

CAMLprim value
copy_uint128(__uint128_t i)
{
    CAMLparam0();
    value res = caml_alloc_custom(&uint128_ops, 16, 0, 1);
    Uint128_val(res) = i;
    CAMLreturn (res);
}

CAMLprim value
uint128_add(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint128(Uint128_val(v1) + Uint128_val(v2)));
}

CAMLprim value
uint128_sub(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint128(Uint128_val(v1) - Uint128_val(v2)));
}

CAMLprim value
uint128_mul(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint128(Uint128_val(v1) * Uint128_val(v2)));
}

CAMLprim value
uint128_div(value v1, value v2)
{
    CAMLparam2(v1, v2);
    __uint128_t divisor = Uint128_val(v2);

    if (divisor == 0)
        caml_raise_zero_divide();
    CAMLreturn (copy_uint128(Uint128_val(v1) / divisor));
}

CAMLprim value
uint128_mod(value v1, value v2)
{
    CAMLparam2(v1, v2);
    __uint128_t divisor = Uint128_val(v2);
    if (divisor == 0)
        caml_raise_zero_divide();
    CAMLreturn (copy_uint128(Uint128_val(v1) % divisor));
}

CAMLprim value
uint128_and(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint128(Uint128_val(v1) & Uint128_val(v2)));
}

CAMLprim value
uint128_or(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint128(Uint128_val(v1) | Uint128_val(v2)));
}

CAMLprim value
uint128_xor(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint128(Uint128_val(v1) ^ Uint128_val(v2)));
}

CAMLprim value
uint128_shift_left(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint128(Uint128_val(v1) << Int_val(v2)));
}

CAMLprim value
uint128_shift_right(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint128(Uint128_val(v1) >> Int_val(v2)));
}

CAMLprim value
uint128_bits_of_float(value v)
{
    CAMLparam1(v);
    union { float d; __uint128_t i; } u;
    u.d = Double_val(v);
    CAMLreturn (copy_uint128(u.i));
}

CAMLprim value
uint128_float_of_bits(value v)
{
    CAMLparam1(v);
    union { float d; __uint128_t i; } u;
    u.i = Uint128_val(v);
    CAMLreturn (caml_copy_double(u.d));
}

static const __uint128_t uint128_max = (((__uint128_t) UINT64_MAX) << 64) | ((__uint128_t) UINT64_MAX);

CAMLprim value
uint128_neg(value v)
{
    CAMLparam1(v);
    CAMLreturn (copy_uint128(uint128_max - Uint128_val(v) + 1));
}

#else
// implementation using struct { uint64_t high; uint64_t low; }

static inline int cmp(const uint128 *x, const uint128 *y) {
    uint64_t high = x->high - y->high;
    if (0 != high) {
      return high;
    }
    return x->low - y->low;
}

static inline void or(uint128 *x, uint128 *y) {
  x->low |= y->low;
  x->high |= y->high;
}

static inline void and(uint128 *x, uint128 *y) {
  x->low &= y->low;
  x->high &= y->high;
}

static inline void succ(uint128 *x) {
  x->low++;
  if (0 == x->low) {
    x->high++;
  }
}

static inline void shift_right(uint128 *x, int s) {
  if (0 == s) {
    // nothing
  } else if (s < 64) {
    x->low = (x->high << (64 - s)) | (x->low >> s);
    x->high = x->high >> s;
  } else {
    x->low = x->high >> (s - 64);
    x->high = 0;
  }
}

static inline void shift_left(uint128 *x, int s) {
  if (0 == s) {
    // nothing
  } else if (s < 64) {
    x->high = (x->high << s) | (x->low >> (64 - s));
    x->low = x->low << s;
  } else {
    x->high = x->low << (s - 64);
    x->low = 0;
  }
}

static inline void sub(uint128 *x, uint128 *y) {
  if (x->low < y->low) {
    x->high--;
  }
  x->low = x->low - y->low;
  x->high = x->high - y->high;
}

static const uint128 uint128_max = {.high = UINT64_MAX, .low = UINT64_MAX };

static int
uint128_cmp(value a, value b)
{
  uint128 x = Uint128_val(a);
  uint128 y = Uint128_val(b);
  return cmp(&x, &y);
}

static intnat
uint128_hash(value v)
{
  uint128 x = Uint128_val(v);
  return (x.high ^ x.low);
}

static void
uint128_serialize(value v, uintnat *wsize_32, uintnat *wsize_64)
{
  caml_failwith("unimplemented");
}

static uintnat
uint128_deserialize(void *dst)
{
  caml_failwith("unimplemented");
  return 16;
}

struct custom_operations uint128_ops = {
  "stdint.int128",
  custom_finalize_default,
  uint128_cmp,
  uint128_hash,
  uint128_serialize,
  uint128_deserialize
};

CAMLprim value
copy_uint128(uint128 i)
{
  CAMLparam0();
  value res = caml_alloc_custom(&uint128_ops, 16, 0, 1);
  Uint128_val(res) = i;
  CAMLreturn (res);
}

CAMLprim value
uint128_add(value a, value b)
{
  CAMLparam2(a, b);
  uint128 res, x, y;

  x = Uint128_val(a);
  y = Uint128_val(b);
  res.low = x.low + y.low;
  res.high = x.high + y.high;
  if (res.low < x.low) {
    res.high++;
  }
  CAMLreturn (copy_uint128(res));
}

CAMLprim value
uint128_sub(value a, value b)
{
  CAMLparam2(a, b);
  uint128 x, y;

  x = Uint128_val(a);
  y = Uint128_val(b);
  sub(&x, &y);
  CAMLreturn (copy_uint128(x));
}

CAMLprim value
uint128_and(value a, value b)
{
  CAMLparam2(a, b);
  uint128 x, y;

  x = Uint128_val(a);
  y = Uint128_val(b);
  and(&x, &y);

  CAMLreturn (copy_uint128(x));
}

CAMLprim value
uint128_or(value a, value b)
{
  CAMLparam2(a, b);
  uint128 x, y;

  x = Uint128_val(a);
  y = Uint128_val(b);
  or(&x, &y);

  CAMLreturn (copy_uint128(x));
}

CAMLprim value
uint128_xor(value a, value b)
{
  CAMLparam2(a, b);
  uint128 x, y, res;

  x = Uint128_val(a);
  y = Uint128_val(b);
  res.low = x.low ^ y.low;
  res.high = x.high ^ y.high;

  CAMLreturn (copy_uint128(res));
}

CAMLprim value
uint128_shift_left(value a, value i)
{
  CAMLparam2(a, i);
  uint128 x;
  int s = Int_val(i);
  x = Uint128_val(a);

  shift_left(&x, s);

  CAMLreturn (copy_uint128(x));
}

CAMLprim value
uint128_shift_right(value a, value i)
{
  CAMLparam2(a, i);
  uint128 x;
  int s = Int_val(i);
  x = Uint128_val(a);

  shift_right(&x, s);

  CAMLreturn (copy_uint128(x));
}

#endif

// common operations that work for both implementations

CAMLprim value
uint128_max_int(void)
{
    CAMLparam0();
    CAMLreturn (copy_uint128(uint128_max));
}

CAMLprim value
uint128_init_custom_ops(void)
{
    CAMLparam0();
    caml_register_custom_operations(&uint128_ops);
    CAMLreturn (Val_unit);
}

