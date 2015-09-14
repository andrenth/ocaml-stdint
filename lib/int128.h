#ifndef OCAML_INT128_H
#define OCAML_INT128_H

#if defined(__SIZEOF_INT128__) 
typedef __int128_t int128;
#else
typedef struct { uint64_t high; uint64_t low; } int128;
#endif

#define Int128_val(v) (*((int128 *)Data_custom_val(v)))

CAMLextern value copy_int128(int128 i);

#endif
