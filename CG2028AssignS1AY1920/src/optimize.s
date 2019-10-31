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

	@optimise(a, b, (int) xi)
	PUSH {R3 - R6}
	LDR R6, LAMBDA @ Load R6 with value of LAMBDA scaled by 1000 defined below

GOTO_START_OF_LOOP:
	LSL R3, R0, #1 @Multiply 2*a
    MLA R4, R3, R2, R1 @ Update R4 (fp value) with (R3(2a) x R2(Xi) ) + R1(b)

    SDIV R4, R6 @ Divide R4 with R6 and reuse R4 for storage (change = lambda * fp) because lambda is < 1

    SUB R3, R2, R4 @Rd, Rn, Op2    0000_00_0_0100_0_0010_0011_0000000_0_0100

    CMP R3, R2 @Check if xprev (R2) and x (R3) are the same
	BEQ STR_ANS_TIME @Checks if (Z == 1 zero flag is on), then exit loop and go to register containing instruction to store out final value.
    MOV R2, R3 @Moves the value of R3 into R2 to update a new value of xprev
    BNE GOTO_START_OF_LOOP @Checks if (Z != 0), repeat loop


STR_ANS_TIME:
	MOV R0, R3 @Moves the value of R3 into R0 to be returned
	POP {R3 - R6}
 	BX	LR

@ Define constant values
LAMBDA: .word 10
