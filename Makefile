.PHONY: default build

default: build

build: alloca malloc

alloca: alloca.mlir
	llc alloca.mlir -o alloca.o -filetype=obj && clang alloca.o -o alloca && ./alloca 

malloc: malloc.mlir
	llc malloc.mlir -o malloc.o -filetype=obj && clang malloc.o -o malloc && ./malloc

clean:
	rm -f\
  alloca alloca.o \
  malloc malloc.o 
