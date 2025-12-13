.PHONY: default build

default: build list

list:
	ls -lh .

build: alloca malloc struct union AoS

alloca: alloca.mlir
	llc alloca.mlir -o alloca.o -filetype=obj && clang alloca.o -o alloca && ./alloca 

malloc: malloc.mlir
	llc malloc.mlir -o malloc.o -filetype=obj && clang malloc.o -o malloc && ./malloc

struct: struct.mlir
	llc struct.mlir -o struct.o -filetype=obj && clang struct.o -o struct && ./struct

union: union.mlir
	llc union.mlir -o union.o -filetype=obj && clang union.o -o union && ./union

AoS: AoS.mlir
	llc AoS.mlir -o AoS.o -filetype=obj && clang AoS.o -o AoS && ./AoS

clean:
	rm -f\
  alloca alloca.o \
  malloc malloc.o \
  struct struct.o \
  union union.o   \
  AoS AoS.o
