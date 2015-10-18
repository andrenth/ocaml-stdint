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

#ifndef HAVE_UINT128
static inline int compare(uint128 *x, uint128 *y) {
  assert(x);
  assert(y);
  x->high -= y->high;
  if (0 != x->high) {
    return x->high;
  }
  return x->low - y->low;
}

static inline void shift_left(uint128 *x, int s) {
  assert(x);
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

static inline void shift_right(uint128 *x, int s) {
  assert(x);
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

static inline void sub(uint128 *x, uint128 *y) {
  assert(x);
  assert(y);
  if (x->low < y->low) {
    x->high--;
  }
  x->low -= y->low;
  x->high -= y->high;
}

void divmod128(uint128 *d, uint128 *modulus, uint128 *quotient, uint128 *rem) {
  uint128 mask;
  int cmp;

  mask = (uint128){.high = 0, .low = 1};

  while (d->high >= 0) {
    cmp = compare(d, modulus);
    shift_left(d, 1);
    shift_left(&mask, 1);
    if (cmp >= 0) {
      break;
    }
  }
  rem = modulus;
  quotient = 0;

  while ((mask.low | mask.high) != 0) {
    if (compare(rem, d) >= 0) {
      *quotient = (uint128){.high = quotient->high | mask.high, .low = quotient->low | mask.low};
      sub(rem, d);
    }
    shift_right(&mask, 1);
    shift_right(d, 1);
  }
}

void add(uint128 *x, uint128 *y) {
  x->low += y->low;
  x->high += y->high;
  if (x->low < y->low) {
    x->high++;
  }
}
#endif

static int
uint128_cmp(value v1, value v2)
{
#ifdef HAVE_UINT128 
  __uint128_t i1 = Uint128_val(v1);
  __uint128_t i2 = Uint128_val(v2);
  return (i1 > i2) - (i1 < i2);
#else
  uint128 x = Uint128_val(v1);
  uint128 y = Uint128_val(v2);

  return compare(&x, &y);
#endif
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
  custom_hash_default,
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
uint128_add(value v1, value v2)
{
  CAMLparam2(v1, v2);
#ifdef HAVE_UINT128 
  CAMLreturn(copy_uint128(Uint128_val(v1) + Uint128_val(v2)));
#else
  uint128 x, y;

  x = Uint128_val(v1);
  y = Uint128_val(v2);

  add(&x, &y);

  CAMLreturn(copy_uint128(x));
#endif
}

CAMLprim value
uint128_sub(value v1, value v2)
{
  CAMLparam2(v1, v2);
#ifdef HAVE_UINT128 
  CAMLreturn (copy_uint128(Uint128_val(v1) - Uint128_val(v2)));
#else
  uint128 x, y;

  x = Uint128_val(v1);
  y = Uint128_val(v2);

  sub(&x, &y);

  CAMLreturn (copy_uint128(x));
#endif
}

CAMLprim value
uint128_mul(value v1, value v2)
{
  CAMLparam2(v1, v2);
#ifdef HAVE_UINT128 
  CAMLreturn (copy_uint128(Uint128_val(v1) * Uint128_val(v2)));
#else
  uint128 x, y, z;
  uint64_t p0, p1, p2, p3;

  x = Uint128_val(v1);
  y = Uint128_val(v2);

  p0 = (x.low & UINT32_MAX) * (y.low & UINT32_MAX);
  p1 = (x.low & UINT32_MAX) * (y.low >> 32);
  p2 = (x.low >> 32) * (y.low & UINT32_MAX);
  p3 = (x.low >> 32) * (y.low >> 32);
  z.low = p0;
  z.high = p3 + (p1 >> 32) + (p2 >> 32);
  p1 <<= 32;
  z.low += p1;
  if (z.low < p1) {
    z.high++;
  }
  p2 <<= 32;
  z.low += p2;
  if (z.low < p2) {
    z.high++;
  }
  z.high += x.low * y.high + x.high * y.low;

  CAMLreturn(copy_uint128(z));
#endif
}

CAMLprim value
uint128_div(value v1, value v2)
{
  CAMLparam2(v1, v2);
#ifdef HAVE_UINT128 
  __uint128_t divisor = Uint128_val(v2);

  if (divisor == 0)
    caml_raise_zero_divide();
  CAMLreturn (copy_uint128(Uint128_val(v1) / divisor));
#else
  uint128 d, modulus, rem, quotient;

  d = Uint128_val(v1);
  modulus = Uint128_val(v2);

  divmod128(&d, &modulus, &quotient, &rem);

  CAMLreturn(copy_uint128(quotient));
#endif
}

CAMLprim value
uint128_mod(value v1, value v2)
{
  CAMLparam2(v1, v2);
#ifdef HAVE_UINT128 
  __uint128_t divisor = Uint128_val(v2);
  if (divisor == 0)
    caml_raise_zero_divide();
  CAMLreturn (copy_uint128(Uint128_val(v1) % divisor));
#else
  uint128 d, modulus, rem, quotient;

  d = Uint128_val(v1);
  modulus = Uint128_val(v2);

  divmod128(&d, &modulus, &quotient, &rem);

  CAMLreturn(copy_uint128(rem));
#endif
}

CAMLprim value
uint128_and(value v1, value v2)
{
  CAMLparam2(v1, v2);
#ifdef HAVE_UINT128 
  CAMLreturn (copy_uint128(Uint128_val(v1) & Uint128_val(v2)));
#else
  uint128 x, y;

  x = Uint128_val(v1);
  y = Uint128_val(v2);
  x.high &= y.high;
  x.low &= y.low;
  CAMLreturn (copy_uint128(x));
#endif
}

CAMLprim value
uint128_or(value v1, value v2)
{
  CAMLparam2(v1, v2);
#ifdef HAVE_UINT128 
  CAMLreturn (copy_uint128(Uint128_val(v1) | Uint128_val(v2)));
#else
  uint128 x, y;

  x = Uint128_val(v1);
  y = Uint128_val(v2);
  x.high |= y.high;
  x.low |= y.low;
  CAMLreturn (copy_uint128(x));
#endif
}

CAMLprim value
uint128_xor(value v1, value v2)
{
  CAMLparam2(v1, v2);
#ifdef HAVE_UINT128 
  CAMLreturn (copy_uint128(Uint128_val(v1) ^ Uint128_val(v2)));
#else
  uint128 x, y;

  x = Uint128_val(v1);
  y = Uint128_val(v2);
  x.high ^= y.high;
  x.low ^= y.low;
  CAMLreturn (copy_uint128(x));
#endif
}

CAMLprim value
uint128_shift_left(value v1, value v2)
{
  CAMLparam2(v1, v2);
#ifdef HAVE_UINT128 
  CAMLreturn (copy_uint128(Uint128_val(v1) << Int_val(v2)));
#else
  uint128 x;
  int s;

  x = Uint128_val(v1);
  s = Int_val(v2);

  shift_left(&x, s);

  CAMLreturn (copy_uint128(x));
#endif
}

CAMLprim value
uint128_shift_right(value v1, value v2)
{
  CAMLparam2(v1, v2);
#ifdef HAVE_UINT128 
  CAMLreturn (copy_uint128(Uint128_val(v1) >> Int_val(v2)));
#else
  uint128 x;
  int s;

  x = Uint128_val(v1);
  s = Int_val(v2);

  if (0 == s) {
    // nothing
  } else if (s < 64) {
    x.low = (x.high << (64 - s)) | (x.low >> s);
    x.high = x.high >> s;
  } else {
    x.low = x.high >> (s - 64);
    x.high = 0;
  }
  CAMLreturn (copy_uint128(x));
#endif
}

CAMLprim value
uint128_bits_of_float(value v)
{
  CAMLparam1(v);
#ifdef HAVE_UINT128 
  union { float d; __uint128_t i; } u;
  u.d = Double_val(v);
  CAMLreturn (copy_uint128(u.i));
#else
  caml_failwith("unimplemented");
  CAMLreturn(Val_unit);
#endif
}

CAMLprim value
uint128_float_of_bits(value v)
{
  CAMLparam1(v);
#ifdef HAVE_UINT128 
  union { float d; __uint128_t i; } u;
  u.i = Uint128_val(v);
  CAMLreturn (caml_copy_double(u.d));
#else
  caml_failwith("unimplemented");
  CAMLreturn(Val_unit);
#endif
}

#ifdef HAVE_UINT128 
static const uint128 uint128_max = (((__uint128_t) UINT64_MAX) << 64) | ((__uint128_t) UINT64_MAX);
#else
static const uint128 uint128_max = { .high = UINT64_MAX, .low = UINT64_MAX };
#endif

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

