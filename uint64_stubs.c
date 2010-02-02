#include <stdio.h>
#include <string.h>
#include <stdint.h>

#include <caml/custom.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

#define Uint64_val(v) (*((uint64_t *)Data_custom_val(v)))

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

struct custom_operations uint64_ops = {
    "_u64",
    custom_finalize_default,
    uint64_cmp,
    uint64_hash,
    uint64_serialize,
    uint64_deserialize
};

CAMLprim value
copy_uint64(uint64_t i)
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
    uint64_t divisor = Uint64_val(v2);
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
uint64_of_int32(value v)
{
    return copy_uint64((unsigned long)Int32_val(v));
}

CAMLprim value
uint64_to_int(value v)
{
    return Val_long(Uint64_val(v));
}

CAMLprim value
uint64_to_int32(value v)
{
    return caml_copy_int32(Uint64_val(v));
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
uint64_compare(value v1, value v2)
{
    uint64_t i1 = Uint64_val(v1);
    uint64_t i2 = Uint64_val(v2);
    return Val_int((i1 > i2) - (i1 < i2));
}

CAMLprim value
uint64_bits_of_float(value vd)
{
    union { float d; uint64_t i; } u;
    u.d = Double_val(vd);
    return copy_uint64(u.i);
}

CAMLprim value
uint64_float_of_bits(value vi)
{
    union { float d; uint64_t i; } u;
    u.i = Uint64_val(vi);
    return caml_copy_double(u.d);
}

CAMLprim value
uint64_max_int(value dummy)
{
    return copy_uint64(UINT64_MAX);
}

static char *
parse_sign_and_base(char *p, /*out*/ int *base)
{
    if (*p == '-')
        caml_failwith("Uint64.of_string");
    *base = 10;
    if (*p == '0') {
        switch (p[1]) {
        case 'x':
        case 'X':
            *base = 16;
            p += 2;
            break;
        case 'o':
        case 'O':
            *base = 8;
            p += 2;
            break;
        case 'b':
        case 'B':
            *base = 2;
            p += 2;
            break;
        }
    }
    return p;
}

static int
parse_digit(char c)
{
    if (c >= '0' && c <= '9')
        return c - '0';
    else if (c >= 'A' && c <= 'F')
        return c - 'A' + 10;
    else if (c >= 'a' && c <= 'f')
        return c - 'a' + 10;
    else
        return -1;
}

CAMLprim value
uint64_of_string(value s)
{
    char * p;
    uint64_t max_uint64 = UINT64_MAX;
    uint64_t max_int64  = INT64_MAX;
    uint64_t res, threshold;
    int base, d;

    p = parse_sign_and_base(String_val(s), &base);
    threshold = max_uint64 / (uint64_t)base;
    res = max_uint64 % (uint64_t)base;
    d = parse_digit(*p);
    if (d < 0 || d >= base)
        caml_failwith("Uint64.of_string");
    res = (uint64_t)d;
    for (p++; /*nothing*/; p++) {
        char c = *p;
        if (c == '_')
            continue;
        d = parse_digit(c);
        if (d < 0 || d >= base)
            break;
        /* Detect overflow in multiplication base * res */
        if (threshold < res)
            caml_failwith("int_of_string");
        res = (uint64_t)base * (uint64_t)res + (uint64_t)d;
        /* Detect overflow in addition (base * res) + d */
        if (res < (uint64_t)d)
            caml_failwith("Uint64.of_string");
    }
    if (p != String_val(s) + caml_string_length(s))
        caml_failwith("Uint64.of_string");
    if (base == 10 && max_int64 < res)
        caml_failwith("Uint64.of_string");
    return caml_copy_int64(res);
}

#define FORMAT_BUFFER_SIZE 32

static char *
parse_format(value fmt, char *suffix, char format_string[],
             char default_format_buffer[], char *conv)
{
    int prec;
    char *p;
    char lastletter;
    mlsize_t len, len_suffix;

    /* Copy Caml format fmt to format_string,
       adding the suffix before the last letter of the format */
    len = caml_string_length(fmt);
    len_suffix = strlen(suffix);
    if (len + len_suffix + 1 >= FORMAT_BUFFER_SIZE)
        caml_invalid_argument("format_uint: format too long");
    memmove(format_string, String_val(fmt), len);
    p = format_string + len - 1;
    lastletter = *p;
    /* Compress two-letter formats, ignoring the [lnL] annotation */
    if (p[-1] == 'l' || p[-1] == 'n' || p[-1] == 'L') p--;
    memmove(p, suffix, len_suffix);  p += len_suffix;
    *p++ = lastletter;
    *p = 0;
    /* Determine space needed for result and allocate it dynamically if needed */
    prec = 22 + 5; /* 22 digits for 64-bit number in octal + 5 extra */
    for (p = String_val(fmt); *p != 0; p++) {
        if (*p >= '0' && *p <= '9') {
            prec = atoi(p) + 5;
            break;
        }
    }
    *conv = lastletter;
    if (prec < FORMAT_BUFFER_SIZE)
        return default_format_buffer;
    else
        return caml_stat_alloc(prec + 1);
}

CAMLprim value
uint64_format(value fmt, value arg)
{
    char format_string[FORMAT_BUFFER_SIZE];
    char default_format_buffer[FORMAT_BUFFER_SIZE];
    char *buffer;
    char conv;
    value res;

    buffer = parse_format(fmt, ARCH_INT64_PRINTF_FORMAT,
                          format_string, default_format_buffer, &conv);
    sprintf(buffer, format_string, Uint64_val(arg));
    res = caml_copy_string(buffer);
    if (buffer != default_format_buffer)
        caml_stat_free(buffer);
    return res;
}

CAMLprim value
uint64_to_int64(value x)
{
    return copy_int64(Int64_val(x));
}
