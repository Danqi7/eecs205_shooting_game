; #########################################################################
;
;   trig.asm - Assembly file for EECS205 Assignment 3
;   Danqi Liao
;
; #########################################################################

      .586
      .MODEL FLAT,STDCALL
      .STACK 4096
      option casemap :none  ; case sensitive

include trig.inc

.DATA

;;  These are some useful constants (fixed point values that correspond to important angles)
PI_HALF = 102943           	;;  PI / 2
PI =  205887	                ;;  PI
TWO_PI	= 411774                ;;  2 * PI
PI_INC_RECIP =  5340353        	;;  Use reciprocal to find the table entry for a given angle
	                        ;;              (It is easier to use than divison would be)


	;; If you need to, you can place global variables here

.CODE

FixedSin PROC USES ebx edx angle:FXPT

  local negflag: DWORD
  mov negflag, 0

test0:
  cmp angle, 0        ;;check if angle < 0, if < 0, add 2pi
  jge test1
  add angle, TWO_PI
  jmp test0

test1:
  cmp angle, TWO_PI   ;;check if angle < 2pi, if < 2pi, go to test2
  jl test2
  sub angle, TWO_PI   ;;if >= 2pi, subtract 2pi until less than 2pi
  jmp test1

test2:
  cmp angle, PI       ;;check if angle < pi, if < pi, go to test 3
  jl test3
  sub angle, PI       ;;otherwise subtract pi to make angle < pi
  mov negflag, 1      ;;indicate the result is negative

test3:
  cmp angle, PI_HALF  ;;check if angle is < pi/2
  jle compute
  mov ebx, PI         ;;otherwise angle = pi-angle
  sub ebx, angle
  mov angle, ebx

compute:
  mov edx, 0
  mov eax, PI_INC_RECIP
  mov ebx, angle
  imul ebx
  shl edx, 1
  movzx eax, WORD PTR [SINTAB + edx]

negcheck:
  cmp negflag, 1
  jne return
  neg eax

return:
	ret			; Don't delete this line!!!
FixedSin ENDP


FixedCos PROC angle:FXPT
  add angle, PI_HALF
  INVOKE FixedSin, angle
	ret			; Don't delete this line!!!
FixedCos ENDP
END
