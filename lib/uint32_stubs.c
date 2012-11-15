#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include <caml/alloc.h>
#include <caml/custom.h>
#include <caml/fail.h>
#include <caml/intext.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

#include "ocaml_uint32.h"

static int
uint32_cmp(value v1, value v2)
{
    uint32 i1 = Uint32_val(v1);
    uint32 i2 = Uint32_val(v2);
    return (i1 > i2) - (i1 < i2);
}

static intnat
uint32_hash(value v)
{
    return Uint32_val(v);
}

static void
uint32_serialize(value v, uintnat *wsize_32, uintnat *wsize_64)
{
    caml_serialize_int_4(Uint32_val(v));
    *wsize_32 = *wsize_64 = 4;
}

static uintnat
uint32_deserialize(void *dst)
{
    *((uint32 *) dst) = caml_deserialize_uint_4();
    return 4;
}

struct custom_operations uint32_ops = {
    "uint.uint32",
    custom_finalize_default,
    uint32_cmp,
    uint32_hash,
    uint32_serialize,
    uint32_deserialize
};

CAMLprim value
copy_uint32(uint32 i)
{
    CAMLparam0();
    value res = caml_alloc_custom(&uint32_ops, 4, 0, 1);
    Uint32_val(res) = i;
    CAMLreturn (res);
}

CAMLprim value
uint32_add(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint32(Uint32_val(v1) + Uint32_val(v2)));
}

CAMLprim value
uint32_sub(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint32(Uint32_val(v1) - Uint32_val(v2)));
}

CAMLprim value
uint32_mul(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint32(Uint32_val(v1) * Uint32_val(v2)));
}

CAMLprim value
uint32_div(value v1, value v2)
{
    CAMLparam2(v1, v2);
    uint32 divisor = Uint32_val(v2);
    if (divisor == 0)
        caml_raise_zero_divide();
    CAMLreturn (copy_uint32(Uint32_val(v1) / divisor));
}

CAMLprim value
uint32_mod(value v1, value v2)
{
    CAMLparam2(v1, v2);
    uint32 divisor = Uint32_val(v2);
    if (divisor == 0)
        caml_raise_zero_divide();
    CAMLreturn (copy_uint32(Uint32_val(v1) % divisor));
}

CAMLprim value
uint32_and(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint32(Uint32_val(v1) & Uint32_val(v2)));
}

CAMLprim value
uint32_or(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint32(Uint32_val(v1) | Uint32_val(v2)));
}

CAMLprim value
uint32_xor(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint32(Uint32_val(v1) ^ Uint32_val(v2)));
}

CAMLprim value
uint32_shift_left(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint32(Uint32_val(v1) << Int_val(v2)));
}

CAMLprim value
uint32_shift_right(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint32(Uint32_val(v1) >> Int_val(v2)));
}

CAMLprim value
uint32_of_int(value v)
{
    CAMLparam1(v);
    CAMLreturn (copy_uint32(Long_val(v)));
}

CAMLprim value
uint32_to_int(value v)
{
    CAMLparam1(v);
    CAMLreturn (Val_long(Uint32_val(v)));
}

CAMLprim value
uint32_of_float(value v)
{
    CAMLparam1(v);
    CAMLreturn (copy_uint32((uint32)Double_val(v)));
}

CAMLprim value
uint32_to_float(value v)
{
    CAMLparam1(v);
    CAMLreturn (caml_copy_double((double)Uint32_val(v)));
}

CAMLprim value
uint32_of_int32(value v)
{
    CAMLparam1(v);
    CAMLreturn (copy_uint32((uint32)Int32_val(v)));
}

CAMLprim value
uint32_to_int32(value v)
{
    CAMLparam1(v);
    CAMLreturn (caml_copy_int32((int32)Uint32_val(v)));
}

CAMLprim value
uint32_bits_of_float(value v)
{
    CAMLparam1(v);
    union { float d; uint32 i; } u;
    u.d = Double_val(v);
    CAMLreturn (copy_uint32(u.i));
}

CAMLprim value
uint32_float_of_bits(value v)
{
    CAMLparam1(v);
    union { float d; uint32 i; } u;
    u.i = Uint32_val(v);
    CAMLreturn (caml_copy_double(u.d));
}

CAMLprim value
uint32_max_int(void)
{
    CAMLparam0();
    CAMLreturn (copy_uint32(UINT32_MAX));
}

CAMLprim value
uint32_init_custom_ops(void)
{
    CAMLparam0();
    caml_register_custom_operations(&uint32_ops);
    CAMLreturn (Val_unit);
}
