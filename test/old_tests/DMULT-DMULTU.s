.data
menouno:	.word64 0xFFFFFFFFFFFFFFFF ; -1 signed or 2^64-1 unsigned
uno:		.word64 0x1
high:		.word64 0x7FFFFFFFFFFFFFFF ; 2^63-1
.code
ld	r1,menouno(r0)	; r1  = FFFFFFFFFFFFFFFFF
ld	r2,uno(r0)	; r2  = 00000000000000001
DMULT   r1,r1 		; execute -1 * -1 (1)
MFHI    r3		; r3  = 00000000000000000
MFLO    r4		; r4  = 00000000000000001
DMULTU  r1,r1		; execute 0xFFFFFFFFFFFFFFFFF * 0xFFFFFFFFFFFFFFFFF (2^64-1*2^64-1) = FFFFFFFFFFFFFFFFE00000000000000001
MFHI    r5		; r5  = FFFFFFFFFFFFFFFFE
MFLO    r6		; r6  = 00000000000000001
DMULT   r2,r1		; execute -1 * 1 (-1)
MFHI    r7		; r7  = FFFFFFFFFFFFFFFFF
MFLO    r8		; r8  = FFFFFFFFFFFFFFFFF
DMULTU  r1,r2		; execute 2^64-1 * 1 (2^64-1 or FFFFFFFFFFFFFFFFF) 
MFHI    r9		; r9  = 00000000000000000
MFLO    r10		; r10 = FFFFFFFFFFFFFFFFF
ld	r11,high(r0)	; r11 = 0x7FFFFFFFFFFFFFFFF
DMULT   r11,r11		; execute 2^63-1 * 2^63-1 (3FFFFFFFFFFFFFFFF00000000000000001)
MFHI    r12		; r12 = 3FFFFFFFFFFFFFFFF
MFLO    r13		; r13 = 00000000000000001
