all:
	@#ocaml setup.ml -build -classic-display
	ocaml setup.ml -build

configure:
	ocaml setup.ml -configure

configure-dev:
	ocaml setup.ml -configure --enable-tests --enable-debug

install:
	ocaml setup.ml -install

clean:
	ocaml setup.ml -clean

doc:
	ocaml setup.ml -doc

check:
	ocaml setup.ml -test
