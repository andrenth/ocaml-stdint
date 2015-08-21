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
uint24_of_int(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint32(((uint32_t)Int_val(v)) << 8));
}

CAMLprim value
uint24_of_nativeint(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint32(((uint32_t)Nativeint_val(v)) << 8));
}

CAMLprim value
uint24_of_float(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint32(((uint32_t)Double_val(v)) << 8));
}

CAMLprim value
uint24_of_int8(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint32(((uint32_t)Int8_val(v)) << 8));
}

CAMLprim value
uint24_of_int16(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint32(((uint32_t)Int16_val(v)) << 8));
}

CAMLprim value
uint24_of_int24(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint32(((uint32_t)Int24_val(v)) << 8));
}

CAMLprim value
uint24_of_int32(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint32(((uint32_t)Int32_val(v)) << 8));
}

CAMLprim value
uint24_of_int40(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint32(((uint32_t)Int40_val(v)) << 8));
}

CAMLprim value
uint24_of_int48(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint32(((uint32_t)Int48_val(v)) << 8));
}

CAMLprim value
uint24_of_int56(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint32(((uint32_t)Int56_val(v)) << 8));
}

CAMLprim value
uint24_of_int64(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint32(((uint32_t)Int64_val(v)) << 8));
}

CAMLprim value
uint24_of_int128(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint32(((uint32_t)Int128_val(v)) << 8));
}

CAMLprim value
uint24_of_uint8(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint32(((uint32_t)Uint8_val(v)) << 8));
}

CAMLprim value
uint24_of_uint16(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint32(((uint32_t)Uint16_val(v)) << 8));
}

CAMLprim value
uint24_of_uint32(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint32(((uint32_t)Uint32_val(v)) << 8));
}

CAMLprim value
uint24_of_uint40(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint32(((uint32_t)Uint40_val(v)) << 8));
}

CAMLprim value
uint24_of_uint48(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint32(((uint32_t)Uint48_val(v)) << 8));
}

CAMLprim value
uint24_of_uint56(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint32(((uint32_t)Uint56_val(v)) << 8));
}

CAMLprim value
uint24_of_uint64(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint32(((uint32_t)Uint64_val(v)) << 8));
}

CAMLprim value
uint24_of_uint128(value v)
{
  CAMLparam1(v);
  CAMLreturn (copy_uint32(((uint32_t)Uint128_val(v)) << 8));
}

