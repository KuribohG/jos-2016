#include <inc/memlayout.h>

.section ".text.boot"
.globl _start

_start:
.globl entry
entry:
    ldr r4, = edata
    ldr r9, = end
    mov r5, #0
    mov r6, #0
    mov r7, #0
    mov r8, #0
    b check

zero:
    stmia r4!, {r5-r8}

check:
    cmp r4, r9
    blo zero
    ldr r0, = (entry_pgdir - KERNBASE)
    mcr p15, 0, r0, c2, c0, 0
    mov r0, #0xFFFFFFFF
    mcr p15, 0, r0, c3, c0, 0
    mrc p15, 0, r0, c1, c0, 0
    orr r0, r0, #0x1
    mcr p15, 0, r0, c1, c0, 0
    ldr lr, = relocated
    bx lr

relocated:
    ldr sp, = bootstacktop
    bl arm_init

halt:
    wfe
    b halt

.data
    .p2align 20
    .globl bootstack

bootstack:
    .space 0x8000
    .globl bootstacktop

bootstacktop:
