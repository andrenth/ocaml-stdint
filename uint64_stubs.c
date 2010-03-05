#include <stdio.h>
#include <string.h>
#include <stdint.h>

#include <caml/custom.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

#define Uint64_val(v) (*((uint64 *)Data_custom_val(v)))

static int
uint64_cmp(value v1, value v2)
{
    uint64 i1 = Uint64_val(v1);
    uint64 i2 = Uint64_val(v2);
    return (i1 > i2) - (i1 < i2);
}

static intnat
uint64_hash(value v)
{
    return((intnat)Uint64_val(v));
}

static void
uint64_serialize(value v, uintnat *wsize_32, uintnat *wsize_64)
{
    caml_serialize_int_8(Uint64_val(v));
    *wsize_32 = *wsize_64 = 8;
}

static uintnat
uint64_deserialize(void *dst)
{
    *((uint64 *) dst) = caml_deserialize_uint_8();
    return 8;
}

struct custom_operations uint64_ops = {
    "uint.uint64",
    custom_finalize_default,
    uint64_cmp,
    uint64_hash,
    uint64_serialize,
    uint64_deserialize
};

CAMLprim value
copy_uint64(uint64 i)
{
    value res = caml_alloc_custom(&uint64_ops, 8, 0, 1);
    Uint64_val(res) = i;
    return res;
}

CAMLprim value
uint64_add(value v1, value v2)
{
    return copy_uint64(Uint64_val(v1) + Uint64_val(v2));
}

CAMLprim value
uint64_sub(value v1, value v2)
{
    return copy_uint64(Uint64_val(v1) - Uint64_val(v2));
}

CAMLprim value
uint64_mul(value v1, value v2)
{
    return copy_uint64(Uint64_val(v1) * Uint64_val(v2));
}

CAMLprim value
uint64_div(value v1, value v2)
{
    uint64 divisor = Uint64_val(v2);
    if (divisor == 0)
        caml_raise_zero_divide();
    return copy_uint64(Uint64_val(v1) / divisor);
}

CAMLprim value
uint64_mod(value v1, value v2)
{
    uint64 divisor = Uint64_val(v2);
    if (divisor == 0)
        caml_raise_zero_divide();
    return copy_uint64(Uint64_val(v1) % divisor);
}

CAMLprim value
uint64_and(value v1, value v2)
{
    return copy_uint64(Uint64_val(v1) & Uint64_val(v2));
}

CAMLprim value
uint64_or(value v1, value v2)
{
    return copy_uint64(Uint64_val(v1) | Uint64_val(v2));
}

CAMLprim value
uint64_xor(value v1, value v2)
{
    return copy_uint64(Uint64_val(v1) ^ Uint64_val(v2));
}

CAMLprim value
uint64_shift_left(value v1, value v2)
{
    return copy_uint64(Uint64_val(v1) << Int_val(v2));
}

CAMLprim value
uint64_shift_right(value v1, value v2)
{
    return copy_uint64(Uint64_val(v1) >> Int_val(v2));
}

CAMLprim value
uint64_of_int(value v)
{
    return copy_uint64(Long_val(v));
}

CAMLprim value
uint64_to_int(value v)
{
    return Val_long(Uint64_val(v));
}

CAMLprim value
uint64_of_int32(value v)
{
    return copy_uint64((uint32)Int32_val(v));
}

CAMLprim value
uint64_to_int32(value v)
{
    return caml_copy_int32(Uint64_val(v));
}

CAMLprim value
uint64_of_nativeint(value v)
{
    return copy_uint64((uint32)Nativeint_val(v));
}

CAMLprim value
uint64_to_nativeint(value v)
{
    return caml_copy_nativeint((intnat)Uint64_val(v));
}

CAMLprim value
uint64_of_int64(value v)
{
    return copy_uint64((uint64)Int64_val(v));
}

CAMLprim value
uint64_to_int64(value v)
{
    return caml_copy_int64(Uint64_val(v));
}

CAMLprim value
uint64_of_float(value v)
{
    return copy_uint64((uint64)Double_val(v));
}

CAMLprim value
uint64_to_float(value v)
{
    return caml_copy_double((double)Uint64_val(v));
}

CAMLprim value
uint64_bits_of_float(value vd)
{
    union { float d; uint64 i; } u;
    u.d = Double_val(vd);
    return copy_uint64(u.i);
}

CAMLprim value
uint64_float_of_bits(value vi)
{
    union { float d; uint64 i; } u;
    u.i = Uint64_val(vi);
    return caml_copy_double(u.d);
}

CAMLprim value
uint64_max_int(void)
{
    return copy_uint64(UINT64_MAX);
}

CAMLprim value
uint64_init_custom_ops(void)
{
    caml_register_custom_operations(&uint64_ops);
    return Val_unit;
}
