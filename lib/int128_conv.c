#include <assert.h>
#include <stdint.h>
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
#include "int24.h"
#include "int40.h"
#include "int48.h"
#include "int56.h"
#include "int128.h"
#include "uint8.h"
#include "uint16.h"
#include "uint24.h"
#include "uint32.h"
#include "uint40.h"
#include "uint48.h"
#include "uint56.h"
#include "uint64.h"
#include "uint128.h"

CAMLprim value
int128_of_int(value v)
{
  CAMLparam1(v);
#ifdef HAVE_INT128
  CAMLreturn (copy_int128((__int128_t)Long_val(v)));
#else
  int128 x = { .high = 0, .low = Long_val(v) };
  CAMLreturn(copy_int128(x));
#endif
}

CAMLprim value
int128_of_nativeint(value v)
{
  CAMLparam1(v);
#ifdef HAVE_INT128
  CAMLreturn (copy_int128((__int128_t)Nativeint_val(v)));
#else
  int128 x = { .high = 0, .low = Nativeint_val(v) };
  CAMLreturn(copy_int128(x));
#endif
}

CAMLprim value
int128_of_float(value v)
{
  CAMLparam1(v);
#ifdef HAVE_INT128
  CAMLreturn (copy_int128((__int128_t)Double_val(v)));
#else
  caml_failwith(__func__);
  CAMLreturn(Val_unit);
#endif
}

CAMLprim value
int128_of_int8(value v)
{
  CAMLparam1(v);
#ifdef HAVE_INT128
  CAMLreturn (copy_int128((__int128_t)Int8_val(v)));
#else
  int128 x = { .high = 0, .low = Int8_val(v) };
  CAMLreturn(copy_int128(x));
#endif
}

CAMLprim value
int128_of_int16(value v)
{
  CAMLparam1(v);
#ifdef HAVE_INT128
  CAMLreturn (copy_int128((__int128_t)Int16_val(v)));
#else
  int128 x = { .high = 0, .low = Int16_val(v) };
  CAMLreturn(copy_int128(x));
#endif
}

CAMLprim value
int128_of_int24(value v)
{
  CAMLparam1(v);
#ifdef HAVE_INT128
  CAMLreturn (copy_int128((__int128_t)Int24_val(v)));
#else
  int128 x = { .high = 0, .low = Int24_val(v) };
  CAMLreturn(copy_int128(x));
#endif
}

CAMLprim value
int128_of_int32(value v)
{
  CAMLparam1(v);
#ifdef HAVE_INT128
  CAMLreturn (copy_int128((__int128_t)Int32_val(v)));
#else
  int128 x = { .high = 0, .low = Int32_val(v) };
  CAMLreturn(copy_int128(x));
#endif
}

CAMLprim value
int128_of_int40(value v)
{
  CAMLparam1(v);
#ifdef HAVE_INT128
  CAMLreturn (copy_int128((__int128_t)Int40_val(v)));
#else
  int128 x = { .high = 0, .low = Int40_val(v) };
  CAMLreturn(copy_int128(x));
#endif
}

CAMLprim value
int128_of_int48(value v)
{
  CAMLparam1(v);
#ifdef HAVE_INT128
  CAMLreturn (copy_int128((__int128_t)Int48_val(v)));
#else
  int128 x = { .high = 0, .low = Int48_val(v) };
  CAMLreturn(copy_int128(x));
#endif
}

CAMLprim value
int128_of_int56(value v)
{
  CAMLparam1(v);
#ifdef HAVE_INT128
  CAMLreturn (copy_int128((__int128_t)Int56_val(v)));
#else
  int128 x = { .high = 0, .low = Int56_val(v) };
  CAMLreturn(copy_int128(x));
#endif
}

CAMLprim value
int128_of_int64(value v)
{
  CAMLparam1(v);
#ifdef HAVE_INT128
  CAMLreturn (copy_int128((__int128_t)Int64_val(v)));
#else
  int128 x = { .high = 0, .low = Int64_val(v) };
  CAMLreturn(copy_int128(x));
#endif
}

CAMLprim value
int128_of_uint8(value v)
{
  CAMLparam1(v);
#ifdef HAVE_INT128
  CAMLreturn (copy_int128((__int128_t)Uint8_val(v)));
#else
  int128 x = { .high = 0, .low = Uint8_val(v) };
  CAMLreturn(copy_int128(x));
#endif
}

CAMLprim value
int128_of_uint16(value v)
{
  CAMLparam1(v);
#ifdef HAVE_INT128
  CAMLreturn (copy_int128((__int128_t)Uint16_val(v)));
#else
  int128 x = { .high = 0, .low = Uint16_val(v) };
  CAMLreturn(copy_int128(x));
#endif
}

CAMLprim value
int128_of_uint24(value v)
{
  CAMLparam1(v);
#ifdef HAVE_INT128
  CAMLreturn (copy_int128((__int128_t)Uint24_val(v)));
#else
  int128 x = { .high = 0, .low = Uint24_val(v) };
  CAMLreturn(copy_int128(x));
#endif
}

CAMLprim value
int128_of_uint32(value v)
{
  CAMLparam1(v);
#ifdef HAVE_INT128
  CAMLreturn (copy_int128((__int128_t)Uint32_val(v)));
#else
  int128 x = { .high = 0, .low = Uint32_val(v) };
  CAMLreturn(copy_int128(x));
#endif
}

CAMLprim value
int128_of_uint40(value v)
{
  CAMLparam1(v);
#ifdef HAVE_INT128
  CAMLreturn (copy_int128((__int128_t)Uint40_val(v)));
#else
  int128 x = { .high = 0, .low = Uint40_val(v) };
  CAMLreturn(copy_int128(x));
#endif
}

CAMLprim value
int128_of_uint48(value v)
{
  CAMLparam1(v);
#ifdef HAVE_INT128
  CAMLreturn (copy_int128((__int128_t)Uint48_val(v)));
#else
  int128 x = { .high = 0, .low = Uint48_val(v) };
  CAMLreturn(copy_int128(x));
#endif
}

CAMLprim value
int128_of_uint56(value v)
{
  CAMLparam1(v);
#ifdef HAVE_INT128
  CAMLreturn (copy_int128((__int128_t)Uint56_val(v)));
#else
  int128 x = { .high = 0, .low = Uint56_val(v) };
  CAMLreturn(copy_int128(x));
#endif
}

CAMLprim value
int128_of_uint64(value v)
{
  CAMLparam1(v);
#ifdef HAVE_INT128
  CAMLreturn (copy_int128((__int128_t)Uint64_val(v)));
#else
  int128 x = { .high = 0, .low = Uint64_val(v) };
  CAMLreturn(copy_int128(x));
#endif
}

CAMLprim value
int128_of_uint128(value v)
{
  CAMLparam1(v);
#if defined(HAVE_INT128) && defined(HAVE_UINT128)
  CAMLreturn (copy_int128((__int128_t)Uint128_val(v)));
#else
  uint128 x = Uint128_val(v);
  int128 y = { .high = x.high, .low = x.low };
  CAMLreturn(copy_int128(y));
#endif
}

