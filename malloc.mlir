declare i32 @malloc(i64)
declare void @free(ptr)
declare void @printf(i8*, ...)
@format = private constant [13 x i8] c"\x: %d @ $%d\0a"
                                            ;const fmt: string ".."

define i8 @main() {
entry:
  ; region enter                            main ::(void) -> i8 {
  %size = mul i64 2, 1; alloc [2 x i64]     ; arr: i64[2]
  %base = call ptr @malloc(i64 %size)
  br label %body

body:
  ; allocation inside region
  %buf = getelementptr i8, ptr %base, i64 0 ; mov arr[0], 42
  store i32 42, ptr %buf                    ; mov v, arr[0]
  %v = load i32, ptr %buf                   

  ; printf #1 number                         printf (&fmt, v) 
  %format_ptr = getelementptr [1 x i8], ptr @format, i32 0, i32 1
  call i32 (i8*, ...) @printf(i8* %format_ptr, i32 %v, ptr %buf)

  ; printf #2 number 
  %buf2 = getelementptr i8, ptr %base, i64 1; mov arr[1], 40
  store i32 40, ptr %buf2                   ; mov m, arr[1]
  %m = load i32, ptr %buf2                  ; printf (&fmt, m)
  call i32 (i8*, ...) @printf(i8* %format_ptr, i32 %m, ptr %buf2)

  ; region exit                             }
  call void @free(ptr %base)

  ; no error 
  ret i8 0                                 ; ret 0
}
