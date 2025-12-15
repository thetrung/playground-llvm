define arch_flag
	$(if $(filter x86_64,$(shell uname -m)),-no-pie)
endef

define compile
	@echo $1:
	@llc $1.mlir -o ./build/$1.o -filetype=obj && clang $(call arch_flag) ./build/$1.o -o ./build/$1 && ./build/$1
	@echo 
endef

.PHONY: default build
default: clean build list
mkdir:
	@mkdir ./build
list:
	@ls -lh ./build
clean_o:
	@rm -rf ./build/*.o
clean:
	@rm -rf ./build

build: mkdir alloca malloc struct union AoS clean_o

alloca: alloca.mlir
	$(call compile,alloca)

malloc: malloc.mlir
	$(call compile,malloc)

struct: struct.mlir
	$(call compile,struct)

union: union.mlir
	$(call compile,union)

AoS: AoS.mlir
	$(call compile,AoS)

