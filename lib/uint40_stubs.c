#include <stdint.h>
#include <string.h>

#include <caml/alloc.h>
#include <caml/custom.h>
#include <caml/fail.h>
#include <caml/intext.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

#include "uint40.h"

static const uint64_t mask = 0xFFFFFFFFFF000000ULL;

CAMLprim value
uint40_mul(value v1, value v2)
{
  CAMLparam2(v1, v2);
  CAMLreturn (copy_uint40(Uint40_val(v1) * Uint64_val(v2)));
}

CAMLprim value
uint40_div(value v1, value v2)
{
  CAMLparam2(v1, v2);
  uint64_t divisor = Uint64_val(v2);
  if (divisor == 0)
    caml_raise_zero_divide();
  CAMLreturn (copy_uint40((Uint64_val(v1) / divisor) << 24));
}

CAMLprim value
uint40_xor(value v1, value v2)
{
  CAMLparam2(v1, v2);
  CAMLreturn (copy_uint40((Uint64_val(v1) ^ Uint64_val(v2)) & mask));
}

CAMLprim value
uint40_shift_right(value v1, value v2)
{
  CAMLparam2(v1, v2);
  CAMLreturn (copy_uint40((Uint64_val(v1) >> Int_val(v2)) & mask));
}

CAMLprim value
uint40_max_int(void)
{
  CAMLparam0();
  CAMLreturn (copy_uint40(UINT64_MAX & mask));
}

