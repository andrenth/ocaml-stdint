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
nativeint_of_int8(value v)
{
  CAMLparam1(v);
  CAMLreturn (caml_copy_nativeint((int)Int8_val(v)));
}

CAMLprim value
nativeint_of_int16(value v)
{
  CAMLparam1(v);
  CAMLreturn (caml_copy_nativeint((int)Int16_val(v)));
}

CAMLprim value
nativeint_of_int24(value v)
{
  CAMLparam1(v);
  CAMLreturn (caml_copy_nativeint((int)Int24_val(v)));
}

CAMLprim value
nativeint_of_int32(value v)
{
  CAMLparam1(v);
  CAMLreturn (caml_copy_nativeint((int)Int32_val(v)));
}

CAMLprim value
nativeint_of_int40(value v)
{
  CAMLparam1(v);
  CAMLreturn (caml_copy_nativeint((int)Int40_val(v)));
}

CAMLprim value
nativeint_of_int48(value v)
{
  CAMLparam1(v);
  CAMLreturn (caml_copy_nativeint((int)Int48_val(v)));
}

CAMLprim value
nativeint_of_int56(value v)
{
  CAMLparam1(v);
  CAMLreturn (caml_copy_nativeint((int)Int56_val(v)));
}

CAMLprim value
nativeint_of_int64(value v)
{
  CAMLparam1(v);
  CAMLreturn (caml_copy_nativeint((int)Int64_val(v)));
}

CAMLprim value
nativeint_of_int128(value v)
{
  CAMLparam1(v);
  CAMLreturn (caml_copy_nativeint((int)Int128_val(v)));
}

CAMLprim value
nativeint_of_uint8(value v)
{
  CAMLparam1(v);
  CAMLreturn (caml_copy_nativeint((int)Uint8_val(v)));
}

CAMLprim value
nativeint_of_uint16(value v)
{
  CAMLparam1(v);
  CAMLreturn (caml_copy_nativeint((int)Uint16_val(v)));
}

CAMLprim value
nativeint_of_uint24(value v)
{
  CAMLparam1(v);
  CAMLreturn (caml_copy_nativeint((int)Uint24_val(v)));
}

CAMLprim value
nativeint_of_uint32(value v)
{
  CAMLparam1(v);
  CAMLreturn (caml_copy_nativeint((int)Uint32_val(v)));
}

CAMLprim value
nativeint_of_uint40(value v)
{
  CAMLparam1(v);
  CAMLreturn (caml_copy_nativeint((int)Uint40_val(v)));
}

CAMLprim value
nativeint_of_uint48(value v)
{
  CAMLparam1(v);
  CAMLreturn (caml_copy_nativeint((int)Uint48_val(v)));
}

CAMLprim value
nativeint_of_uint56(value v)
{
  CAMLparam1(v);
  CAMLreturn (caml_copy_nativeint((int)Uint56_val(v)));
}

CAMLprim value
nativeint_of_uint64(value v)
{
  CAMLparam1(v);
  CAMLreturn (caml_copy_nativeint((int)Uint64_val(v)));
}

CAMLprim value
nativeint_of_uint128(value v)
{
  CAMLparam1(v);
  CAMLreturn (caml_copy_nativeint((int)Uint128_val(v)));
}

