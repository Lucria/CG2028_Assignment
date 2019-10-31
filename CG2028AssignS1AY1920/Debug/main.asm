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
  35 0058 78736F6C 		.ascii	"xsol : %f \012\012\000"
  35      203A2025 
  35      66200A0A 
  35      00
  36              		.global	__aeabi_f2d
  37 0065 000000   		.align	2
  38              	.LC4:
  39 0068 43202620 		.ascii	"C & Floating point version:\012\000"
  39      466C6F61 
  39      74696E67 
  39      20706F69 
  39      6E742076 
  40              		.global	__aeabi_fadd
  41 0085 000000   		.align	2
  42              	.LC5:
  43 0088 783A2025 		.ascii	"x: %f, fp: %f, change: %f\012\000"
  43      662C2066 
  43      703A2025 
  43      662C2063 
  43      68616E67 
  44              		.global	__aeabi_fcmpeq
  45 00a3 00       		.section	.text.main,"ax",%progbits
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
  11:../src/main.c **** extern int optimize(int a, int b, int xi);
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
  16:../src/main.c ****     float fp, x, xprev, xsol, change, lambda=0.1;
  81              		.loc 1 16 0
  82 001a 5B4B     		ldr	r3, .L7	@ float
  83 001c BB62     		str	r3, [r7, #40]	@ float
  17:../src/main.c **** 
  18:../src/main.c ****     printf("Initial value of x (press [Enter] after keying in): "); // try x0 = -6.78
  84              		.loc 1 18 0
  85 001e 40F20003 		movw	r3, #:lower16:.LC0
  86 0022 C0F20003 		movt	r3, #:upper16:.LC0
  87 0026 1846     		mov	r0, r3
  88 0028 FFF7FEFF 		bl	printf
  19:../src/main.c ****     scanf("%f", &x);
  89              		.loc 1 19 0
  90 002c 40F20003 		movw	r3, #:lower16:.LC1
  91 0030 C0F20003 		movt	r3, #:upper16:.LC1
  92 0034 07F10402 		add	r2, r7, #4
  93 0038 1846     		mov	r0, r3
  94 003a 1146     		mov	r1, r2
  95 003c FFF7FEFF 		bl	scanf
  20:../src/main.c **** 
  21:../src/main.c **** //  ARM ASM & Integer version
  22:../src/main.c ****     printf("ARM ASM & Integer version:\n");
  96              		.loc 1 22 0
  97 0040 40F20003 		movw	r3, #:lower16:.LC2
  98 0044 C0F20003 		movt	r3, #:upper16:.LC2
  99 0048 1846     		mov	r0, r3
 100 004a FFF7FEFF 		bl	printf
  23:../src/main.c ****     int scaledA = a;
 101              		.loc 1 23 0
 102 004e 7B6B     		ldr	r3, [r7, #52]
 103 0050 7B62     		str	r3, [r7, #36]
  24:../src/main.c ****     int scaledB = b * 100000;
 104              		.loc 1 24 0
 105 0052 3A6B     		ldr	r2, [r7, #48]
 106 0054 48F2A063 		movw	r3, #34464
 107 0058 C0F20103 		movt	r3, 1
 108 005c 03FB02F3 		mul	r3, r3, r2
 109 0060 3B62     		str	r3, [r7, #32]
  25:../src/main.c ****     int scaledX = x * 100000;
 110              		.loc 1 25 0
 111 0062 7B68     		ldr	r3, [r7, #4]	@ float
 112 0064 1846     		mov	r0, r3
 113 0066 4949     		ldr	r1, .L7+4	@ float
 114 0068 FFF7FEFF 		bl	__aeabi_fmul
 115 006c 0346     		mov	r3, r0
 116 006e 1846     		mov	r0, r3
 117 0070 FFF7FEFF 		bl	__aeabi_f2iz
 118 0074 0346     		mov	r3, r0
 119 0076 FB61     		str	r3, [r7, #28]
  26:../src/main.c ****     xsoli = optimize(scaledA,scaledB,(int)scaledX);
 120              		.loc 1 26 0
 121 0078 786A     		ldr	r0, [r7, #36]
 122 007a 396A     		ldr	r1, [r7, #32]
 123 007c FA69     		ldr	r2, [r7, #28]
 124 007e FFF7FEFF 		bl	optimize
 125 0082 0346     		mov	r3, r0
 126 0084 BB61     		str	r3, [r7, #24]
  27:../src/main.c ****     xsol = (float)xsoli / 100000;
 127              		.loc 1 27 0
 128 0086 B869     		ldr	r0, [r7, #24]
 129 0088 FFF7FEFF 		bl	__aeabi_i2f
 130 008c 0346     		mov	r3, r0
 131 008e 1846     		mov	r0, r3
 132 0090 3E49     		ldr	r1, .L7+4	@ float
 133 0092 FFF7FEFF 		bl	__aeabi_fdiv
 134 0096 0346     		mov	r3, r0
 135 0098 7B61     		str	r3, [r7, #20]	@ float
  28:../src/main.c ****     printf("xsol : %f \n\n",xsol);
 136              		.loc 1 28 0
 137 009a 40F20004 		movw	r4, #:lower16:.LC3
 138 009e C0F20004 		movt	r4, #:upper16:.LC3
 139 00a2 7869     		ldr	r0, [r7, #20]	@ float
 140 00a4 FFF7FEFF 		bl	__aeabi_f2d
 141 00a8 0246     		mov	r2, r0
 142 00aa 0B46     		mov	r3, r1
 143 00ac 2046     		mov	r0, r4
 144 00ae FFF7FEFF 		bl	printf
  29:../src/main.c **** 
  30:../src/main.c **** //  NOTE: You DO NOT need to modify the code below this line
  31:../src/main.c **** 
  32:../src/main.c **** //  C & Floating Point version
  33:../src/main.c ****   	printf("C & Floating point version:\n",x);
 145              		.loc 1 33 0
 146 00b2 40F20004 		movw	r4, #:lower16:.LC4
 147 00b6 C0F20004 		movt	r4, #:upper16:.LC4
 148 00ba 7B68     		ldr	r3, [r7, #4]	@ float
 149 00bc 1846     		mov	r0, r3
 150 00be FFF7FEFF 		bl	__aeabi_f2d
 151 00c2 0246     		mov	r2, r0
 152 00c4 0B46     		mov	r3, r1
 153 00c6 2046     		mov	r0, r4
 154 00c8 FFF7FEFF 		bl	printf
 155              	.L5:
  34:../src/main.c ****     while (1)
  35:../src/main.c ****     {
  36:../src/main.c ****     	fp = 2*a*x + b;
 156              		.loc 1 36 0
 157 00cc 7B6B     		ldr	r3, [r7, #52]
 158 00ce 4FEA4303 		lsl	r3, r3, #1
 159 00d2 1846     		mov	r0, r3
 160 00d4 FFF7FEFF 		bl	__aeabi_i2f
 161 00d8 0246     		mov	r2, r0
 162 00da 7B68     		ldr	r3, [r7, #4]	@ float
 163 00dc 1046     		mov	r0, r2
 164 00de 1946     		mov	r1, r3
 165 00e0 FFF7FEFF 		bl	__aeabi_fmul
 166 00e4 0346     		mov	r3, r0
 167 00e6 1C46     		mov	r4, r3
 168 00e8 386B     		ldr	r0, [r7, #48]
 169 00ea FFF7FEFF 		bl	__aeabi_i2f
 170 00ee 0346     		mov	r3, r0
 171 00f0 2046     		mov	r0, r4
 172 00f2 1946     		mov	r1, r3
 173 00f4 FFF7FEFF 		bl	__aeabi_fadd
 174 00f8 0346     		mov	r3, r0
 175 00fa 3B61     		str	r3, [r7, #16]	@ float
  37:../src/main.c **** 
  38:../src/main.c ****     	xprev = x;
 176              		.loc 1 38 0
 177 00fc 7B68     		ldr	r3, [r7, #4]	@ float
 178 00fe FB60     		str	r3, [r7, #12]	@ float
  39:../src/main.c ****     	change = -lambda*fp;
 179              		.loc 1 39 0
 180 0100 BB6A     		ldr	r3, [r7, #40]
 181 0102 83F00043 		eor	r3, r3, #-2147483648
 182 0106 1846     		mov	r0, r3
 183 0108 3969     		ldr	r1, [r7, #16]	@ float
 184 010a FFF7FEFF 		bl	__aeabi_fmul
 185 010e 0346     		mov	r3, r0
 186 0110 BB60     		str	r3, [r7, #8]	@ float
  40:../src/main.c ****     	x += change;
 187              		.loc 1 40 0
 188 0112 7B68     		ldr	r3, [r7, #4]	@ float
 189 0114 1846     		mov	r0, r3
 190 0116 B968     		ldr	r1, [r7, #8]	@ float
 191 0118 FFF7FEFF 		bl	__aeabi_fadd
 192 011c 0346     		mov	r3, r0
 193 011e 7B60     		str	r3, [r7, #4]	@ float
  41:../src/main.c **** 
  42:../src/main.c ****     	printf("x: %f, fp: %f, change: %f\n", x, fp, change);
 194              		.loc 1 42 0
 195 0120 40F20004 		movw	r4, #:lower16:.LC5
 196 0124 C0F20004 		movt	r4, #:upper16:.LC5
 197 0128 7B68     		ldr	r3, [r7, #4]	@ float
 198 012a 1846     		mov	r0, r3
 199 012c FFF7FEFF 		bl	__aeabi_f2d
 200 0130 8046     		mov	r8, r0
 201 0132 8946     		mov	r9, r1
 202 0134 3869     		ldr	r0, [r7, #16]	@ float
 203 0136 FFF7FEFF 		bl	__aeabi_f2d
 204 013a 8246     		mov	sl, r0
 205 013c 8B46     		mov	fp, r1
 206 013e B868     		ldr	r0, [r7, #8]	@ float
 207 0140 FFF7FEFF 		bl	__aeabi_f2d
 208 0144 0246     		mov	r2, r0
 209 0146 0B46     		mov	r3, r1
 210 0148 CDE900AB 		strd	sl, [sp]
 211 014c CDE90223 		strd	r2, [sp, #8]
 212 0150 2046     		mov	r0, r4
 213 0152 4246     		mov	r2, r8
 214 0154 4B46     		mov	r3, r9
 215 0156 FFF7FEFF 		bl	printf
  43:../src/main.c ****     	if (x==xprev) break;
 216              		.loc 1 43 0
 217 015a 7B68     		ldr	r3, [r7, #4]	@ float
 218 015c 1846     		mov	r0, r3
 219 015e F968     		ldr	r1, [r7, #12]	@ float
 220 0160 FFF7FEFF 		bl	__aeabi_fcmpeq
 221 0164 0346     		mov	r3, r0
 222 0166 002B     		cmp	r3, #0
 223 0168 00D1     		bne	.L6
  44:../src/main.c ****     }
 224              		.loc 1 44 0
 225 016a AFE7     		b	.L5
 226              	.L6:
  43:../src/main.c ****     	if (x==xprev) break;
 227              		.loc 1 43 0
 228 016c 00BF     		nop
 229              	.L4:
  45:../src/main.c **** 
  46:../src/main.c ****     // Enter an infinite loop, just incrementing a counter
  47:../src/main.c **** 	// This is for convenience to allow registers, variables and memory locations to be inspected at t
  48:../src/main.c **** 	volatile static int loop = 0;
  49:../src/main.c **** 	while (1) {
  50:../src/main.c **** 		loop++;
 230              		.loc 1 50 0 discriminator 1
 231 016e 40F20003 		movw	r3, #:lower16:loop.3828
 232 0172 C0F20003 		movt	r3, #:upper16:loop.3828
 233 0176 1B68     		ldr	r3, [r3, #0]
 234 0178 03F10102 		add	r2, r3, #1
 235 017c 40F20003 		movw	r3, #:lower16:loop.3828
 236 0180 C0F20003 		movt	r3, #:upper16:loop.3828
 237 0184 1A60     		str	r2, [r3, #0]
  51:../src/main.c **** 	}
 238              		.loc 1 51 0 discriminator 1
 239 0186 F2E7     		b	.L4
 240              	.L8:
 241              		.align	2
 242              	.L7:
 243 0188 CDCCCC3D 		.word	1036831949
 244 018c 0050C347 		.word	1203982336
 245              		.cfi_endproc
 246              	.LFE0:
 248              		.bss
 249              		.align	2
 250              	loop.3828:
 251 0000 00000000 		.space	4
 252              		.text
 253              	.Letext0:
DEFINED SYMBOLS
                            *ABS*:00000000 main.c
C:\Users\tomzhang\AppData\Local\Temp\ccIjbSad.s:19     .rodata:00000000 $d
C:\Users\tomzhang\AppData\Local\Temp\ccIjbSad.s:20     .rodata:00000000 .LC0
C:\Users\tomzhang\AppData\Local\Temp\ccIjbSad.s:24     .rodata:00000038 .LC1
C:\Users\tomzhang\AppData\Local\Temp\ccIjbSad.s:27     .rodata:0000003c .LC2
C:\Users\tomzhang\AppData\Local\Temp\ccIjbSad.s:34     .rodata:00000058 .LC3
C:\Users\tomzhang\AppData\Local\Temp\ccIjbSad.s:38     .rodata:00000068 .LC4
C:\Users\tomzhang\AppData\Local\Temp\ccIjbSad.s:42     .rodata:00000088 .LC5
C:\Users\tomzhang\AppData\Local\Temp\ccIjbSad.s:46     .text.main:00000000 $t
C:\Users\tomzhang\AppData\Local\Temp\ccIjbSad.s:51     .text.main:00000000 main
C:\Users\tomzhang\AppData\Local\Temp\ccIjbSad.s:250    .bss:00000000 loop.3828
C:\Users\tomzhang\AppData\Local\Temp\ccIjbSad.s:243    .text.main:00000188 $d
C:\Users\tomzhang\AppData\Local\Temp\ccIjbSad.s:249    .bss:00000000 $d
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
