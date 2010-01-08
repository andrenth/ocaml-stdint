export OCAMLMAKEFILE = OCamlMakefile
export LIBINSTALL_FILES=$(wildcard *.mli *.cmi *.cma *.cmx *.cmxa *.a *.so)

define PROJ_uint32
	SOURCES=uint32_stubs.c uint32.mli uint32.ml
	RESULT=uint32
endef

define PROJ_uint64
	SOURCES=uint64_stubs.c uint64.mli uint64.ml
	RESULT=uint64
endef

ifndef SUBPROJS
  export SUBPROJS = uint32 uint64
endif

export PROJ_uint32 PROJ_uint64

all: byte-code-library native-code-library

install: all
	@printf "\nInstalling library with ocamlfind\n"
	@ocamlfind install uint META $(LIBINSTALL_FILES)
	@printf "\nInstallation successful.\n"

uninstall:
	@printf "\nUninstalling library with ocamlfind\n"
	@ocamlfind remove uint
	@printf "\nUninstallation successful.\n"

%:
	make -f $(OCAMLMAKEFILE) subprojs SUBTARGET=$@
