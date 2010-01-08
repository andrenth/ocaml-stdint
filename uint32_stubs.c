#include <stdio.h>
#include <stdint.h>
#include <string.h>

#include <caml/custom.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

#define Uint32_val(v) (*((uint32 *)Data_custom_val(v)))

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
    "_u32",
    custom_finalize_default,
    uint32_cmp,
    uint32_hash,
    uint32_serialize,
    uint32_deserialize
};

CAMLprim value
copy_uint32(uint32 i)
{
    value res = caml_alloc_custom(&uint32_ops, 4, 0, 1);
    Uint32_val(res) = i;
    return res;
}

CAMLprim value
uint32_add(value v1, value v2)
{
    return copy_uint32(Uint32_val(v1) + Uint32_val(v2));
}

CAMLprim value
uint32_sub(value v1, value v2)
{
    return copy_uint32(Uint32_val(v1) - Uint32_val(v2));
}

CAMLprim value
uint32_mul(value v1, value v2)
{
    return copy_uint32(Uint32_val(v1) * Uint32_val(v2));
}

CAMLprim value
uint32_div(value v1, value v2)
{
    uint32 divisor = Uint32_val(v2);
    if (divisor == 0)
        caml_raise_zero_divide();
    return copy_uint32(Uint32_val(v1) / divisor);
}

CAMLprim value
uint32_mod(value v1, value v2)
{
    uint32 divisor = Uint32_val(v2);
    if (divisor == 0)
        caml_raise_zero_divide();
    return copy_uint32(Uint32_val(v1) % divisor);
}

CAMLprim value
uint32_and(value v1, value v2)
{
    return copy_uint32(Uint32_val(v1) & Uint32_val(v2));
}

CAMLprim value
uint32_or(value v1, value v2)
{
    return copy_uint32(Uint32_val(v1) | Uint32_val(v2));
}

CAMLprim value
uint32_xor(value v1, value v2)
{
    return copy_uint32(Uint32_val(v1) ^ Uint32_val(v2));
}

CAMLprim value
uint32_shift_left(value v1, value v2)
{
    return copy_uint32(Uint32_val(v1) << Uint32_val(v2));
}

CAMLprim value
uint32_shift_right(value v1, value v2)
{
    return copy_uint32(Uint32_val(v1) >> Uint32_val(v2));
}

CAMLprim value
uint32_of_int(value v)
{
    long l = Long_val(v);
    return copy_uint32(Long_val(v));
}

CAMLprim value
uint32_to_int(value v)
{
    return Val_long(Uint32_val(v));
}

CAMLprim value
uint32_of_float(value v)
{
    return copy_uint32((uint32)Double_val(v));
}

CAMLprim value
uint32_to_float(value v)
{
    return caml_copy_double((double)Uint32_val(v));
}

CAMLprim value
uint32_compare(value v1, value v2)
{
    uint32 i1 = Uint32_val(v1);
    uint32 i2 = Uint32_val(v2);
    return Val_int((i1 > i2) - (i1 < i2));
}

CAMLprim value
uint32_bits_of_float(value vd)
{
    union { float d; uint32 i; } u;
    u.d = Double_val(vd);
    return copy_uint32(u.i);
}

CAMLprim value
uint32_float_of_bits(value vi)
{
    union { float d; uint32 i; } u;
    u.i = Uint32_val(vi);
    return caml_copy_double(u.d);
}

CAMLprim value
uint32_max_int(value dummy)
{
    return copy_uint32(UINT32_MAX);
}

static char *
parse_sign_and_base(char *p, /*out*/ int *base)
{
    if (*p == '-')
        caml_failwith("Uint32.of_string");
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

static intnat
parse_intnat(value s, int nbits)
{
    char *p;
    uintnat res, threshold;
    int base, d;

    p = parse_sign_and_base(String_val(s), &base);
    threshold = ((uintnat) -1) / base;
    d = parse_digit(*p);
    if (d < 0 || d >= base) caml_failwith("int_of_string");
    for (p++, res = d; /*nothing*/; p++) {
        char c = *p;
        if (c == '_')
            continue;
        d = parse_digit(c);
        if (d < 0 || d >= base)
            break;
        /* Detect overflow in multiplication base * res */
        if (res > threshold)
            caml_failwith("uint_of_string");
        res = base * res + d;
        /* Detect overflow in addition (base * res) + d */
        if (res < (uintnat) d)
            caml_failwith("uint_of_string");
    }
    if (p != String_val(s) + caml_string_length(s))
        caml_failwith("uint_of_string");
    if (nbits < sizeof(uintnat) * 8 && res >= (uintnat)1 << nbits)
        caml_failwith("uint_of_string");
    return((intnat)res);
}

CAMLprim value
uint32_of_string(value s)
{
    return copy_uint32(parse_intnat(s, 32));
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
uint32_format(value fmt, value arg)
{
    char format_string[FORMAT_BUFFER_SIZE];
    char default_format_buffer[FORMAT_BUFFER_SIZE];
    char *buffer;
    char conv;
    value res;

    buffer = parse_format(fmt, ARCH_INT32_PRINTF_FORMAT,
                          format_string, default_format_buffer, &conv);
    sprintf(buffer, format_string, Uint32_val(arg));
    res = caml_copy_string(buffer);
    if (buffer != default_format_buffer)
        caml_stat_free(buffer);
    return res;
}
