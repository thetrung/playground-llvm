declare i32 @printf(i8*, ...)
@format = private constant [6 x i8] c"x: %d\0a"

define i32 @main() {
entry:
  %x = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 4, ptr %x)

  store i32 42, ptr %x
  %v = load i32, ptr %x

  %format_ptr = getelementptr [6 x i8], [6 x i8]* @format, i32 0
  call i32 (i8*, ...) @printf(i8* %format_ptr, i32 %v)

  call void @llvm.lifetime.end.p0(i64 4, ptr %x)

; re-printf 
  store i32 39, ptr %x
  %m = load i32, ptr %x
  call i32 (i8*, ...) @printf(i8* %format_ptr, i32 %m)

; no error
  ret i32 0
}
