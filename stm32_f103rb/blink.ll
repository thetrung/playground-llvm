
target triple = "thumbv7m-unknown-none-eabi"

define void @main() {
entry:
  ; Enable GPIOA clock (bit 2)
  %rcc = inttoptr i32 u0x40021018 to ptr   ; RCC_APB2ENR = u0x40021018
  %v   = load volatile i32, ptr %rcc       ;
  %v2  = or i32 %v, 4                      ; | (1 << 2)
  store volatile i32 %v2, ptr %rcc         ;

  ; PA5 output push-pull, 2 MHz
  %crl = inttoptr i32 u0x40010800 to ptr   ; GPIOA_CRL = u0x40010800
  %cv  = load volatile i32, ptr %crl       ;
  %mask = and i32 %cv, u0xFF0FFFFF         ; clear bits [23:20]
  %cfg  = or i32 %mask, u0x00200000        ; MODE=10, CNF=00
  store volatile i32 %cfg, ptr %crl   ; pin 5 config = GPIOA_CRL & ~(0xF << 20) | (0x2 << 20) 

  br label %loop

loop:
  ; LED ON (PA5 HIGH)
  %bsrr = inttoptr i32 u0x40010810 to ptr ; GPIOA_BSRR = u0x40010810
  store volatile i32 32, ptr %bsrr        ; set PA5 (1 << 5)
  call void @delay()

  ; LED OFF
  store volatile i32 2097152, ptr %bsrr   ; reset PA5 (1 << 21)
  call void @delay()

  br label %loop
}

define void @delay() {
entry:
  %c = alloca i32, align 4
  store i32 200000, ptr %c
  br label %d

d:
  %v = load i32, ptr %c
  %z = icmp eq i32 %v, 0
  br i1 %z, label %end, label %dec

dec:
  %v2 = sub i32 %v, 1
  store i32 %v2, ptr %c
  br label %d

end:
  ret void
}
