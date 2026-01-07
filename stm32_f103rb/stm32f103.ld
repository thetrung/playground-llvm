
/* ============================
 * STM32F103RB – minimal linker
 * clang-21 / ld.lld
 * ============================ */

ENTRY(reset_handler)

/* --- Memory map --- */
MEMORY {
  FLASH (rx)  : ORIGIN = 0x08000000, LENGTH = 128K
  RAM   (rwx) : ORIGIN = 0x20000000, LENGTH = 20K
}

/* --- Symbols required by startup.ll --- */
_estack = ORIGIN(RAM) + LENGTH(RAM);
PROVIDE(stack_top = _estack);

/* --- Sections --- */
SECTIONS {
  /* Vector table MUST be first */
  .isr_vector ORIGIN(FLASH) : ALIGN(4) {
    KEEP(*(.isr_vector))
  } > FLASH

  /* Code */
  .text : ALIGN(4) {
    *(.text*)
    *(.rodata*)
  } > FLASH

  /* No runtime init yet → NOLOAD */
  .bss (NOLOAD) : ALIGN(4) {
    *(.bss*)
    *(COMMON)
  } > RAM
}
