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
#include "int128.h"
#include "uint8.h"
#include "uint16.h"
#include "uint24.h"
#include "uint32.h"
#include "uint56.h"
#include "uint64.h"
#include "uint128.h"

CAMLprim value
uint128_of_int(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint128((__uint128_t)Int_val(v)));
}

CAMLprim value
uint128_of_nativeint(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint128((__uint128_t)Nativeint_val(v)));
}

CAMLprim value
uint128_of_float(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint128((__uint128_t)Double_val(v)));
}

CAMLprim value
uint128_of_int8(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint128((__uint128_t)Int8_val(v)));
}

CAMLprim value
uint128_of_int16(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint128((__uint128_t)Int16_val(v)));
}

CAMLprim value
uint128_of_int32(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint128((__uint128_t)Int32_val(v)));
}

CAMLprim value
uint128_of_int64(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint128((__uint128_t)Int64_val(v)));
}

CAMLprim value
uint128_of_int128(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint128((__uint128_t)Int128_val(v)));
}

CAMLprim value
uint128_of_uint8(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint128((__uint128_t)Uint8_val(v)));
}

CAMLprim value
uint128_of_uint16(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint128((__uint128_t)Uint16_val(v)));
}

CAMLprim value
uint128_of_uint24(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint128((__uint128_t)Uint24_val(v)));
}

CAMLprim value
uint128_of_uint32(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint128((__uint128_t)Uint32_val(v)));
}

CAMLprim value
uint128_of_uint56(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint128((__uint128_t)Uint56_val(v)));
}

CAMLprim value
uint128_of_uint64(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint128((__uint128_t)Uint64_val(v)));
}

