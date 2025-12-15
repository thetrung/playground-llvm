# playground LLVM
because it's like ASM on steroids x free cross-platform compiling.

### Intro
This is more like fragments of features I want in my own language for decades. But I only really understand Assembly in recent years as I dig deeper into VM and FASM.

### Build & Run

      make

### Region-based Language
Although there are already a lot of nice language like Odin/Jai &  OCAML -- which seem to be very close to what I want but there is still a gap between them : some is fast but still lack/verbase features while the other is solid ML but GC-based and thus slower than native C/LLVM.

I want design new language - which is as simple as Lua but as fast as C while portable like LLVM :


        type Vec3     { double x, y, z }
        type Vec3_SoA { i64 count, double *x, *y, *z }
        
        main :: (void) -> i8 {
                                                        ;; new memory context is setup
            data   = {}                                 ;; @malloc [i64 x 3]
            data.x = 42                                 ;; as int32
            data.y = 3.14                               ;; as double
            data.fmt = "integer : %d -- double : %f \n" ;; as string (memcpy)
            call printf (fmt, data.x, data.y)           ;; this is still pre-allocated.

            if data[0] == data.x then printf ("same way to access value") end
            
            ;; Or Array-like struct
            ;; %Array = type {
            ;;  ptr, i64    ; data, length
            ;; }
            ;;
            data = { 0, 1.15, "Hello" }      ;; same @malloc like above.
                                             ;; data[0] = 0; data[1] = 1.15 ... etc
            v1 = Vec3 { 1.0, 0.0, 1.0 }      ;; struct with alloca
            v2 = Vec3 { 3.0, 0.0, 1.0 }      ;; struct with alloca
            call printf ("vector: { %d, %d, %d }", v1)  ;; auto-match arg types

            v3 = v1 + v2                            ;; same matching
            call printf ("v1 + v2 = { %d, %d, %d }", v3)

            ;; SoA
            size = 24
            v4 = Vec3_SoA { size, new [size], new [size], new [size]}

            return 0
            ;; Auto-free the context memory.
        }

Since there are infinite possibilities that I don't want to lose the fun of being creative for me & people if they want to do something with their expensive memory :

        // flat struct (AoS)
        particles : [Particle]

        // columnar (SoA)
        particles : SoA[Particle]

        // heterogeneous
        values : [ptr Value]
