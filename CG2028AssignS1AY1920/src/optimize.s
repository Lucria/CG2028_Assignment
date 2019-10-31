 	.syntax unified
 	.cpu cortex-m3
 	.thumb
 	.align 2
 	.global	optimize
 	.thumb_func
@  EE2024 Assignment 1 skeleton
@  CK Tham, ECE, NUS
optimize:
@  Write optimization function in assembly language here
@  Currently, nothing is done and this function returns straightaway

	@optimise(a, b, (int) xi, &iterations)
	PUSH {R4 - R7}
	LDR R6, LAMBDA @ Load R6 with value of LAMBDA scaled by 1000 defined below
	LSL R0, #1 @Multiply 2*a
	LDR R7, [R3]

	GOTO_START_OF_LOOP:
	    ADD R7, #1

	    MLA R4, R0, R2, R1 @ Update R4 (fp value) with (R3(2a) x R2(Xi) ) + R1(b)
	    SDIV R4, R6 @ Divide R4 with R6 and reuse R4 for storage (change = lambda * fp) because lambda is < 1
	    SUB R5, R2, R4 @Rd, Rn, Op2    0000_00_0_0100_0_0010_0011_0000000_0_0100
	    CMP R5, R2 @Check if xprev (R2) and x (R3) are the same
	    MOV R2, R5 @Moves the value of R3 into R2 to update a new value of xprev
	    BNE GOTO_START_OF_LOOP @Checks if (Z != 0), repeat loop

	MOV R0, R5 @Moves the value of R3 into R0 to be returned
	STR R7, [R3]
	POP {R4 - R7}
 	BX	LR

@ Define constant values
LAMBDA: .word 10
