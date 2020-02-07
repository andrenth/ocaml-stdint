.PHONY: all build check

all: build

build:
	dune build -p stdint

LIB=_build/install/default/lib/stdint/stdint.cmxa

$(LIB): build

check: tests/stdint_test
	tests/stdint_test

tests/stdint_test: $(LIB) tests/stdint_test.ml
	ocamlfind ocamlopt -I $(dir $<) -package str,qcheck $^ -linkpkg -o $@
