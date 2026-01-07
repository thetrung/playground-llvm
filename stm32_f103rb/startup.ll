
; =========================
; STM32F103RB startup.ll
; clang-21 / opaque pointers
; =========================

target triple = "thumbv7m-unknown-none-eabi"

@stack_top = external global i32

; --- Vector table ---
@vectors = global [2 x i32] [
  i32 ptrtoint (ptr @stack_top to i32),
  i32 ptrtoint (ptr @reset_handler to i32)
], section ".isr_vector", align 4

; --- Reset handler ---
define void @reset_handler() noreturn {
entry:
  call void @main()
  br label %hang

hang:
  br label %hang
}

declare void @main()
