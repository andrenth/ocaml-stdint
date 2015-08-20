#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include <caml/alloc.h>
#include <caml/custom.h>
#include <caml/fail.h>
#include <caml/intext.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

#include "int8.h"

static int
int8_cmp(value v1, value v2)
{
  int8_t i1 = Int8_val(v1);
  int8_t i2 = Int8_val(v2);
  return (i1 > i2) - (i1 < i2);
}

static intnat
int8_hash(value v)
{
  return Int8_val(v);
}

static void
int8_serialize(value v, uintnat *wsize_32, uintnat *wsize_64)
{
  caml_serialize_int_1(Int8_val(v));
  *wsize_32 = *wsize_64 = 1;
}

static uintnat
int8_deserialize(void *dst)
{
  *((int8_t *) dst) = caml_deserialize_sint_1();
  return 1;
}

struct custom_operations int8_ops = {
  "uint.int8",
  custom_finalize_default,
  int8_cmp,
  int8_hash,
  int8_serialize,
  int8_deserialize
};

CAMLprim value
copy_int8(int8_t i)
{
    CAMLparam0();
    value res = caml_alloc_custom(&int8_ops, 1, 0, 1);
    Int8_val(res) = i;
    CAMLreturn (res);
}

CAMLprim value
int8_add(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_int8(Int8_val(v1) + Int8_val(v2)));
}

CAMLprim value
int8_sub(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_int8(Int8_val(v1) - Int8_val(v2)));
}

CAMLprim value
int8_mul(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_int8(Int8_val(v1) * Int8_val(v2)));
}

CAMLprim value
int8_div(value v1, value v2)
{
    CAMLparam2(v1, v2);
    int8_t divisor = Int8_val(v2);
    if (divisor == 0)
        caml_raise_zero_divide();
    CAMLreturn (copy_int8(Int8_val(v1) / divisor));
}

CAMLprim value
int8_mod(value v1, value v2)
{
    CAMLparam2(v1, v2);
    int8_t divisor = Int8_val(v2);
    if (divisor == 0)
        caml_raise_zero_divide();
    CAMLreturn (copy_int8(Int8_val(v1) % divisor));
}

CAMLprim value
int8_and(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_int8(Int8_val(v1) & Int8_val(v2)));
}

CAMLprim value
int8_or(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_int8(Int8_val(v1) | Int8_val(v2)));
}

CAMLprim value
int8_xor(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_int8(Int8_val(v1) ^ Int8_val(v2)));
}

CAMLprim value
int8_shift_left(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_int8(Int8_val(v1) << Int_val(v2)));
}

CAMLprim value
int8_shift_right(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_int8(Int8_val(v1) >> Int_val(v2)));
}

CAMLprim value
int8_abs(value v)
{
    CAMLparam1(v);
    CAMLreturn (copy_int8(abs(Int8_val(v))));
}

CAMLprim value
int8_bits_of_float(value v)
{
    CAMLparam1(v);
    union { float d; int8_t i; } u;
    u.d = Double_val(v);
    CAMLreturn (copy_int8(u.i));
}

CAMLprim value
int8_float_of_bits(value v)
{
    CAMLparam1(v);
    union { float d; int8_t i; } u;
    u.i = Int8_val(v);
    CAMLreturn (caml_copy_double(u.d));
}

CAMLprim value
int8_max_int(void)
{
    CAMLparam0();
    CAMLreturn (copy_int8(INT8_MAX));
}

CAMLprim value
int8_min_int(void)
{
    CAMLparam0();
    CAMLreturn (copy_int8(INT8_MIN));
}

CAMLprim value
int8_init_custom_ops(void)
{
    CAMLparam0();
    caml_register_custom_operations(&int8_ops);
    CAMLreturn (Val_unit);
}

