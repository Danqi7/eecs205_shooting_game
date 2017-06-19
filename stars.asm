; #########################################################################
;
;   stars.asm - Assembly file for EECS205 Assignment 1
;   Name: Danqi Liao
;
; #########################################################################

      .586
      .MODEL FLAT,STDCALL
      .STACK 4096
      option casemap :none  ; case sensitive


include stars.inc

.DATA
d1 DWORD 201
d2 DWORD 202
d3 DWORD 253
d4 DWORD 173
d5 DWORD 221
d6 DWORD 232
d7 DWORD 293
d8 DWORD 253
d9 DWORD 201
d10 DWORD 225
d11 DWORD 255
d12 DWORD 258
d13 DWORD 188
d14 DWORD 190
d15 DWORD 175

	;; If you need to, you can place global variables here

.CODE

DrawStarField proc move:DWORD

	;; Place your code here
      mov eax, move
      add eax, d1
      INVOKE DrawStar, 370, eax
      mov eax, move
      add eax, d2
      INVOKE DrawStar, 500, eax
      mov eax, move
      add eax, d3
      INVOKE DrawStar, 340, eax
      mov eax, move
      add eax, d4
      INVOKE DrawStar, 620, eax
      mov eax, move
      add eax, d5
      INVOKE DrawStar, 401, eax
      mov eax, move
      add eax, d6
      INVOKE DrawStar, 502, eax
      mov eax, move
      add eax, d7
      INVOKE DrawStar, 603, eax
      mov eax, move
      add eax, d8
      INVOKE DrawStar, 334, eax
      mov eax, move
      add eax, d9
      INVOKE DrawStar, 345, eax
      mov eax, move
      add eax, d10
      INVOKE DrawStar, 100, eax
      mov eax, move
      add eax, d11
      INVOKE DrawStar, 413, eax
      mov eax, move
      add eax, d12
      INVOKE DrawStar, 324, eax
      mov eax, move
      add eax, d13
      INVOKE DrawStar, 335, eax
      mov eax, move
      add eax, d14
      INVOKE DrawStar, 346, eax
      mov eax, move
      add eax, d15
      INVOKE DrawStar, 306, eax

	ret  			; Careful! Don't remove this line
DrawStarField endp



END
