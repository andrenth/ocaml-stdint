#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include <caml/alloc.h>
#include <caml/custom.h>
#include <caml/fail.h>
#include <caml/intext.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

#include "uint8.h"

static int
uint8_cmp(value v1, value v2)
{
    uint8_t i1 = Uint8_val(v1);
    uint8_t i2 = Uint8_val(v2);
    return (i1 > i2) - (i1 < i2);
}

static intnat
uint8_hash(value v)
{
    return Uint8_val(v);
}

static void
uint8_serialize(value v, uintnat *wsize_32, uintnat *wsize_64)
{
    caml_serialize_int_1(Uint8_val(v));
    *wsize_32 = *wsize_64 = 1;
}

static uintnat
uint8_deserialize(void *dst)
{
    *((uint8_t *) dst) = caml_deserialize_uint_1();
    return 1;
}

struct custom_operations uint8_ops = {
    "uint.uint8",
    custom_finalize_default,
    uint8_cmp,
    uint8_hash,
    uint8_serialize,
    uint8_deserialize
};

CAMLprim value
copy_uint8(uint8_t i)
{
    CAMLparam0();
    value res = caml_alloc_custom(&uint8_ops, 1, 0, 1);
    Uint8_val(res) = i;
    CAMLreturn (res);
}

CAMLprim value
uint8_add(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint8(Uint8_val(v1) + Uint8_val(v2)));
}

CAMLprim value
uint8_sub(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint8(Uint8_val(v1) - Uint8_val(v2)));
}

CAMLprim value
uint8_mul(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint8(Uint8_val(v1) * Uint8_val(v2)));
}

CAMLprim value
uint8_div(value v1, value v2)
{
    CAMLparam2(v1, v2);
    uint8_t divisor = Uint8_val(v2);
    if (divisor == 0)
        caml_raise_zero_divide();
    CAMLreturn (copy_uint8(Uint8_val(v1) / divisor));
}

CAMLprim value
uint8_mod(value v1, value v2)
{
    CAMLparam2(v1, v2);
    uint8_t divisor = Uint8_val(v2);
    if (divisor == 0)
        caml_raise_zero_divide();
    CAMLreturn (copy_uint8(Uint8_val(v1) % divisor));
}

CAMLprim value
uint8_and(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint8(Uint8_val(v1) & Uint8_val(v2)));
}

CAMLprim value
uint8_or(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint8(Uint8_val(v1) | Uint8_val(v2)));
}

CAMLprim value
uint8_xor(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint8(Uint8_val(v1) ^ Uint8_val(v2)));
}

CAMLprim value
uint8_shift_left(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint8(Uint8_val(v1) << Int_val(v2)));
}

CAMLprim value
uint8_shift_right(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint8(Uint8_val(v1) >> Int_val(v2)));
}

CAMLprim value
uint8_bits_of_float(value v)
{
    CAMLparam1(v);
    union { float d; uint8_t i; } u;
    u.d = Double_val(v);
    CAMLreturn (copy_uint8(u.i));
}

CAMLprim value
uint8_float_of_bits(value v)
{
    CAMLparam1(v);
    union { float d; uint8_t i; } u;
    u.i = Uint8_val(v);
    CAMLreturn (caml_copy_double(u.d));
}

CAMLprim value
uint8_max_int(void)
{
    CAMLparam0();
    CAMLreturn (copy_uint8(UINT8_MAX));
}

CAMLprim value
uint8_init_custom_ops(void)
{
    CAMLparam0();
    caml_register_custom_operations(&uint8_ops);
    CAMLreturn (Val_unit);
}
