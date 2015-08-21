#include <stdint.h>
#include <string.h>

#include <caml/alloc.h>
#include <caml/custom.h>
#include <caml/fail.h>
#include <caml/intext.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

#include "int24.h"

CAMLprim value
int24_mul(value v1, value v2)
{
  CAMLparam2(v1, v2);
  CAMLreturn (copy_int24(Int24_val(v1) * Int32_val(v2)));
}

CAMLprim value
int24_div(value v1, value v2)
{
  CAMLparam2(v1, v2);
  int32_t divisor = Int32_val(v2);
  if (divisor == 0)
    caml_raise_zero_divide();
  CAMLreturn (copy_int24((Int32_val(v1) / divisor) << 8));
}

CAMLprim value
int24_shift_right(value v1, value v2)
{
  CAMLparam2(v1, v2);
  CAMLreturn (copy_int24((Int32_val(v1) >> Int_val(v2)) & 0xFFFFFF00));
}

CAMLprim value
int24_max_int(void)
{
  CAMLparam0();
  CAMLreturn (copy_int24(INT32_MAX & 0xFFFFFF00));
}

CAMLprim value
int24_min_int(void)
{
  CAMLparam0();
  CAMLreturn (copy_int24(INT32_MIN & 0xFFFFFF00));
}

