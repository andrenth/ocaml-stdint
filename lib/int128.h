#ifndef OCAML_INT128_H
#define OCAML_INT128_H

#if defined(__SIZEOF_INT128__) 

#define HAVE_INT128
typedef __int128_t int128;
typedef struct { int64_t high; uint64_t low; } int128_ocaml;

inline __int128_t get_int128(value v)
{
  int128_ocaml *i = (int128_ocaml *)Data_custom_val(v);
  return ((__int128_t)i->high << 64 | i->low);
}

#define Int128_val(v) get_int128(v)

#else

typedef struct { int64_t high; uint64_t low; } int128;

#define Int128_val(v) (*((int128 *)Data_custom_val(v)))

#endif

CAMLextern value copy_int128(int128 i);

#endif
