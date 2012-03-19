all:
	@#ocaml setup.ml -build -classic-display
	ocaml setup.ml -build

configure:
	ocaml setup.ml -configure

install:
	ocaml setup.ml -install

clean:
	ocaml setup.ml -clean

doc:
	ocaml setup.ml -doc
