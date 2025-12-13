%Particle = type {
    float,  ; x
    float,  ; y
    float   ; z
}

declare ptr @malloc(i64)
declare void @free(ptr)

define ptr @particles_create(i64 %count) {
entry:
; size_of(type) ?
  %elem_size = ptrtoint ptr getelementptr(%Particle, ptr null, i32 1) to i64

; total mem-size need to malloc 
  %total = mul i64 %elem_size, %count
  %mem = call ptr @malloc(i64 %total)

; cast (mem, Particle)
  %arr = bitcast ptr %mem to %Particle*
  ret ptr %arr
}

define void @set_x(ptr %arr, i64 %i, float %v) {
entry:
  %p = getelementptr %Particle, ptr %arr, i64 %i
  %x = getelementptr %Particle, ptr %p, i32 0, i32 0
  store float %v, ptr %x
  ret void
}

define void @update(ptr %arr, i64 %count, float %dt) {
entry:
  br label %loop

loop:
  %i = phi i64 [0, %entry], [%i1, %loop]

  %p  = getelementptr %Particle, ptr %arr, i64 %i
  %x  = getelementptr %Particle, ptr %p, i32 0, i32 0
  %y  = getelementptr %Particle, ptr %p, i32 0, i32 1
  %z  = getelementptr %Particle, ptr %p, i32 0, i32 2

  %xv = load float, ptr %x
  %nv = fadd float %xv, %dt
  store float %nv, ptr %x

  %i1 = add i64 %i, 1
  %cond = icmp ult i64 %i1, %count
  br i1 %cond, label %loop, label %exit

exit:
  ret void
}

define void @particles_destroy(ptr %arr) {
entry:
  call void @free(ptr %arr)
  ret void
}

define i8 @main () {
    ;;
    ;; TODO: make example here.
    ;;
    ret i8 0
}