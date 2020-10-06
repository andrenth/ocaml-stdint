#include <stdint.h>
#include <string.h>

#include <caml/alloc.h>
#include <caml/custom.h>
#include <caml/fail.h>
#include <caml/intext.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

#include "int48.h"

static const int64_t mask = 0xFFFFFFFFFFFF0000LL;

CAMLprim value
int48_mul(value v1, value v2)
{
  CAMLparam2(v1, v2);
  CAMLreturn (copy_int48(Int48_val(v1) * Int64_val(v2)));
}

CAMLprim value
int48_div(value v1, value v2)
{
  CAMLparam2(v1, v2);
  int64_t divisor = Int64_val(v2);
  if (divisor == 0)
    caml_raise_zero_divide();
  CAMLreturn (copy_int48((Int64_val(v1) / divisor) << 16));
}

CAMLprim value
int48_shift_right(value v1, value v2)
{
  CAMLparam2(v1, v2);
  CAMLreturn (copy_int48((Int64_val(v1) >> Long_val(v2)) & mask));
}

CAMLprim value
int48_max_int(void)
{
  CAMLparam0();
  CAMLreturn (copy_int48(INT64_MAX & mask));
}

CAMLprim value
int48_min_int(void)
{
  CAMLparam0();
  CAMLreturn (copy_int48(INT64_MIN & mask));
}

