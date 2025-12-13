; struct Vec2 {
;   float x,
;   float y    
;}
%Vec2 = type { float, float }

; printf 
declare void @printf(i8*, ...)
; fmt
@fmt1 = private constant [21 x i8] c"\ x: y = { %f : %f }\0a"
@fmt2 = private constant [21 x i8] c"\ex:ey = { %f : %f }\0a"
@fmt3 = private constant [21 x i8] c"\vx:vy = { %f : %f }\0a"

; main ()
define i8 @main () {

; 1.In Memory: p = { 1.0, 2.0 }
    %p = alloca %Vec2
    store %Vec2 { float 1.0, float 2.0 }, ptr %p

; Access via Pointer : p.x -- p.y
    %px = getelementptr %Vec2, ptr %p, i32 0, i32 0
    %py = getelementptr %Vec2, ptr %p, i32 0, i32 1

; Load value back : &px -- &py
    %x = load float, ptr %px
    %y = load float, ptr %py

; printf float -- float
    %ptr_fmt1 = getelementptr [6 x i8], [6 x i8]* @fmt1, i32 0, i32 1
    call i32 (i8*, ...) @printf(i8* %ptr_fmt1, float %x, float %y)

; 2.Extract from Memory :
    %ep = load {float, float}, ptr %p
    %epx = extractvalue {float, float} %ep, 0
    %epy = extractvalue {float, float} %ep, 1

; printf float -- float
    %ptr_fmt2 = getelementptr [6 x i8], [6 x i8]* @fmt2, i32 0, i32 1
    call i32 (i8*, ...) @printf(i8* %ptr_fmt2, float %epx, float %epy)

; In Register : 
; insertValue 
    %v = insertvalue { float, float } undef, float 3.0, 0
    %v2 = insertvalue { float, float } %v, float 4.0, 1

; extractValue
    %vx = extractvalue { float, float } %v2, 0
    %vy = extractvalue { float, float } %v2, 1

; printf float -- float
    %ptr_fmt3 = getelementptr [6 x i8], [6 x i8]* @fmt3, i32 0, i32 1
    call i32 (i8*, ...) @printf(i8* %ptr_fmt3, float %vx, float %vy)

; return 0
    ret i8 0
}