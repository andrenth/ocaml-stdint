#ifndef OCAML_INT128_H
#define OCAML_INT128_H

#if defined(__SIZEOF_INT128__) 

#define HAVE_INT128
typedef __int128_t int128;
#define Int128_val(v) (*((__int128_t *)((intnat *)Data_custom_val(v) + (3 & (0 - ((uintptr_t)Data_custom_val(v) & 0x8) >> 3)))))

#else

typedef struct { int64_t high; uint64_t low; } int128;

#define Int128_val(v) (*((int128 *)Data_custom_val(v)))

#endif

CAMLextern value copy_int128(int128 i);

#endif
