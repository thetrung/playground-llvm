declare i32 @malloc(i64)
declare void @free(ptr)
declare void @printf(i8*, ...)
@format = private constant [13 x i8] c"\x: %d @ $%d\0a"         ;private const @format "\x: ..."

; func main () return i8 
define i8 @main() {
entry:
  ; base = malloc (2,i64)
  %size = mul i64 2, 1                                          ; mul 2 1      in size as i64
  %base = call ptr @malloc(i64 %size)                           ; @malloc size in base
  br label %body

body:
  ; fmt = gep(@format, i32, i32);
  %format_ptr = getelementptr [1 x i8], ptr @format, i32 0, i32 1; gep @format { i32 i32 } as fmt

  ; base[0] = 42
  %buf = getelementptr i8, ptr %base, i64 0                      ; gep base 0 as buf
  store i32 42, ptr %buf                                         ; store 42   in &buf 
  %v = load i32, ptr %buf                                        ; load &buf  in v

  ; printf (&fmt, &base[0], base[0])
  call i32 (i8*, ...) @printf(i8* %format_ptr, i32 %v, ptr %buf) ; call @printf with &fmt v &buf

  ; base[1] = 40
  %buf2 = getelementptr i8, ptr %base, i64 1                     ; gep base 1 as buf2
  store i32 40, ptr %buf2                                        ; store 40   in &buf2
  %m = load i32, ptr %buf2                                       ; load buf2  in m

  ; printf (&fmt, &base[1], base[1])
  call i32 (i8*, ...) @printf(i8* %format_ptr, i32 %m, ptr %buf2); call @printf with &fmt m &buf2

  ; free (&base)
  call void @free(ptr %base)                                     ; call @free with &base

  ; no error 
  ret i8 0                                 ; ret 0
}
