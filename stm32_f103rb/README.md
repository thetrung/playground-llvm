Blink in LLVM / STM32F103RB
=============================
A fully working blink demo in llvm-ir (thumbv7m) for only 160 bytes. To put this under perspective : PICAS version was 68 bytes in blink, 168 bytes in UART. But `ARM 32-bit` has fixed instruction length so it is double in size by default (which mean ~80 bytes in term of `PIC 8-bit ASM`). I actually feel 8-bit PIC was still way simpler with its toolchains that allow bare-metal programming at ease. STM32 with pure llvm-ir still need a lot of work around startup & linker to map Ram/Flash & Entry correctly beside the Makefile toolchain pipeline. 

### Build & Run
* require llvm/lld 21+ to run properly.
  
- default test build/debug :

      make

- Test/Run (raw .BIN) :

      make run

### Size differences
- firmware.ELF = 65K for its debug-info.
- firmware.BIN = 160B for stripped binary.

![alt](https://github.com/thetrung/playground-llvm/blob/main/stm32_f103rb/preview.png)
