#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include <caml/alloc.h>
#include <caml/custom.h>
#include <caml/fail.h>
#include <caml/intext.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>
#include <caml/version.h>

#include "uint64.h"

static int
uint64_cmp(value v1, value v2)
{
    uint64_t i1 = Uint64_val(v1);
    uint64_t i2 = Uint64_val(v2);
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
    *((uint64_t *) dst) = caml_deserialize_uint_8();
    return 8;
}

#if OCAML_VERSION_MAJOR > 4 || OCAML_VERSION_MAJOR == 4 && OCAML_VERSION_MINOR >= 8
static const struct custom_fixed_length uint64_length = { 8, 8 };
#endif

struct custom_operations uint64_ops = {
    "uint.uint64",
    custom_finalize_default,
    uint64_cmp,
    uint64_hash,
    uint64_serialize,
    uint64_deserialize,
    custom_compare_ext_default
#if OCAML_VERSION_MAJOR > 4 || OCAML_VERSION_MAJOR == 4 && OCAML_VERSION_MINOR >= 8
  , &uint64_length
#endif
};

CAMLprim value
copy_uint64(uint64_t i)
{
    CAMLparam0();
    value res = caml_alloc_custom(&uint64_ops, 8, 0, 1);
    Uint64_val(res) = i;
    CAMLreturn (res);
}

CAMLprim value
uint64_add(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint64(Uint64_val(v1) + Uint64_val(v2)));
}

CAMLprim value
uint64_sub(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint64(Uint64_val(v1) - Uint64_val(v2)));
}

CAMLprim value
uint64_mul(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint64(Uint64_val(v1) * Uint64_val(v2)));
}

CAMLprim value
uint64_div(value v1, value v2)
{
    CAMLparam2(v1, v2);
    uint64_t divisor = Uint64_val(v2);
    if (divisor == 0)
        caml_raise_zero_divide();
    CAMLreturn (copy_uint64(Uint64_val(v1) / divisor));
}

CAMLprim value
uint64_mod(value v1, value v2)
{
    CAMLparam2(v1, v2);
    uint64_t divisor = Uint64_val(v2);
    if (divisor == 0)
        caml_raise_zero_divide();
    CAMLreturn (copy_uint64(Uint64_val(v1) % divisor));
}

CAMLprim value
uint64_and(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint64(Uint64_val(v1) & Uint64_val(v2)));
}

CAMLprim value
uint64_or(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint64(Uint64_val(v1) | Uint64_val(v2)));
}

CAMLprim value
uint64_xor(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint64(Uint64_val(v1) ^ Uint64_val(v2)));
}

CAMLprim value
uint64_shift_left(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint64(Uint64_val(v1) << Long_val(v2)));
}

CAMLprim value
uint64_shift_right(value v1, value v2)
{
    CAMLparam2(v1, v2);
    CAMLreturn (copy_uint64(Uint64_val(v1) >> Long_val(v2)));
}

CAMLprim value
uint64_bits_of_float(value v)
{
    CAMLparam1(v);
    union { double d; uint64_t i; uint32_t h[2]; } u;
    u.d = Double_val(v);
    CAMLreturn (copy_uint64(u.i));
}

CAMLprim value
uint64_float_of_bits(value v)
{
    CAMLparam1(v);
    union { double d; uint64_t i; uint32_t h[2]; } u;
    u.i = Uint64_val(v);
    CAMLreturn (caml_copy_double(u.d));
}

CAMLprim value
uint64_neg(value v)
{
    CAMLparam1(v);
    CAMLreturn (copy_uint64(UINT64_MAX - Uint64_val(v) + 1));
}

CAMLprim value
uint64_max_int(void)
{
    CAMLparam0();
    CAMLreturn (copy_uint64(UINT64_MAX));
}

CAMLprim value
uint64_init_custom_ops(void)
{
    CAMLparam0();
    caml_register_custom_operations(&uint64_ops);
    CAMLreturn (Val_unit);
}
