#ifndef OCAML_INT128_H
#define OCAML_INT128_H

#if defined(__SIZEOF_INT128__)
#define HAVE_INT128
typedef __int128_t int128;
#else
typedef struct { int64_t high; uint64_t low; } int128;
#endif

#define next_aligned(p) (void *)((((intptr_t)p)+8) & ~15ULL)

#define Int128_val(v) (*((int128 *)next_aligned(Data_custom_val(v))))

CAMLextern value copy_int128(int128 i);

#endif
