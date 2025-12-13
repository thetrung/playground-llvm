.PHONY: default build

default: build

build: alloca malloc struct union

alloca: alloca.mlir
	llc alloca.mlir -o alloca.o -filetype=obj && clang alloca.o -o alloca && ./alloca 

malloc: malloc.mlir
	llc malloc.mlir -o malloc.o -filetype=obj && clang malloc.o -o malloc && ./malloc

struct: struct.mlir
	llc struct.mlir -o struct.o -filetype=obj && clang struct.o -o struct && ./struct

union: union.mlir
	llc union.mlir -o union.o -filetype=obj && clang union.o -o union && ./union

clean:
	rm -f\
  alloca alloca.o \
  malloc malloc.o \
  struct struct.o \
  union union.o
