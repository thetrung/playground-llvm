default: build prog

build:
	clang -target armv7m-none-eabi -mcpu=cortex-m3 -mthumb \
  	-ffreestanding -nostdlib -c startup.ll -o startup.o 
	clang -target armv7m-none-eabi -mcpu=cortex-m3 -mthumb \
  	-ffreestanding -nostdlib -c main.ll -o main.o
	clang \
    -fuse-ld=lld \
    -target armv7m-none-eabi \
    -mcpu=cortex-m3 \
  	-mthumb \
  	-nostdlib \
  	-Wl,-T,stm32f103.ld \
  	-Wl,--gc-sections \
  	startup.o main.o \
  	-o firmware.elf

prog:
	openocd \
  -f interface/stlink.cfg \
  -f target/stm32f1x.cfg \
  -c "program firmware.elf verify reset exit"

clean:
	rm firmware.elf
	rm *.o
