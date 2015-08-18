#ifndef OCAML_INT128_H
#define OCAML_INT128_H

#define Int128_val(v) (*((__int128_t *)Data_custom_val(v)))

CAMLextern value copy_int128(__int128_t i);

#endif
