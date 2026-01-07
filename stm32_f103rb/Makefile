default: startup blink linker prog clean

startup:
	clang -target armv7m-none-eabi -mcpu=cortex-m3 -mthumb \
  	-ffreestanding -nostdlib -c startup.ll -o startup.o 

blink:
	clang -target armv7m-none-eabi -mcpu=cortex-m3 -mthumb \
  	-ffreestanding -nostdlib -c blink.ll -o blink.o

linker:
	clang -target armv7m-none-eabi -mcpu=cortex-m3 -mthumb \
  	-nostdlib \
    -fuse-ld=lld \
  	-Wl,-T,stm32f103.ld \
  	-Wl,--gc-sections \
  	startup.o blink.o \
  	-o firmware.elf

prog:
	openocd \
  -f interface/stlink.cfg \
  -f target/stm32f1x.cfg \
  -c "program firmware.elf verify reset exit"

clean:
	rm firmware.elf
	rm *.o
