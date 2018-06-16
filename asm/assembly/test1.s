// Test 1 - smallest covering test program

test1:
    clr r0
    inc s0
    shl r0, 2
    mov r0, r1
    mov r0, s1

while1:
    cmp r1, s0
    add r2, s2
    xor r0, r2
    cmp r0, r0
    bne while1
    ld  r1, r2
