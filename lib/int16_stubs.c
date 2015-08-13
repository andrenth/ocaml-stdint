#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include <caml/alloc.h>
#include <caml/custom.h>
#include <caml/fail.h>
#include <caml/intext.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

#include "int16.h"

static int
int16_cmp(value v1, value v2)
{
    int16_t i1 = Int16_val(v1);
    int16_t i2 = Int16_val(v2);
    return (i1 > i2) - (i1 < i2);
}

static intnat
int16_hash(value v)
{
    return Int16_val(v);
}

static void
int16_serialize(value v, uintnat *wsize_32, uintnat *wsize_64)
{
    caml_serialize_int_2(Int16_val(v));
    *wsize_32 = *wsize_64 = 2;
}

static uintnat
int16_deserialize(void *dst)
{
    *((int16_t *) dst) = caml_deserialize_uint_2();
    return 2;
}

struct custom_operations int16_ops = {
    "uint.int16",
    custom_finalize_default,
    int16_cmp,
    int16_hash,
    int16_serialize,
    int16_deserialize
};

CAMLprim value
copy_int16(int16_t i)
{
    CAMLparam0();
    value res = caml_alloc_custom(&int16_ops, 2, 0, 1);
    Int16_val(res) = i;
    CAMLreturn (res);
}

CAMLprim value
int16_add(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_int16(Int16_val(v1) + Int16_val(v2)));
}

CAMLprim value
int16_sub(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_int16(Int16_val(v1) - Int16_val(v2)));
}

CAMLprim value
int16_mul(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_int16(Int16_val(v1) * Int16_val(v2)));
}

CAMLprim value
int16_div(value v1, value v2)
{
    CAMLparam2(v1, v2);
    uint16_t divisor = Int16_val(v2);
    if (divisor == 0)
        caml_raise_zero_divide();
    CAMLreturn (copy_int16(Int16_val(v1) / divisor));
}

CAMLprim value
int16_mod(value v1, value v2)
{
    CAMLparam2(v1, v2);
    int16_t divisor = Int16_val(v2);
    if (divisor == 0)
        caml_raise_zero_divide();
    CAMLreturn (copy_int16(Int16_val(v1) % divisor));
}

CAMLprim value
int16_and(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_int16(Int16_val(v1) & Int16_val(v2)));
}

CAMLprim value
int16_or(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_int16(Int16_val(v1) | Int16_val(v2)));
}

CAMLprim value
int16_xor(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_int16(Int16_val(v1) ^ Int16_val(v2)));
}

CAMLprim value
int16_shift_left(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_int16(Int16_val(v1) << Int_val(v2)));
}

CAMLprim value
int16_shift_right(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_int16(Int16_val(v1) >> Int_val(v2)));
}

CAMLprim value
int16_of_int(value v)
{
    CAMLparam1(v);
    CAMLreturn (copy_int16(Long_val(v)));
}

CAMLprim value
int16_to_int(value v)
{
    CAMLparam1(v);
    CAMLreturn (Val_long(Int16_val(v)));
}

CAMLprim value
int16_of_float(value v)
{
    CAMLparam1(v);
    CAMLreturn (copy_int16((int16_t)Double_val(v)));
}

CAMLprim value
int16_to_float(value v)
{
    CAMLparam1(v);
    CAMLreturn (caml_copy_double((double)Int16_val(v)));
}

CAMLprim value
int16_of_int32(value v)
{
    CAMLparam1(v);
    CAMLreturn (copy_int16((int16_t)Int32_val(v)));
}

CAMLprim value
int16_to_int32(value v)
{
    CAMLparam1(v);
    CAMLreturn (caml_copy_int32((int32_t)Int16_val(v)));
}

CAMLprim value
int16_bits_of_float(value v)
{
    CAMLparam1(v);
    union { float d; int16_t i; } u;
    u.d = Double_val(v);
    CAMLreturn (copy_int16(u.i));
}

CAMLprim value
int16_float_of_bits(value v)
{
    CAMLparam1(v);
    union { float d; int16_t i; } u;
    u.i = Int16_val(v);
    CAMLreturn (caml_copy_double(u.d));
}

CAMLprim value
int16_max_int(void)
{
    CAMLparam0();
    CAMLreturn (copy_int16(INT16_MAX));
}

CAMLprim value
int16_min_int(void)
{
    CAMLparam0();
    CAMLreturn (copy_int16(INT16_MIN));
}

CAMLprim value
int16_abs(value v)
{
    CAMLparam1(v);
    CAMLreturn (copy_int16(abs(Int16_val(v))));
}

CAMLprim value
int16_init_custom_ops(void)
{
    CAMLparam0();
    caml_register_custom_operations(&int16_ops);
    CAMLreturn (Val_unit);
}

