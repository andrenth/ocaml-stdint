#include <stdint.h>
#include <string.h>

#include <caml/alloc.h>
#include <caml/custom.h>
#include <caml/fail.h>
#include <caml/intext.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

#include "int40.h"

static const int64_t mask = 0xFFFFFFFFFF000000LL;

CAMLprim value
int40_mul(value v1, value v2)
{
  CAMLparam2(v1, v2);
  CAMLreturn (copy_int40(Int40_val(v1) * Int64_val(v2)));
}

CAMLprim value
int40_div(value v1, value v2)
{
  CAMLparam2(v1, v2);
  int64_t divisor = Int64_val(v2);
  if (divisor == 0)
    caml_raise_zero_divide();
  CAMLreturn (copy_int40((Int64_val(v1) / divisor) << 24));
}

CAMLprim value
int40_shift_right(value v1, value v2)
{
  CAMLparam2(v1, v2);
  CAMLreturn (copy_int40((Int64_val(v1) >> Long_val(v2)) & mask));
}

CAMLprim value
int40_max_int(void)
{
  CAMLparam0();
  CAMLreturn (copy_int40(INT64_MAX & mask));
}

CAMLprim value
int40_min_int(void)
{
  CAMLparam0();
  CAMLreturn (copy_int40(INT64_MIN & mask));
}

