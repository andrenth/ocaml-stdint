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

#include "uint128.h"
#include "int128.h"

#ifndef HAVE_INT128
void divmod128(int128 *d, int128 *modulus, int128 *quotient, int128 *rem);

static inline int32_t compare(int128 *x, int128 *y) {
  uint64_t z = x->high - y->high;
  if (0 != z) {
    return z >> 32;
  }
  return (x->low - y->low) >> 32;
}

static inline void neg(int128 *x) {
  uint64_t n;
  x->high ^= UINT64_MAX;
  x->low ^= UINT64_MAX;
  n = x->low;
  x->low += 1;
  if (x->low < n) {
    x->high++;
  }
}

static inline void divmod(int128 *x, int128 *divisor, int128 *res, int128 *remainder) {
  assert(0 != divisor->high);
  assert(0 != divisor->low);

  if (x->high < 0) {
    neg(x);
    if (divisor->high < 0) {
      neg(divisor);
      divmod128(x, divisor, res, remainder);
    } else {
      divmod128(x, divisor, res, remainder);
      neg(res);
    }
  } else {
    if (divisor->high < 0) {
      neg(divisor);
      divmod128(x, divisor, res, remainder);
      neg(res);
    } else {
      divmod128(x, divisor, res, remainder);
    }
  }
}
#endif

static int
int128_cmp(value v1, value v2)
{
#ifdef HAVE_INT128
  __int128_t i1 = Int128_val(v1);
  __int128_t i2 = Int128_val(v2);
  return (i1 > i2) - (i1 < i2);
#else
  int128 x = Int128_val(v1);
  int128 y = Int128_val(v2);

  return compare(&x, &y);
#endif
}

static intnat
int128_hash(value v)
{
#ifdef HAVE_INT128
  __int128_t x = Int128_val(v);
  uint32_t b0 = (uint32_t) x,
           b1 = (uint32_t) (x >> 32U),
           b2 = (uint32_t) (x >> 64U),
           b3 = (uint32_t) (x >> 96U);
#else
  int128 x = Int128_val(v);
  uint32_t b0 = (uint32_t) x.low,
           b1 = (uint32_t) (x.low >> 32U),
           b2 = (uint32_t) x.high,
           b3 = (uint32_t) (x.high >> 32U);
#endif
  return b0 ^ b1 ^ b2 ^ b3;
}

static void
int128_serialize(value v, uintnat *wsize_32, uintnat *wsize_64)
{
#ifdef HAVE_INT128
  __int128_t i = Int128_val(v);
  int64_t hi = i >> 64;
  int64_t lo = i;
#else
  int128 i = Int128_val(v);
  int64_t hi = i.high;
  int64_t lo = i.low;
#endif
  /* Serializing in big-endian order as other integer values */
  caml_serialize_int_8(hi);
  caml_serialize_int_8(lo);
  *wsize_32 = *wsize_64 = 16;
}

static uintnat
int128_deserialize(void *dst)
{
  int64_t hi = caml_deserialize_sint_8();
  uint64_t lo = caml_deserialize_uint_8();
#ifdef HAVE_INT128
  __int128_t v = ((__int128_t)hi << 64) | lo;
#else
  int128 v;
  v.high = hi;
  v.low = lo;
#endif
  memcpy(dst, &v, sizeof(v));
  return 16;
}

struct custom_operations int128_ops = {
  "stdint.int128",
  custom_finalize_default,
  int128_cmp,
  int128_hash,
  int128_serialize,
  int128_deserialize
};

CAMLprim value
copy_int128(int128 i)
{
  CAMLparam0();
  value res = caml_alloc_custom(&int128_ops, 16, 0, 1);
  Int128_val(res) = i;
  CAMLreturn (res);
}

CAMLprim value
int128_add(value v1, value v2)
{
  return suint128_add(v1, v2, (CAMLprim value (*)(uint128))copy_int128);
}

CAMLprim value
int128_sub(value v1, value v2)
{
  return suint128_sub(v1, v2, (CAMLprim value (*)(uint128))copy_int128);
}

CAMLprim value
int128_mul(value v1, value v2)
{
  return suint128_mul(v1, v2, (CAMLprim value (*)(uint128))copy_int128);
}

CAMLprim value
int128_div(value v1, value v2)
{
  CAMLparam2(v1, v2);
#ifdef HAVE_INT128
  __int128_t divisor = Int128_val(v2);

  if (divisor == 0)
    caml_raise_zero_divide();
  CAMLreturn (copy_int128(Int128_val(v1) / divisor));
#else
  int128 x, divisor, res, remainder;

  x = Int128_val(v1);
  divisor = Int128_val(v2);

  if ((0 == divisor.high) && (0 == divisor.low))
    caml_raise_zero_divide();

  divmod(&x, &divisor, &res, &remainder);

  CAMLreturn(copy_int128(res));
#endif
}

CAMLprim value
int128_mod(value v1, value v2)
{
  CAMLparam2(v1, v2);
#ifdef HAVE_INT128
  __int128_t divisor = Int128_val(v2);
  if (divisor == 0)
    caml_raise_zero_divide();
  CAMLreturn (copy_int128(Int128_val(v1) % divisor));
#else
  int128 x, divisor, res, remainder;

  x = Int128_val(v1);
  divisor = Int128_val(v2);

  if ((0 == divisor.high) && (0 == divisor.low))
    caml_raise_zero_divide();

  divmod(&x, &divisor, &res, &remainder);

  CAMLreturn(copy_int128(remainder));
#endif
}

CAMLprim value
int128_and(value v1, value v2)
{
  return suint128_and(v1, v2, (CAMLprim value (*)(uint128))copy_int128);
}

CAMLprim value
int128_or(value v1, value v2)
{
  return suint128_or(v1, v2, (CAMLprim value (*)(uint128))copy_int128);
}

CAMLprim value
int128_xor(value v1, value v2)
{
  return suint128_xor(v1, v2, (CAMLprim value (*)(uint128))copy_int128);
}

CAMLprim value
int128_shift_left(value v1, value v2)
{
  return suint128_shift_left(v1, v2, (CAMLprim value (*)(uint128))copy_int128);
}

CAMLprim value
int128_shift_right(value v1, value v2)
{
  CAMLparam2(v1, v2);
#ifdef HAVE_INT128
  CAMLreturn (copy_int128(Int128_val(v1) >> Long_val(v2)));
#else
  int128 x = Int128_val(v1);
  long s = Long_val(v2);

  if (0 == s) {
    // nothing
  } else if (s < 64) {
    x.low = (x.high << (64 - s)) | (x.low >> s);
    x.high = x.high >> s;
  } else {
    x.low = x.high >> (s - 64);
    if (x.high < 0) {
      x.high = UINT64_MAX;
    } else {
      x.high = 0;
    }
  }

  CAMLreturn(copy_int128(x));
#endif
}

CAMLprim value
int128_bits_of_float(value v)
{
  CAMLparam1(v);
#ifdef HAVE_INT128
  union { float d; __int128_t i; } u;
  u.d = Double_val(v);
  CAMLreturn (copy_int128(u.i));
#else
  caml_failwith("unimplemented");
  CAMLreturn(Val_unit);
#endif
}

CAMLprim value
int128_float_of_bits(value v)
{
  CAMLparam1(v);
#ifdef HAVE_INT128
  union { float d; __int128_t i; } u;
  u.i = Int128_val(v);
  CAMLreturn(caml_copy_double(u.d));
#else
  caml_failwith("unimplemented");
  CAMLreturn(Val_unit);
#endif
}

#ifdef HAVE_INT128
static const __uint128_t int128_max = (((__uint128_t) INT64_MAX) << 64) | ((__uint128_t) UINT64_MAX);
static const __uint128_t int128_min = ((__uint128_t) 1) << 127;
#else
static const int128 int128_max = { .high = INT64_MAX, .low = UINT64_MAX };
static const int128 int128_min = { .high = INT64_MIN, .low = 0 };
#endif

CAMLprim value
int128_max_int(void)
{
  CAMLparam0();
  CAMLreturn(copy_int128(int128_max));
}

CAMLprim value
int128_min_int(void)
{
  CAMLparam0();
  CAMLreturn(copy_int128(int128_min));
}

CAMLprim value
int128_neg(value v)
{
  CAMLparam1(v);
#ifdef HAVE_INT128
  __int128_t x = -1 * Int128_val(v);
  CAMLreturn(copy_int128(x));
#else
  int128 x = Int128_val(v);
  neg(&x);
  CAMLreturn(copy_int128(x));
#endif
}

CAMLprim value
int128_abs(value v)
{
  CAMLparam1(v);
#ifdef HAVE_INT128
  __int128_t x = Int128_val(v);
  x = x < 0 ? (-x) : x;
  CAMLreturn(copy_int128(x));
#else
  int128 x = Int128_val(v);
  
  if (x.high < 0)
    neg(&x);

  CAMLreturn(copy_int128(x));
#endif
}

CAMLprim value
int128_init_custom_ops(void)
{
  CAMLparam0();
  caml_register_custom_operations(&int128_ops);
  CAMLreturn (Val_unit);
}

