#include <stdint.h>
#include <string.h>

#include <caml/alloc.h>
#include <caml/custom.h>
#include <caml/fail.h>
#include <caml/intext.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

#include "uint24.h"

CAMLprim value
uint24_mul(value v1, value v2)
{
  CAMLparam2(v1, v2);
  CAMLreturn (copy_uint24(Uint24_val(v1) * Uint32_val(v2)));
}

CAMLprim value
uint24_div(value v1, value v2)
{
  CAMLparam2(v1, v2);
  uint32_t divisor = Uint32_val(v2);
  if (divisor == 0)
    caml_raise_zero_divide();
  CAMLreturn (copy_uint24((Uint32_val(v1) / divisor) << 8));
}

CAMLprim value
uint24_xor(value v1, value v2)
{
  CAMLparam2(v1, v2);
  CAMLreturn (copy_uint24((Uint32_val(v1) ^ Uint32_val(v2)) & 0xFFFFFF00));
}

CAMLprim value
uint24_shift_right(value v1, value v2)
{
  CAMLparam2(v1, v2);
  CAMLreturn (copy_uint24((Uint32_val(v1) >> Int_val(v2)) & 0xFFFFFF00));
}

static const uint24_max = UINT32_MAX & 0xFFFFFF00;
static const uint24_one = (1 << 8);

CAMLprim value
uint24_max_int(void)
{
  CAMLparam0();
  CAMLreturn (copy_uint24(uint24_max));
}

CAMLprim value
uint24_neg(value v)
{
    CAMLparam1(v);
    CAMLreturn (copy_uint32(uint24_max - Uint32_val(v) + uint24_one));
}

