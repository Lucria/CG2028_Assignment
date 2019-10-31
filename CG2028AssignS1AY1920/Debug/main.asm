   1              		.syntax unified
   2              		.cpu cortex-m3
   3              		.fpu softvfp
   4              		.eabi_attribute 20, 1
   5              		.eabi_attribute 21, 1
   6              		.eabi_attribute 23, 3
   7              		.eabi_attribute 24, 1
   8              		.eabi_attribute 25, 1
   9              		.eabi_attribute 26, 1
  10              		.eabi_attribute 30, 6
  11              		.eabi_attribute 34, 1
  12              		.eabi_attribute 18, 4
  13              		.thumb
  14              		.file	"main.c"
  15              		.text
  16              	.Ltext0:
  17              		.cfi_sections	.debug_frame
  18              		.section	.rodata
  19              		.align	2
  20              	.LC0:
  21 0000 496E6974 		.ascii	"Initial value of x (press [Enter] after keying in):"
  21      69616C20 
  21      76616C75 
  21      65206F66 
  21      20782028 
  22 0033 2000     		.ascii	" \000"
  23 0035 000000   		.align	2
  24              	.LC1:
  25 0038 256600   		.ascii	"%f\000"
  26 003b 00       		.align	2
  27              	.LC2:
  28 003c 41524D20 		.ascii	"ARM ASM & Integer version:\012\000"
  28      41534D20 
  28      2620496E 
  28      74656765 
  28      72207665 
  29              		.global	__aeabi_fmul
  30              		.global	__aeabi_f2iz
  31              		.global	__aeabi_i2f
  32              		.global	__aeabi_fdiv
  33              		.align	2
  34              	.LC3:
  35 0058 78736F6C 		.ascii	"xsol : %f , Iterations %d \012\012\000"
  35      203A2025 
  35      66202C20 
  35      49746572 
  35      6174696F 
  36              		.global	__aeabi_f2d
  37 0075 000000   		.align	2
  38              	.LC4:
  39 0078 43202620 		.ascii	"C & Floating point version:\012\000"
  39      466C6F61 
  39      74696E67 
  39      20706F69 
  39      6E742076 
  40              		.global	__aeabi_fadd
  41 0095 000000   		.align	2
  42              	.LC5:
  43 0098 783A2025 		.ascii	"x: %f, fp: %f, change: %f\012\000"
  43      662C2066 
  43      703A2025 
  43      662C2063 
  43      68616E67 
  44              		.global	__aeabi_fcmpeq
  45 00b3 00       		.section	.text.main,"ax",%progbits
  46              		.align	2
  47              		.global	main
  48              		.thumb
  49              		.thumb_func
  51              	main:
  52              	.LFB0:
  53              		.file 1 "../src/main.c"
   1:../src/main.c **** #include "stdio.h"
   2:../src/main.c **** 
   3:../src/main.c **** // CG2028 Assignment
   4:../src/main.c **** // (C) CK Tham, ECE, NUS
   5:../src/main.c **** 
   6:../src/main.c **** // Optimization routine written in assembly language
   7:../src/main.c **** // Input parameters (signed integers):
   8:../src/main.c **** //     xi : integer version of x
   9:../src/main.c **** //     a, b, c : integer coefficients of f(x)
  10:../src/main.c **** // Output : returns solution x (signed integer)
  11:../src/main.c **** extern int optimize(int a, int b, int xi, int *ptr);
  12:../src/main.c **** 
  13:../src/main.c **** int main(void)
  14:../src/main.c **** {
  54              		.loc 1 14 0
  55              		.cfi_startproc
  56              		@ args = 0, pretend = 0, frame = 56
  57              		@ frame_needed = 1, uses_anonymous_args = 0
  58 0000 2DE9904F 		push	{r4, r7, r8, r9, sl, fp, lr}
  59              	.LCFI0:
  60              		.cfi_def_cfa_offset 28
  61              		.cfi_offset 14, -4
  62              		.cfi_offset 11, -8
  63              		.cfi_offset 10, -12
  64              		.cfi_offset 9, -16
  65              		.cfi_offset 8, -20
  66              		.cfi_offset 7, -24
  67              		.cfi_offset 4, -28
  68 0004 93B0     		sub	sp, sp, #76
  69              	.LCFI1:
  70              		.cfi_def_cfa_offset 104
  71 0006 04AF     		add	r7, sp, #16
  72              	.LCFI2:
  73              		.cfi_def_cfa 7, 88
  15:../src/main.c ****     int a=3, b=4, c=-3, xsoli;
  74              		.loc 1 15 0
  75 0008 4FF00303 		mov	r3, #3
  76 000c 7B63     		str	r3, [r7, #52]
  77 000e 4FF00403 		mov	r3, #4
  78 0012 3B63     		str	r3, [r7, #48]
  79 0014 6FF00203 		mvn	r3, #2
  80 0018 FB62     		str	r3, [r7, #44]
  16:../src/main.c ****     int iterations = 0;
  81              		.loc 1 16 0
  82 001a 4FF00003 		mov	r3, #0
  83 001e 7B60     		str	r3, [r7, #4]
  17:../src/main.c **** 
  18:../src/main.c ****     float fp, x, xprev, xsol, change, lambda=0.1;
  84              		.loc 1 18 0
  85 0020 5B4B     		ldr	r3, .L7	@ float
  86 0022 BB62     		str	r3, [r7, #40]	@ float
  19:../src/main.c **** 
  20:../src/main.c ****     printf("Initial value of x (press [Enter] after keying in): "); // try x0 = -6.78
  87              		.loc 1 20 0
  88 0024 40F20003 		movw	r3, #:lower16:.LC0
  89 0028 C0F20003 		movt	r3, #:upper16:.LC0
  90 002c 1846     		mov	r0, r3
  91 002e FFF7FEFF 		bl	printf
  21:../src/main.c ****     scanf("%f", &x);
  92              		.loc 1 21 0
  93 0032 40F20003 		movw	r3, #:lower16:.LC1
  94 0036 C0F20003 		movt	r3, #:upper16:.LC1
  95 003a 3A46     		mov	r2, r7
  96 003c 1846     		mov	r0, r3
  97 003e 1146     		mov	r1, r2
  98 0040 FFF7FEFF 		bl	scanf
  22:../src/main.c **** 
  23:../src/main.c **** //  ARM ASM & Integer version
  24:../src/main.c ****     printf("ARM ASM & Integer version:\n");
  99              		.loc 1 24 0
 100 0044 40F20003 		movw	r3, #:lower16:.LC2
 101 0048 C0F20003 		movt	r3, #:upper16:.LC2
 102 004c 1846     		mov	r0, r3
 103 004e FFF7FEFF 		bl	printf
  25:../src/main.c ****     int scaledA = a;
 104              		.loc 1 25 0
 105 0052 7B6B     		ldr	r3, [r7, #52]
 106 0054 7B62     		str	r3, [r7, #36]
  26:../src/main.c ****     int scaledB = b * 10000;
 107              		.loc 1 26 0
 108 0056 3B6B     		ldr	r3, [r7, #48]
 109 0058 42F21072 		movw	r2, #10000
 110 005c 02FB03F3 		mul	r3, r2, r3
 111 0060 3B62     		str	r3, [r7, #32]
  27:../src/main.c ****     int scaledX = x * 10000;
 112              		.loc 1 27 0
 113 0062 3B68     		ldr	r3, [r7, #0]	@ float
 114 0064 1846     		mov	r0, r3
 115 0066 4B49     		ldr	r1, .L7+4	@ float
 116 0068 FFF7FEFF 		bl	__aeabi_fmul
 117 006c 0346     		mov	r3, r0
 118 006e 1846     		mov	r0, r3
 119 0070 FFF7FEFF 		bl	__aeabi_f2iz
 120 0074 0346     		mov	r3, r0
 121 0076 FB61     		str	r3, [r7, #28]
  28:../src/main.c ****     xsoli = optimize(scaledA,scaledB,(int)scaledX, &iterations);
 122              		.loc 1 28 0
 123 0078 07F10403 		add	r3, r7, #4
 124 007c 786A     		ldr	r0, [r7, #36]
 125 007e 396A     		ldr	r1, [r7, #32]
 126 0080 FA69     		ldr	r2, [r7, #28]
 127 0082 FFF7FEFF 		bl	optimize
 128 0086 0346     		mov	r3, r0
 129 0088 BB61     		str	r3, [r7, #24]
  29:../src/main.c ****     xsol = (float)xsoli / 10000;
 130              		.loc 1 29 0
 131 008a B869     		ldr	r0, [r7, #24]
 132 008c FFF7FEFF 		bl	__aeabi_i2f
 133 0090 0346     		mov	r3, r0
 134 0092 1846     		mov	r0, r3
 135 0094 3F49     		ldr	r1, .L7+4	@ float
 136 0096 FFF7FEFF 		bl	__aeabi_fdiv
 137 009a 0346     		mov	r3, r0
 138 009c 7B61     		str	r3, [r7, #20]	@ float
  30:../src/main.c ****     printf("xsol : %f , Iterations %d \n\n",xsol, iterations);
 139              		.loc 1 30 0
 140 009e 40F20004 		movw	r4, #:lower16:.LC3
 141 00a2 C0F20004 		movt	r4, #:upper16:.LC3
 142 00a6 7869     		ldr	r0, [r7, #20]	@ float
 143 00a8 FFF7FEFF 		bl	__aeabi_f2d
 144 00ac 0246     		mov	r2, r0
 145 00ae 0B46     		mov	r3, r1
 146 00b0 7968     		ldr	r1, [r7, #4]
 147 00b2 0091     		str	r1, [sp, #0]
 148 00b4 2046     		mov	r0, r4
 149 00b6 FFF7FEFF 		bl	printf
  31:../src/main.c **** 
  32:../src/main.c **** //  NOTE: You DO NOT need to modify the code below this line
  33:../src/main.c **** 
  34:../src/main.c **** //  C & Floating Point version
  35:../src/main.c ****   	printf("C & Floating point version:\n",x);
 150              		.loc 1 35 0
 151 00ba 40F20004 		movw	r4, #:lower16:.LC4
 152 00be C0F20004 		movt	r4, #:upper16:.LC4
 153 00c2 3B68     		ldr	r3, [r7, #0]	@ float
 154 00c4 1846     		mov	r0, r3
 155 00c6 FFF7FEFF 		bl	__aeabi_f2d
 156 00ca 0246     		mov	r2, r0
 157 00cc 0B46     		mov	r3, r1
 158 00ce 2046     		mov	r0, r4
 159 00d0 FFF7FEFF 		bl	printf
 160              	.L5:
  36:../src/main.c ****     while (1)
  37:../src/main.c ****     {
  38:../src/main.c ****     	fp = 2*a*x + b;
 161              		.loc 1 38 0
 162 00d4 7B6B     		ldr	r3, [r7, #52]
 163 00d6 4FEA4303 		lsl	r3, r3, #1
 164 00da 1846     		mov	r0, r3
 165 00dc FFF7FEFF 		bl	__aeabi_i2f
 166 00e0 0246     		mov	r2, r0
 167 00e2 3B68     		ldr	r3, [r7, #0]	@ float
 168 00e4 1046     		mov	r0, r2
 169 00e6 1946     		mov	r1, r3
 170 00e8 FFF7FEFF 		bl	__aeabi_fmul
 171 00ec 0346     		mov	r3, r0
 172 00ee 1C46     		mov	r4, r3
 173 00f0 386B     		ldr	r0, [r7, #48]
 174 00f2 FFF7FEFF 		bl	__aeabi_i2f
 175 00f6 0346     		mov	r3, r0
 176 00f8 2046     		mov	r0, r4
 177 00fa 1946     		mov	r1, r3
 178 00fc FFF7FEFF 		bl	__aeabi_fadd
 179 0100 0346     		mov	r3, r0
 180 0102 3B61     		str	r3, [r7, #16]	@ float
  39:../src/main.c **** 
  40:../src/main.c ****     	xprev = x;
 181              		.loc 1 40 0
 182 0104 3B68     		ldr	r3, [r7, #0]	@ float
 183 0106 FB60     		str	r3, [r7, #12]	@ float
  41:../src/main.c ****     	change = -lambda*fp;
 184              		.loc 1 41 0
 185 0108 BB6A     		ldr	r3, [r7, #40]
 186 010a 83F00043 		eor	r3, r3, #-2147483648
 187 010e 1846     		mov	r0, r3
 188 0110 3969     		ldr	r1, [r7, #16]	@ float
 189 0112 FFF7FEFF 		bl	__aeabi_fmul
 190 0116 0346     		mov	r3, r0
 191 0118 BB60     		str	r3, [r7, #8]	@ float
  42:../src/main.c ****     	x += change;
 192              		.loc 1 42 0
 193 011a 3B68     		ldr	r3, [r7, #0]	@ float
 194 011c 1846     		mov	r0, r3
 195 011e B968     		ldr	r1, [r7, #8]	@ float
 196 0120 FFF7FEFF 		bl	__aeabi_fadd
 197 0124 0346     		mov	r3, r0
 198 0126 3B60     		str	r3, [r7, #0]	@ float
  43:../src/main.c **** 
  44:../src/main.c ****     	printf("x: %f, fp: %f, change: %f\n", x, fp, change);
 199              		.loc 1 44 0
 200 0128 40F20004 		movw	r4, #:lower16:.LC5
 201 012c C0F20004 		movt	r4, #:upper16:.LC5
 202 0130 3B68     		ldr	r3, [r7, #0]	@ float
 203 0132 1846     		mov	r0, r3
 204 0134 FFF7FEFF 		bl	__aeabi_f2d
 205 0138 8046     		mov	r8, r0
 206 013a 8946     		mov	r9, r1
 207 013c 3869     		ldr	r0, [r7, #16]	@ float
 208 013e FFF7FEFF 		bl	__aeabi_f2d
 209 0142 8246     		mov	sl, r0
 210 0144 8B46     		mov	fp, r1
 211 0146 B868     		ldr	r0, [r7, #8]	@ float
 212 0148 FFF7FEFF 		bl	__aeabi_f2d
 213 014c 0246     		mov	r2, r0
 214 014e 0B46     		mov	r3, r1
 215 0150 CDE900AB 		strd	sl, [sp]
 216 0154 CDE90223 		strd	r2, [sp, #8]
 217 0158 2046     		mov	r0, r4
 218 015a 4246     		mov	r2, r8
 219 015c 4B46     		mov	r3, r9
 220 015e FFF7FEFF 		bl	printf
  45:../src/main.c ****     	if (x==xprev) break;
 221              		.loc 1 45 0
 222 0162 3B68     		ldr	r3, [r7, #0]	@ float
 223 0164 1846     		mov	r0, r3
 224 0166 F968     		ldr	r1, [r7, #12]	@ float
 225 0168 FFF7FEFF 		bl	__aeabi_fcmpeq
 226 016c 0346     		mov	r3, r0
 227 016e 002B     		cmp	r3, #0
 228 0170 00D1     		bne	.L6
  46:../src/main.c ****     }
 229              		.loc 1 46 0
 230 0172 AFE7     		b	.L5
 231              	.L6:
  45:../src/main.c ****     	if (x==xprev) break;
 232              		.loc 1 45 0
 233 0174 00BF     		nop
 234              	.L4:
  47:../src/main.c **** 
  48:../src/main.c ****     // Enter an infinite loop, just incrementing a counter
  49:../src/main.c **** 	// This is for convenience to allow registers, variables and memory locations to be inspected at t
  50:../src/main.c **** 	volatile static int loop = 0;
  51:../src/main.c **** 	while (1) {
  52:../src/main.c **** 		loop++;
 235              		.loc 1 52 0 discriminator 1
 236 0176 40F20003 		movw	r3, #:lower16:loop.3830
 237 017a C0F20003 		movt	r3, #:upper16:loop.3830
 238 017e 1B68     		ldr	r3, [r3, #0]
 239 0180 03F10102 		add	r2, r3, #1
 240 0184 40F20003 		movw	r3, #:lower16:loop.3830
 241 0188 C0F20003 		movt	r3, #:upper16:loop.3830
 242 018c 1A60     		str	r2, [r3, #0]
  53:../src/main.c **** 	}
 243              		.loc 1 53 0 discriminator 1
 244 018e F2E7     		b	.L4
 245              	.L8:
 246              		.align	2
 247              	.L7:
 248 0190 CDCCCC3D 		.word	1036831949
 249 0194 00401C46 		.word	1176256512
 250              		.cfi_endproc
 251              	.LFE0:
 253              		.bss
 254              		.align	2
 255              	loop.3830:
 256 0000 00000000 		.space	4
 257              		.text
 258              	.Letext0:
DEFINED SYMBOLS
                            *ABS*:00000000 main.c
C:\Users\tomzhang\AppData\Local\Temp\ccydA4Ln.s:19     .rodata:00000000 $d
C:\Users\tomzhang\AppData\Local\Temp\ccydA4Ln.s:20     .rodata:00000000 .LC0
C:\Users\tomzhang\AppData\Local\Temp\ccydA4Ln.s:24     .rodata:00000038 .LC1
C:\Users\tomzhang\AppData\Local\Temp\ccydA4Ln.s:27     .rodata:0000003c .LC2
C:\Users\tomzhang\AppData\Local\Temp\ccydA4Ln.s:34     .rodata:00000058 .LC3
C:\Users\tomzhang\AppData\Local\Temp\ccydA4Ln.s:38     .rodata:00000078 .LC4
C:\Users\tomzhang\AppData\Local\Temp\ccydA4Ln.s:42     .rodata:00000098 .LC5
C:\Users\tomzhang\AppData\Local\Temp\ccydA4Ln.s:46     .text.main:00000000 $t
C:\Users\tomzhang\AppData\Local\Temp\ccydA4Ln.s:51     .text.main:00000000 main
C:\Users\tomzhang\AppData\Local\Temp\ccydA4Ln.s:255    .bss:00000000 loop.3830
C:\Users\tomzhang\AppData\Local\Temp\ccydA4Ln.s:248    .text.main:00000190 $d
C:\Users\tomzhang\AppData\Local\Temp\ccydA4Ln.s:254    .bss:00000000 $d
                     .debug_frame:00000010 $d

UNDEFINED SYMBOLS
__aeabi_fmul
__aeabi_f2iz
__aeabi_i2f
__aeabi_fdiv
__aeabi_f2d
__aeabi_fadd
__aeabi_fcmpeq
printf
scanf
optimize
