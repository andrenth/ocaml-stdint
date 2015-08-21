#include <stdint.h>
#include <string.h>

#include <caml/alloc.h>
#include <caml/custom.h>
#include <caml/fail.h>
#include <caml/intext.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

#include "uint56.h"

CAMLprim value
uint56_mul(value v1, value v2)
{
  CAMLparam2(v1, v2);
  CAMLreturn (copy_uint56(Uint56_val(v1) * Uint64_val(v2)));
}

CAMLprim value
uint56_div(value v1, value v2)
{
  CAMLparam2(v1, v2);
  uint64_t divisor = Uint64_val(v2);
  if (divisor == 0)
    caml_raise_zero_divide();
  CAMLreturn (copy_uint56((Uint64_val(v1) / divisor) << 8));
}

CAMLprim value
uint56_xor(value v1, value v2)
{
  CAMLparam2(v1, v2);
  CAMLreturn (copy_uint56((Uint64_val(v1) ^ Uint64_val(v2)) & 0xFFFFFFFFFFFFFF00));
}

CAMLprim value
uint56_shift_right(value v1, value v2)
{
  CAMLparam2(v1, v2);
  CAMLreturn (copy_uint56((Uint64_val(v1) >> Int_val(v2)) & 0xFFFFFFFFFFFFFF00));
}

CAMLprim value
uint56_max_int(void)
{
  CAMLparam0();
  CAMLreturn (copy_uint56(UINT64_MAX & 0xFFFFFFFFFFFFFF00));
}

