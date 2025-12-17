; union NUMBER {
;   int x,
;   double y    
;}
%int_or_double = type { [8 x i8 ]};; 4 bytes of int || 8 bytes of double
; printf 
declare void @printf(i8*, ...)
; fmt
@fmt1 = private constant [58 x i8] c"\NUMBER { int x, double y } => x:NUMBER=%d || y:NUMBER=%f\0a"

; main ()
define i8 @main () {

; p = NUMBER(42) 
%p = alloca %int_or_double
%x = bitcast ptr %p to i32*
store i32 42,        ptr %x
%value_x = load i32, ptr %x

; p2 = NUMBER(3.14)
; NOTE: float 3.0 is ok but 3.14 need double.
%p2 = alloca %int_or_double
%y = bitcast ptr %p2 to double*
store double 3.14     , ptr %y
%value_y = load double, ptr %y

; printf int(0) -- double(1)
%ptr_fmt1 = getelementptr [1 x i8], ptr @fmt1, i32 0, i32 1
call i32 (i8*, ...) @printf(i8* %ptr_fmt1, i32 %value_x, double %value_y)

; return 0
    ret i8 0
}
