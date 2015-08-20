#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include <caml/alloc.h>
#include <caml/custom.h>
#include <caml/fail.h>
#include <caml/intext.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

#include "uint16.h"

static int
uint16_cmp(value v1, value v2)
{
    uint16_t i1 = Uint16_val(v1);
    uint16_t i2 = Uint16_val(v2);
    return (i1 > i2) - (i1 < i2);
}

static intnat
uint16_hash(value v)
{
    return Uint16_val(v);
}

static void
uint16_serialize(value v, uintnat *wsize_32, uintnat *wsize_64)
{
    caml_serialize_int_2(Uint16_val(v));
    *wsize_32 = *wsize_64 = 2;
}

static uintnat
uint16_deserialize(void *dst)
{
    *((uint16_t *) dst) = caml_deserialize_uint_2();
    return 2;
}

struct custom_operations uint16_ops = {
    "uint.uint16",
    custom_finalize_default,
    uint16_cmp,
    uint16_hash,
    uint16_serialize,
    uint16_deserialize
};

CAMLprim value
copy_uint16(uint16_t i)
{
    CAMLparam0();
    value res = caml_alloc_custom(&uint16_ops, 2, 0, 1);
    Uint16_val(res) = i;
    CAMLreturn (res);
}

CAMLprim value
uint16_add(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint16(Uint16_val(v1) + Uint16_val(v2)));
}

CAMLprim value
uint16_sub(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint16(Uint16_val(v1) - Uint16_val(v2)));
}

CAMLprim value
uint16_mul(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint16(Uint16_val(v1) * Uint16_val(v2)));
}

CAMLprim value
uint16_div(value v1, value v2)
{
    CAMLparam2(v1, v2);
    uint16_t divisor = Uint16_val(v2);
    if (divisor == 0)
        caml_raise_zero_divide();
    CAMLreturn (copy_uint16(Uint16_val(v1) / divisor));
}

CAMLprim value
uint16_mod(value v1, value v2)
{
    CAMLparam2(v1, v2);
    uint16_t divisor = Uint16_val(v2);
    if (divisor == 0)
        caml_raise_zero_divide();
    CAMLreturn (copy_uint16(Uint16_val(v1) % divisor));
}

CAMLprim value
uint16_and(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint16(Uint16_val(v1) & Uint16_val(v2)));
}

CAMLprim value
uint16_or(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint16(Uint16_val(v1) | Uint16_val(v2)));
}

CAMLprim value
uint16_xor(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint16(Uint16_val(v1) ^ Uint16_val(v2)));
}

CAMLprim value
uint16_shift_left(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint16(Uint16_val(v1) << Int_val(v2)));
}

CAMLprim value
uint16_shift_right(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint16(Uint16_val(v1) >> Int_val(v2)));
}

CAMLprim value
uint16_bits_of_float(value v)
{
    CAMLparam1(v);
    union { float d; uint16_t i; } u;
    u.d = Double_val(v);
    CAMLreturn (copy_uint16(u.i));
}

CAMLprim value
uint16_float_of_bits(value v)
{
    CAMLparam1(v);
    union { float d; uint16_t i; } u;
    u.i = Uint16_val(v);
    CAMLreturn (caml_copy_double(u.d));
}

CAMLprim value
uint16_max_int(void)
{
    CAMLparam0();
    CAMLreturn (copy_uint16(UINT16_MAX));
}

CAMLprim value
uint16_init_custom_ops(void)
{
    CAMLparam0();
    caml_register_custom_operations(&uint16_ops);
    CAMLreturn (Val_unit);
}
