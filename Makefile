.PHONY: all build check

all: build

build:
	dune build

check:
	dune runtest

opam-release:
	dune-release distrib --skip-build --skip-lint --skip-tests
# See https://github.com/ocamllabs/dune-release/issues/206
	DUNE_RELEASE_DELEGATE=github-dune-release-delegate dune-release publish distrib --verbose
	dune-release opam pkg
	dune-release opam submit
