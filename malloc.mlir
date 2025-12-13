declare i32 @malloc(i64)
declare void @free(ptr)
declare void @printf(i8*, ...)
@format = private constant [6 x i8] c"x: %d\0a"

define i32 @main() {
entry:
  ; region enter
  %size = mul i64 1, 1
  %base = call ptr @malloc(i64 %size)
  br label %body

body:
  ; allocation inside region
  %buf = getelementptr i8, ptr %base, i64 0
  store i32 42, ptr %buf
  %v = load i32, ptr %buf

  ; printf 
  %format_ptr = getelementptr [6 x i8], [6 x i8]* @format, i32 0
  call i32 (i8*, ...) @printf(i8* %format_ptr, ptr %buf)

  ; region exit
  call void @free(ptr %base)

  %buf2 = getelementptr i8, ptr %base, i64 0
  store i32 40, ptr %buf2
  %m = load i32, ptr %buf2
  call i32 (i8*, ...) @printf(i8* %format_ptr, ptr %buf2)

  ; no error 
  ret i32 0
}
