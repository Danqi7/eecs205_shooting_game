; #########################################################################
;
;   game.asm - Assembly file for EECS205 Assignment 4/5
;
;
; #########################################################################

      .586
      .MODEL FLAT,STDCALL
      .STACK 4096
      option casemap :none  ; case sensitive

include stars.inc
include lines.inc
include trig.inc
include blit.inc
include game.inc
;include gamehelper.inc
include \masm32\include\windows.inc
include \masm32\include\masm32.inc
include \masm32\include\winmm.inc
include \masm32\include\user32.inc
includelib \masm32\lib\user32.lib
includelib \masm32\lib\winmm.lib
includelib \masm32\lib\masm32.lib

;; Has keycodes
include keys.inc


.DATA
asteroid_001 EECS205BITMAP <32, 32, 255,, offset asteroid_001 + sizeof asteroid_001>
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,091h,049h,091h,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,091h,0b6h,091h,049h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 091h,0b6h,091h,049h,049h,024h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h
	BYTE 0b6h,091h,091h,091h,049h,049h,024h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h
	BYTE 0b6h,091h,091h,091h,049h,091h,049h,024h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h
	BYTE 0b6h,091h,091h,091h,091h,049h,091h,049h,024h,049h,049h,024h,024h,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h
	BYTE 0b6h,091h,091h,091h,049h,024h,049h,091h,024h,024h,049h,049h,024h,024h,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h
	BYTE 0b6h,091h,091h,091h,049h,024h,049h,091h,049h,024h,049h,049h,024h,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h
	BYTE 091h,0b6h,0b6h,091h,049h,049h,024h,049h,024h,024h,049h,024h,024h,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h,0b6h
	BYTE 049h,091h,0b6h,091h,091h,049h,049h,049h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h,0b6h,091h
	BYTE 091h,049h,091h,091h,049h,049h,049h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h,0b6h,091h,091h
	BYTE 091h,091h,091h,091h,049h,049h,024h,024h,049h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h,0b6h,0b6h,091h,0b6h
	BYTE 0b6h,091h,091h,049h,049h,024h,024h,049h,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h,0b6h,0b6h,091h,0b6h,0b6h
	BYTE 091h,091h,049h,049h,049h,024h,024h,049h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,091h,091h,091h,091h,0b6h,0b6h,0b6h,091h,091h,0b6h,091h
	BYTE 091h,091h,049h,049h,024h,024h,024h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,091h,091h,091h,091h,0b6h,0b6h,0b6h,0b6h,0b6h,0b6h,091h,091h,091h,091h
	BYTE 091h,049h,049h,049h,049h,024h,024h,049h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,091h,0b6h,0b6h,091h,091h,091h,0b6h,0b6h,0b6h,0b6h,091h,091h,091h,091h,091h
	BYTE 091h,049h,049h,049h,049h,024h,024h,091h,049h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,091h,0b6h,091h,0b6h,0b6h,0b6h,0b6h,0b6h,091h,091h,091h,091h,091h,091h,049h
	BYTE 091h,049h,049h,049h,049h,024h,049h,091h,091h,049h,024h,024h,024h,0ffh,0ffh,0ffh
	BYTE 091h,0b6h,0b6h,0b6h,0b6h,091h,091h,091h,0b6h,0b6h,091h,091h,091h,091h,049h,049h
	BYTE 049h,091h,049h,049h,024h,024h,049h,049h,091h,091h,049h,024h,024h,0ffh,0ffh,0ffh
	BYTE 091h,0b6h,0b6h,0b6h,091h,091h,049h,091h,091h,0b6h,091h,091h,0b6h,091h,049h,049h
	BYTE 049h,049h,049h,024h,024h,049h,049h,049h,091h,091h,049h,024h,024h,024h,0ffh,0ffh
	BYTE 0ffh,091h,0b6h,0b6h,091h,091h,049h,049h,091h,0b6h,091h,091h,091h,091h,091h,049h
	BYTE 049h,049h,049h,024h,024h,049h,049h,049h,091h,091h,049h,024h,049h,024h,0ffh,0ffh
	BYTE 0ffh,0ffh,091h,0b6h,0b6h,091h,091h,049h,049h,091h,091h,0b6h,091h,091h,091h,049h
	BYTE 049h,049h,049h,024h,024h,049h,049h,049h,091h,049h,049h,049h,024h,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,091h,0b6h,0b6h,091h,091h,091h,091h,0b6h,091h,091h,091h,091h,091h
	BYTE 049h,049h,049h,049h,024h,024h,049h,091h,049h,049h,049h,091h,049h,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,091h,0b6h,0b6h,091h,091h,0b6h,091h,0b6h,0b6h,091h,091h,091h,091h
	BYTE 049h,049h,049h,049h,024h,024h,024h,049h,049h,049h,091h,049h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,091h,0b6h,0b6h,0b6h,091h,091h,091h,0b6h,0b6h,091h,091h,049h
	BYTE 049h,049h,091h,049h,049h,049h,049h,049h,049h,091h,091h,049h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h,0b6h,0b6h,091h,091h,091h,091h,091h,049h,049h
	BYTE 049h,024h,049h,091h,049h,049h,049h,049h,091h,091h,049h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,091h,0b6h,0b6h,0b6h,091h,091h,091h,091h,049h
	BYTE 049h,049h,024h,049h,091h,091h,091h,091h,091h,049h,049h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,091h,091h,0b6h,0b6h,091h,091h,091h
	BYTE 091h,091h,091h,091h,091h,049h,049h,049h,049h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,091h,0b6h,0b6h,091h
	BYTE 091h,049h,049h,049h,049h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,091h,049h
	BYTE 049h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
nuke_000 EECS205BITMAP <8, 9, 255,, offset nuke_000 + sizeof nuke_000>
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,01ch,01ch,01ch,0ffh,0ffh,0ffh
  	BYTE 0ffh,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh
  	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh
  	BYTE 0ffh,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,0ffh,0ffh,01ch,01ch,01ch,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
asteroid_002 EECS205BITMAP <13, 14, 255,, offset asteroid_002 + sizeof asteroid_002>
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,049h
	BYTE 049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,091h,049h,024h,024h,024h
	BYTE 024h,0ffh,0ffh,0ffh,0ffh,0ffh,091h,091h,0b6h,091h,049h,024h,024h,024h,024h,024h
	BYTE 0ffh,0ffh,091h,0b6h,0b6h,091h,091h,091h,049h,049h,024h,049h,024h,024h,0ffh,091h
	BYTE 0b6h,091h,091h,091h,0b6h,091h,091h,049h,049h,049h,024h,0ffh,091h,0b6h,0b6h,091h
	BYTE 049h,091h,0b6h,091h,049h,024h,049h,024h,0ffh,0ffh,091h,0b6h,0b6h,091h,049h,091h
	BYTE 049h,049h,024h,024h,024h,0ffh,0ffh,091h,0b6h,0b6h,0b6h,091h,091h,091h,049h,049h
	BYTE 024h,024h,0ffh,0ffh,0ffh,091h,091h,0b6h,0b6h,0b6h,091h,091h,091h,091h,024h,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,091h,091h,0b6h,0b6h,0b6h,049h,049h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,091h,091h,091h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
fighter_000 EECS205BITMAP <44, 37, 255,, offset fighter_000 + sizeof fighter_000>
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,049h,0b6h,049h,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h
	BYTE 0ffh,0e0h,0e0h,080h,080h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0e0h,0e0h,0e0h,080h,080h
	BYTE 080h,080h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,091h,049h,013h,049h,00ah,024h,049h,024h,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,049h,091h,049h,013h,0ffh,00ah,024h,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,091h
	BYTE 013h,013h,0ffh,00ah,00ah,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,091h,013h,013h,013h,00ah
	BYTE 00ah,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,0b6h,013h,013h,013h,00ah,00ah,091h,024h,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,049h,091h,0b6h,049h,013h,013h,00ah,024h,091h,049h,024h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,091h,091h
	BYTE 0b6h,049h,0ffh,024h,091h,049h,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,049h,091h,091h,0b6h,091h,091h
	BYTE 049h,049h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,049h,049h,091h,091h,091h,049h,049h,049h,049h,024h,024h
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0e0h,0e0h,080h,0ffh,0ffh
	BYTE 0ffh,049h,091h,049h,049h,091h,049h,049h,024h,024h,049h,024h,0ffh,0ffh,0ffh,080h
	BYTE 080h,080h,080h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0e0h,0ffh,0e0h,0e0h,080h,080h,0ffh,049h,091h,091h,0b6h
	BYTE 091h,049h,049h,024h,049h,049h,049h,049h,024h,0ffh,0e0h,080h,080h,080h,080h,080h
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0e0h,049h,049h,049h,024h,080h,0ffh,049h,091h,0b6h,0b6h,091h,091h,049h,049h
	BYTE 049h,049h,049h,049h,024h,0ffh,0e0h,024h,024h,024h,024h,080h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,091h,091h
	BYTE 091h,049h,024h,049h,091h,091h,0b6h,091h,091h,091h,049h,049h,049h,049h,049h,049h
	BYTE 049h,024h,091h,049h,049h,049h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,091h,091h,091h,049h,024h,0ffh
	BYTE 049h,0b6h,091h,091h,091h,091h,049h,049h,049h,049h,049h,049h,024h,0e0h,091h,049h
	BYTE 049h,049h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,091h,091h,091h,049h,024h,0e0h,0ffh,049h,049h,091h
	BYTE 091h,091h,049h,049h,049h,049h,024h,024h,0e0h,080h,091h,049h,049h,049h,024h,024h
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0b6h,091h,091h,091h,049h,024h,0e0h,0e0h,049h,091h,049h,049h,049h,049h,024h
	BYTE 024h,024h,049h,024h,080h,080h,091h,049h,049h,049h,024h,024h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,049h,049h,049h
	BYTE 049h,024h,024h,0e0h,0e0h,0b6h,049h,0b6h,0b6h,091h,080h,049h,049h,049h,024h,049h
	BYTE 080h,080h,049h,024h,024h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,091h,091h,091h,091h,091h,049h,024h
	BYTE 0e0h,0b6h,049h,091h,0b6h,091h,080h,049h,049h,024h,024h,049h,080h,091h,049h,049h
	BYTE 049h,049h,049h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,049h,0b6h,091h,091h,091h,091h,091h,049h,024h,0e0h,0b6h,049h,0b6h
	BYTE 091h,049h,080h,024h,024h,049h,024h,049h,080h,091h,049h,049h,049h,049h,049h,024h
	BYTE 024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,049h
	BYTE 0b6h,091h,091h,000h,091h,091h,049h,024h,0e0h,0b6h,091h,049h,0b6h,091h,080h,049h
	BYTE 049h,024h,049h,049h,080h,091h,049h,049h,000h,049h,049h,024h,024h,024h,024h,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,091h,049h,0b6h,091h,000h,0fch
	BYTE 000h,091h,049h,024h,0e0h,0b6h,091h,049h,091h,091h,080h,049h,024h,024h,049h,049h
	BYTE 080h,091h,049h,000h,090h,000h,049h,024h,024h,024h,049h,024h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,091h,0b6h,091h,049h,0b6h,000h,0fch,000h,0fch,000h,049h,024h
	BYTE 0e0h,0b6h,091h,049h,0b6h,049h,080h,024h,049h,024h,049h,049h,080h,091h,000h,090h
	BYTE 000h,090h,000h,024h,024h,024h,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0b6h,091h,049h,0e0h,0b6h,000h,000h,000h,000h,000h,049h,024h,080h,0b6h,091h,091h
	BYTE 049h,091h,080h,049h,024h,049h,049h,049h,080h,091h,000h,000h,000h,000h,000h,024h
	BYTE 024h,024h,049h,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,091h,0e0h,0e0h,080h
	BYTE 0b6h,091h,091h,091h,091h,091h,049h,024h,080h,0b6h,091h,0b6h,091h,049h,080h,024h
	BYTE 049h,049h,049h,049h,080h,091h,049h,049h,049h,049h,049h,024h,024h,080h,080h,080h
	BYTE 049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0e0h,080h,080h,0ffh,0ffh,049h,049h,049h
	BYTE 049h,049h,024h,0e3h,0b6h,0b6h,091h,091h,0b6h,091h,024h,049h,049h,049h,049h,049h
	BYTE 024h,0e3h,024h,024h,024h,024h,024h,024h,0ffh,0ffh,080h,080h,080h,080h,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0e0h,080h,0ffh,0ffh,0ffh,0e0h,0ffh,0e0h,0e0h,0e0h,0e0h,080h,080h
	BYTE 0ffh,0b6h,049h,049h,049h,0b6h,091h,024h,024h,024h,024h,024h,0ffh,0e0h,0e0h,080h
	BYTE 080h,080h,080h,080h,080h,0ffh,0ffh,0ffh,080h,080h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0e0h,0e0h,0e0h,0e0h,080h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0b6h,091h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0e0h,080h,080h,080h,080h,080h
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,091h,024h
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,091h,024h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,091h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0e0h,024h,080h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,080h,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
fighter_001 EECS205BITMAP <41, 45, 255,, offset fighter_001 + sizeof fighter_001>
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,049h,024h,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,049h,0b6h,049h,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,0ffh,0e0h,0e0h
  	BYTE 080h,080h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0e0h,0e0h,0e0h,080h,080h,080h,080h,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,091h,049h
  	BYTE 013h,049h,00ah,024h,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,091h,049h,013h,0ffh,00ah,024h,049h,024h,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h
  	BYTE 091h,013h,013h,0ffh,00ah,00ah,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,091h,013h,013h,013h,00ah,00ah,049h
  	BYTE 024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,049h,0b6h,013h,013h,013h,00ah,00ah,091h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,091h,0b6h,049h,013h,013h,00ah
  	BYTE 024h,091h,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,049h,091h,091h,0b6h,049h,0ffh,024h,091h,049h,049h,024h,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,049h,091h,091h,0b6h
  	BYTE 091h,091h,049h,049h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,049h,049h,091h,091h,091h,049h,049h,049h,049h,024h,024h,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0e0h,0e0h,080h,0ffh,0ffh,0ffh,049h,091h,049h
  	BYTE 049h,091h,049h,049h,024h,024h,049h,024h,0ffh,0ffh,0ffh,080h,080h,080h,080h,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0e0h,0ffh
  	BYTE 0e0h,0e0h,080h,080h,0ffh,049h,091h,091h,0b6h,091h,049h,049h,024h,049h,049h,049h
  	BYTE 049h,024h,0ffh,0e0h,080h,080h,080h,080h,080h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0e0h,049h,049h,049h,024h,080h,0ffh,049h,091h
  	BYTE 0b6h,0b6h,091h,091h,049h,049h,049h,049h,049h,049h,024h,0ffh,0e0h,024h,024h,024h
  	BYTE 024h,080h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0b6h,091h,091h,091h,049h,024h,049h,091h,091h,0b6h,091h,091h,091h,049h,049h,049h
  	BYTE 049h,049h,049h,049h,024h,091h,049h,049h,049h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,091h,091h,091h,049h,024h,0ffh
  	BYTE 049h,0b6h,091h,091h,091h,091h,049h,049h,049h,049h,049h,049h,024h,0e0h,091h,049h
  	BYTE 049h,049h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0b6h,091h,091h,091h,049h,024h,0e0h,0ffh,049h,049h,091h,091h,091h,049h
  	BYTE 049h,049h,049h,024h,024h,0e0h,080h,091h,049h,049h,049h,024h,024h,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,091h,091h,091h,049h
  	BYTE 024h,0e0h,0e0h,049h,091h,049h,049h,049h,049h,024h,024h,024h,049h,024h,080h,080h
  	BYTE 091h,049h,049h,049h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,091h,049h,049h,049h,049h,024h,024h,0e0h,0e0h,0b6h,049h,0b6h,0b6h
  	BYTE 091h,080h,049h,049h,049h,024h,049h,080h,080h,049h,024h,024h,024h,024h,024h,024h
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,091h,091h,091h
  	BYTE 091h,091h,049h,024h,0e0h,0b6h,049h,091h,0b6h,091h,080h,049h,049h,024h,024h,049h
  	BYTE 080h,091h,049h,049h,049h,049h,049h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,049h,0b6h,091h,091h,091h,091h,091h,049h,024h,0e0h,0b6h,049h
  	BYTE 0b6h,091h,049h,080h,024h,024h,049h,024h,049h,080h,091h,049h,049h,049h,049h,049h
  	BYTE 024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,049h,0b6h,091h
  	BYTE 091h,000h,091h,091h,049h,024h,0e0h,0b6h,091h,049h,0b6h,091h,080h,049h,049h,024h
  	BYTE 049h,049h,080h,091h,049h,049h,000h,049h,049h,024h,024h,024h,024h,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,091h,091h,049h,0b6h,091h,000h,0fch,000h,091h,049h,024h,0e0h
  	BYTE 0b6h,091h,049h,091h,091h,080h,049h,024h,024h,049h,049h,080h,091h,049h,000h,090h
  	BYTE 000h,049h,024h,024h,024h,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h,091h,049h
  	BYTE 0b6h,000h,0fch,000h,0fch,000h,049h,024h,0e0h,0b6h,091h,049h,0b6h,049h,080h,024h
  	BYTE 049h,024h,049h,049h,080h,091h,000h,090h,000h,090h,000h,024h,024h,024h,049h,024h
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,091h,049h,0e0h,0b6h,000h,000h,000h,000h,000h,049h
  	BYTE 024h,080h,0b6h,091h,091h,049h,091h,080h,049h,024h,049h,049h,049h,080h,091h,000h
  	BYTE 000h,000h,000h,000h,024h,024h,024h,049h,049h,024h,0ffh,0ffh,0ffh,091h,091h,0e0h
  	BYTE 0e0h,080h,0b6h,091h,091h,091h,091h,091h,049h,024h,080h,0b6h,091h,0b6h,091h,049h
  	BYTE 080h,024h,049h,049h,049h,049h,080h,091h,049h,049h,049h,049h,049h,024h,024h,080h
  	BYTE 080h,080h,049h,024h,0ffh,0ffh,0ffh,0e0h,080h,080h,0ffh,0ffh,049h,049h,049h,049h
  	BYTE 049h,024h,0e3h,0b6h,0b6h,091h,091h,0b6h,091h,024h,049h,049h,049h,049h,049h,024h
  	BYTE 0e3h,024h,024h,024h,024h,024h,024h,0ffh,0ffh,080h,080h,080h,080h,0ffh,0ffh,0e0h
  	BYTE 080h,0ffh,0ffh,0ffh,0e0h,0ffh,0e0h,0e0h,0e0h,0e0h,080h,080h,0ffh,0b6h,049h,049h
  	BYTE 049h,0b6h,091h,024h,024h,024h,024h,024h,0ffh,0e0h,0e0h,080h,080h,080h,080h,080h
  	BYTE 080h,0ffh,0ffh,0ffh,080h,080h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0e0h
  	BYTE 0e0h,0e0h,0e0h,080h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,091h,024h,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0e0h,080h,080h,080h,080h,080h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0b6h,091h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 00fh,00fh,00fh,00fh,00fh,00fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,091h,024h,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,00fh,00fh,00fh,00fh,00fh,00fh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,00fh,017h,017h,017h,017h,017h,017h,00fh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,091h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,00fh,017h,017h
  	BYTE 017h,017h,017h,017h,00fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,00fh,017h,017h,0ffh,0ffh,017h,017h,00fh,0ffh,0ffh,0ffh,0ffh,0ffh,0e0h,024h
  	BYTE 080h,0ffh,0ffh,0ffh,0ffh,0ffh,00fh,017h,017h,0ffh,0ffh,017h,017h,00fh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,00fh,017h,017h,0ffh,0ffh,0ffh,0ffh
  	BYTE 017h,017h,00fh,0ffh,0ffh,0ffh,0ffh,0ffh,080h,0ffh,0ffh,0ffh,0ffh,0ffh,00fh,017h
  	BYTE 017h,0ffh,0ffh,0ffh,0ffh,017h,017h,00fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,00fh,017h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,017h,00fh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,00fh,017h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,017h
  	BYTE 00fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,00fh,017h,017h,0ffh,0ffh
  	BYTE 0ffh,0ffh,017h,017h,00fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 00fh,017h,017h,0ffh,0ffh,0ffh,0ffh,017h,017h,00fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,00fh,017h,0ffh,0ffh,0ffh,0ffh,017h,00fh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,00fh,017h,0ffh,0ffh,0ffh,0ffh
  	BYTE 017h,00fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,00fh,017h
  	BYTE 017h,0ffh,0ffh,017h,017h,00fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,00fh,017h,017h,0ffh,0ffh,017h,017h,00fh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,00fh,017h,017h,017h,017h,00fh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,00fh,017h,017h
  	BYTE 017h,017h,00fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,00fh,017h,017h,00fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,00fh,017h,017h,00fh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,00fh,00fh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,00fh,00fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
  	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh
fighter_002 EECS205BITMAP <41, 41, 255,, offset fighter_002 + sizeof fighter_002>
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,049h,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,0b6h,049h,049h,024h
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,049h,0ffh,0e0h,0e0h,080h,080h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0e0h,0e0h,0e0h,080h
    	BYTE 080h,080h,080h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,049h,091h,049h,013h,049h,00ah,024h,049h,024h,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,091h,049h
    	BYTE 013h,0ffh,00ah,024h,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,091h,013h,013h,0ffh,00ah,00ah,049h,024h,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h
    	BYTE 091h,013h,013h,013h,00ah,00ah,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,0b6h,013h,013h,013h,00ah,00ah,091h
    	BYTE 024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 049h,091h,0b6h,049h,013h,013h,00ah,024h,091h,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,091h,091h,0b6h,049h,0ffh,024h
    	BYTE 091h,049h,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,049h,049h,091h,091h,0b6h,091h,091h,049h,049h,024h,024h,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,049h,091h,091h,091h
    	BYTE 049h,049h,049h,049h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0e0h,0e0h
    	BYTE 080h,0ffh,0ffh,0ffh,049h,091h,049h,049h,091h,049h,049h,024h,024h,049h,024h,0ffh
    	BYTE 0ffh,0ffh,080h,080h,080h,080h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0e0h,0ffh,0e0h,0e0h,080h,080h,0ffh,049h,091h,091h,0b6h
    	BYTE 091h,049h,049h,024h,049h,049h,049h,049h,024h,0ffh,0e0h,080h,080h,080h,080h,080h
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0e0h,049h
    	BYTE 049h,049h,024h,080h,0ffh,049h,091h,0b6h,0b6h,091h,091h,049h,049h,049h,049h,049h
    	BYTE 049h,024h,0ffh,0e0h,024h,024h,024h,024h,080h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,091h,091h,091h,049h,024h,049h,091h,091h
    	BYTE 0b6h,091h,091h,091h,049h,049h,049h,049h,049h,049h,049h,024h,091h,049h,049h,049h
    	BYTE 024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0b6h,091h,091h,091h,049h,024h,0ffh,049h,0b6h,091h,091h,091h,091h,049h,049h,049h
    	BYTE 049h,049h,049h,024h,0e0h,091h,049h,049h,049h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,091h,091h,091h,049h,024h,0e0h
    	BYTE 0ffh,049h,049h,091h,091h,091h,049h,049h,049h,049h,024h,024h,0e0h,080h,091h,049h
    	BYTE 049h,049h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0b6h,091h,091h,091h,049h,024h,0e0h,0e0h,049h,091h,049h,049h,049h,049h
    	BYTE 024h,024h,024h,049h,024h,080h,080h,091h,049h,049h,049h,024h,024h,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,049h,049h,049h,049h,024h
    	BYTE 024h,0e0h,0e0h,0b6h,049h,0b6h,0b6h,091h,080h,049h,049h,049h,024h,049h,080h,080h
    	BYTE 049h,024h,024h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0b6h,091h,091h,091h,091h,091h,049h,024h,0e0h,0b6h,049h,091h,0b6h
    	BYTE 091h,080h,049h,049h,024h,024h,049h,080h,091h,049h,049h,049h,049h,049h,024h,024h
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,0b6h,091h,091h,091h
    	BYTE 091h,091h,049h,024h,0e0h,0b6h,049h,0b6h,091h,049h,080h,024h,024h,049h,024h,049h
    	BYTE 080h,091h,049h,049h,049h,049h,049h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,049h,049h,0b6h,091h,091h,000h,091h,091h,049h,024h,0e0h,0b6h,091h
    	BYTE 049h,0b6h,091h,080h,049h,049h,024h,049h,049h,080h,091h,049h,049h,000h,049h,049h
    	BYTE 024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,091h,049h,0b6h,091h
    	BYTE 000h,0fch,000h,091h,049h,024h,0e0h,0b6h,091h,049h,091h,091h,080h,049h,024h,024h
    	BYTE 049h,049h,080h,091h,049h,000h,090h,000h,049h,024h,024h,024h,049h,024h,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,091h,0b6h,091h,049h,0b6h,000h,0fch,000h,0fch,000h,049h,024h,0e0h
    	BYTE 0b6h,091h,049h,0b6h,049h,080h,024h,049h,024h,049h,049h,080h,091h,000h,090h,000h
    	BYTE 090h,000h,024h,024h,024h,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,091h,049h,0e0h
    	BYTE 0b6h,000h,000h,000h,000h,000h,049h,024h,080h,0b6h,091h,091h,049h,091h,080h,049h
    	BYTE 024h,049h,049h,049h,080h,091h,000h,000h,000h,000h,000h,024h,024h,024h,049h,049h
    	BYTE 024h,0ffh,0ffh,0ffh,091h,091h,0e0h,0e0h,080h,0b6h,091h,091h,091h,091h,091h,049h
    	BYTE 024h,080h,0b6h,091h,0b6h,091h,049h,080h,024h,049h,049h,049h,049h,080h,091h,049h
    	BYTE 049h,049h,049h,049h,024h,024h,080h,080h,080h,049h,024h,0ffh,0ffh,0ffh,0e0h,080h
    	BYTE 080h,0ffh,0ffh,049h,049h,049h,049h,049h,024h,0e3h,0b6h,0b6h,091h,091h,0b6h,091h
    	BYTE 024h,049h,049h,049h,049h,049h,024h,0e3h,024h,024h,024h,024h,024h,024h,0ffh,0ffh
    	BYTE 080h,080h,080h,080h,0ffh,0ffh,0e0h,080h,0ffh,0ffh,0ffh,0e0h,0ffh,0e0h,0e0h,0e0h
    	BYTE 0e0h,080h,080h,0ffh,0b6h,049h,049h,049h,0b6h,091h,024h,024h,024h,024h,024h,0ffh
    	BYTE 0e0h,0e0h,080h,080h,080h,080h,080h,080h,0ffh,0ffh,0ffh,080h,080h,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0e0h,0e0h,0e0h,0e0h,080h,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0b6h,091h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0e0h,080h,080h,080h,080h,080h
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,091h,024h,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,00fh,00fh,00fh,00fh,00fh,00fh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0b6h,091h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,00fh,00fh,00fh,00fh
    	BYTE 00fh,00fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,00fh
    	BYTE 017h,017h,017h,017h,017h,017h,00fh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,091h,024h,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,00fh,017h,017h,017h,017h,017h,017h,00fh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,00fh,017h,017h,0ffh,0ffh,0ffh,0ffh,017h,017h
    	BYTE 00fh,0ffh,0ffh,0ffh,0ffh,0e0h,024h,080h,0ffh,0ffh,0ffh,0ffh,00fh,017h,017h,0ffh
    	BYTE 0ffh,0ffh,0ffh,017h,017h,00fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 00fh,017h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,017h,00fh,0ffh,0ffh,0ffh,0ffh,0ffh,080h
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,00fh,017h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,017h,00fh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,00fh,017h,017h,0ffh,0ffh,0ffh,0ffh
    	BYTE 017h,017h,00fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,00fh,017h
    	BYTE 017h,0ffh,0ffh,0ffh,0ffh,017h,017h,00fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,00fh,017h,017h,0ffh,0ffh,017h,017h,00fh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,00fh,017h,017h,0ffh,0ffh,017h,017h,00fh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,00fh,017h,017h
    	BYTE 017h,017h,00fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,00fh,017h,017h,017h,017h,00fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,00fh,00fh,00fh,00fh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,00fh,00fh,00fh,00fh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    	BYTE 0ffh
;;all sprites
ASTEROID_1 SPRITE <offset asteroid_001, 200, 80, 0>
ASTEROID_2 SPRITE <offset asteroid_002, 400, 80, 0>
FIGHTER SPRITE <offset fighter_000, 500, 400, 0>
POWER_FIGHTER SPRITE <offset fighter_002, 400, 400, 0>
EVIL_FIGHTER SPRITE <offset fighter_001, 100, 80, 0fffcebb4h>
NUKE SPRITE <offset nuke_000, ?, 400, 0>

;; Strings
nicejobStr BYTE "Nice Job!", 0
guideStr BYTE "Press left and right arrow key to move", 0
guideStr1 BYTE "Press left mouse to shoot", 0
instructionStr BYTE "Avoid the enemy fighter flying toward you and", 0
inst2Str BYTE "stay away from it as far as you can even when it is off-screen", 0
inst3Str BYTE "Press P on keyboard to POWER UP your fighter", 0
inst4Str BYTE "Press Space to pause the game", 0
pauseStr BYTE "Game paused. Press any key other than space key to resume the game.", 0
deadStr BYTE "BOOM! DETECTED BY ENEMY! GAME OVER!", 0
winStr BYTE "CONGRATS YOU WIN!", 0

;;sound
sndPath BYTE "bomb.wav", 0

;; Game Variables
GRAVITY DWORD 0
GRAVITY2 DWORD 0
rollingDistance DWORD 0
gamePaused DWORD 0
nukeShoot DWORD 0
nukeHit DWORD 0
asteroid1Collide DWORD 0
asteroid2Collide DWORD 0
hitByEvil DWORD 0
powerup DWORD 0
velocity DWORD 5

.CODE

;;moveAsteroid moves asteroids downward
moveEvil PROC uses ecx ebx newX:DWORD
  mov ecx, offset EVIL_FIGHTER
  mov ebx, (SPRITE PTR [ecx]).y
  cmp ebx, 500 ;; make it disappear for a while and show at the top again
  jg show_again
  mov eax, GRAVITY2
  shl eax, 1
  ;mov eax, 2
  add ebx, 2
  mov (SPRITE PTR [ecx]).y, ebx
  INVOKE RotateBlit, (SPRITE PTR [ecx]).obj, (SPRITE PTR[ecx]).x, (SPRITE PTR [ecx]).y, (SPRITE PTR [ecx]).rotation
  add GRAVITY2, 1
  jmp return

show_again:
  mov (SPRITE PTR [ecx]).y, 0
  ;INVOKE nrandom, 100
  mov eax, newX
  mov (SPRITE PTR [ecx]).x, eax
  INVOKE RotateBlit, (SPRITE PTR [ecx]).obj, (SPRITE PTR[ecx]).x, (SPRITE PTR [ecx]).y, (SPRITE PTR [ecx]).rotation
  mov GRAVITY2, 0

return:
  ret
moveEvil ENDP

ComputeLeft PROC USES ebx x:DWORD, mywidth:DWORD
  mov eax, x
  mov ebx, mywidth
  shl ebx, 1
  sub eax, ebx   ; x-width/2
  ret
ComputeLeft ENDP

ComputeRight PROC USES ebx x:DWORD, mywidth:DWORD
  mov eax, x
  mov ebx, mywidth
  shl ebx, 1
  add eax, ebx  ;x+width/2
  ret
ComputeRight ENDP

ComputeTop PROC USES ebx y:DWORD, height:DWORD
  mov eax, y
  mov ebx, height
  shl ebx, 1
  sub eax, ebx  ;y-height/2
  ret
ComputeTop ENDP

ComputeBottom PROC USES ebx y:DWORD, height:DWORD
  mov eax, y
  mov ebx, height
  shl ebx, 1
  add eax, ebx  ;y+height/2
  ret
ComputeBottom ENDP


CheckIntersect PROC USES ebx ecx edi esi oneX:DWORD, oneY:DWORD, oneBitmap:PTR EECS205BITMAP, twoX:DWORD, twoY:DWORD, twoBitmap:PTR EECS205BITMAP
  LOCAL oneWidth:DWORD, oneHeight:DWORD, twoWidth:DWORD, twoHeight:DWORD

  mov ebx, oneBitmap    ;;get one's width and height
  mov edi, (EECS205BITMAP PTR[ebx]).dwWidth
  mov oneWidth, edi
  mov edi, (EECS205BITMAP PTR[ebx]).dwHeight
  mov oneHeight, edi

  mov ecx, twoBitmap    ;; get two's width and height
  mov esi, (EECS205BITMAP PTR[ecx]).dwWidth
  mov twoWidth, esi
  mov esi, (EECS205BITMAP PTR[ecx]).dwHeight
  mov twoHeight, esi

  INVOKE ComputeRight, oneX, oneWidth
  mov edi, eax                        ;; edi=right edge of box one
  INVOKE ComputeLeft, twoX, twoWidth
  mov esi, eax                        ;; esi=left edge of box two
  cmp edi, esi
  jl no_intersect           ;; if right edge of one is less than left edge then no intersect

  INVOKE ComputeLeft, oneX, oneWidth
  mov edi, eax
  INVOKE ComputeRight, twoX, twoWidth
  mov esi, eax
  cmp edi, esi
  jg no_intersect

  INVOKE ComputeBottom, oneY, oneHeight
  mov edi, eax
  INVOKE ComputeTop, twoY, twoHeight
  mov esi, eax
  cmp edi, esi
  jl no_intersect      ;; if the bottom of box one is less than the top of the box

  INVOKE ComputeTop, oneY, oneHeight
  mov edi, eax
  INVOKE ComputeBottom, twoY, twoHeight
  mov esi, eax
  cmp edi, esi
  jg no_intersect

  mov eax, 1   ; return 1 if there is intersect
  jmp result

no_intersect:
  mov eax, 0

result:
  ret 			; Don't delete this line!!!
CheckIntersect ENDP
;; Note: You will need to implement CheckIntersect!!!

;; a helper function to call CheckIntersect
CheckCollisions PROC uses ebx ecx one: PTR SPRITE, two: PTR SPRITE
  mov ebx, one
  mov ecx, two
  INVOKE CheckIntersect, (SPRITE PTR [ebx]).x, (SPRITE PTR [ebx]).y, (SPRITE PTR [ebx]).obj, (SPRITE PTR [ecx]).x, (SPRITE PTR [ecx]).y, (SPRITE PTR [ecx]).obj

  ret
CheckCollisions ENDP

;; Checks if the nuke hits the target asteroid
CheckAsteroid1Hit PROC
	INVOKE CheckCollisions, offset NUKE, offset ASTEROID_1
  cmp eax, 0
  je FINISH
  mov nukeHit, 1   ;; if intersect, then nuke indeed hit the target
  mov asteroid1Collide, 1
FINISH:
	ret
CheckAsteroid1Hit ENDP

CheckHitByEvil PROC
  INVOKE CheckCollisions, offset FIGHTER, offset EVIL_FIGHTER
  cmp eax, 0
  je not_hit
  mov hitByEvil, 1
not_hit:
  ret
CheckHitByEvil ENDP

;;
CheckAsteroid2Hit PROC
	INVOKE CheckCollisions, offset NUKE, offset ASTEROID_2
  cmp eax, 0
  je FINISH
  mov nukeHit, 1   ;; if intersect, then nuke indeed hit the target
  mov asteroid2Collide, 1
FINISH:
	ret
CheckAsteroid2Hit ENDP


; Draws nuke
DrawNuke PROC uses ecx ebx

	cmp nukeShoot, 1 ;; draw the nuke only when nuke is shot
	jne FINISH
  cmp nukeHit, 1
  je reset_nuke
  mov eax, GRAVITY
  shl eax, 1
	mov ecx, OFFSET NUKE
	sub (SPRITE PTR [ecx]).y, eax
  ;INVOKE SetNukeXPosition
  mov ebx, offset FIGHTER
  mov ecx, (SPRITE PTR [ebx]).x
  mov ebx, offset NUKE
  mov (SPRITE PTR [ebx]).x, ecx
  mov ecx, OFFSET NUKE
	INVOKE RotateBlit, (SPRITE PTR [ecx]).obj, (SPRITE PTR[ecx]).x, (SPRITE PTR [ecx]).y, (SPRITE PTR [ecx]).rotation
	add GRAVITY, 1
  cmp (SPRITE PTR [ecx]).y, 0
  jg FINISH

reset_nuke:
	; if nuke is out of boud or already hit a target, user can re-shoot a new one
	mov nukeShoot, 0
  mov nukeHit, 0
	mov GRAVITY, 0
  INVOKE SetNukePosition

FINISH:
	ret
DrawNuke ENDP

RollAllStars PROC
  INVOKE DrawStarField, rollingDistance
  mov eax, rollingDistance
  add eax, 175
  cmp eax, 500
  jl add_one
  mov rollingDistance, 0
  sub rollingDistance, 300
  jmp return
add_one:
  add rollingDistance, 1
return:
  ret
RollAllStars ENDP

; Draws all sprites on the screen
DrawAllSprites PROC uses ecx
  cmp asteroid1Collide, 1
  je DRAW_ASTEROID2   ;; draw #2, the smaller one if nuke didn't hit the target
  mov ecx, OFFSET ASTEROID_1
	INVOKE RotateBlit, (SPRITE PTR [ecx]).obj, (SPRITE PTR [ecx]).x, (SPRITE PTR [ecx]).y, (SPRITE PTR [ecx]).rotation
DRAW_ASTEROID2:
  cmp asteroid2Collide, 1
  je DRAW_REST
  mov ecx, OFFSET ASTEROID_2
  INVOKE RotateBlit, (SPRITE PTR [ecx]).obj, (SPRITE PTR [ecx]).x, (SPRITE PTR [ecx]).y, (SPRITE PTR [ecx]).rotation

DRAW_REST:
	mov ecx, OFFSET FIGHTER

	INVOKE RotateBlit, (SPRITE PTR [ecx]).obj, (SPRITE PTR [ecx]).x, (SPRITE PTR [ecx]).y, (SPRITE PTR [ecx]).rotation

  INVOKE DrawNuke

;INVOKE moveEvil

	ret
DrawAllSprites ENDP

;;SetNukeXPosition sets the x pos of nuke the same with the fighter
SetNukeXPosition PROC uses ebx ecx
  mov ebx, offset FIGHTER
  mov ecx, (SPRITE PTR [ebx]).x
  mov ebx, offset NUKE
  mov (SPRITE PTR [ebx]).x, ecx
SetNukeXPosition ENDP


;;SetNukePosition so that it shoots from the fighter
SetNukePosition PROC uses ebx ecx
  mov ebx, offset FIGHTER
  mov ecx, (SPRITE PTR [ebx]).x
  mov ebx, offset NUKE
  mov (SPRITE PTR [ebx]).x, ecx

  mov ebx, offset FIGHTER
  mov ecx, (SPRITE PTR [ebx]).y
  mov ebx, offset NUKE
  mov (SPRITE PTR [ebx]).y, ecx

  ret
SetNukePosition ENDP

DrawAllStrings PROC

  INVOKE DrawStr, offset guideStr, 20, 10, 0ffh
  INVOKE DrawStr, offset guideStr1, 20, 20, 0ffh
  INVOKE DrawStr, offset instructionStr, 20, 30, 0ffh
  INVOKE DrawStr, offset inst2Str, 20, 40, 0ffh
  INVOKE DrawStr, offset inst3Str, 20, 50, 0ffh
  INVOKE DrawStr, offset inst4Str, 20, 60, 0ffh

FINISH:
  ret
DrawAllStrings ENDP

; clearn screen
ClearScreen PROC
  mov eax, 0
  mov edi, ScreenBitsPtr
  mov ecx, 307200
  REP STOSB

  ret
ClearScreen ENDP

GameOver PROC
  INVOKE ClearScreen
  INVOKE DrawStr, offset deadStr, 200, 220, 0ffh
  INVOKE PlaySound, offset sndPath, 0, SND_FILENAME
  ret
GameOver ENDP

CheckGameIsPaused PROC
  INVOKE SpaceOn
  cmp eax, 0
  jl not_paused
  mov gamePaused, 1
  jmp RETURN

not_paused:
  mov gamePaused, 0
RETURN:
  ret
CheckGameIsPaused ENDP

;;screen when game is paused
GamePausedScreen PROC
  INVOKE DrawStr, offset pauseStr, 50, 200, 0ffh
  ret
GamePausedScreen ENDP

WinGame PROC
  INVOKE ClearScreen
  INVOKE DrawStr, offset winStr, 220, 220, 0ffh
no_win:
  ret
WinGame ENDP

GameInit PROC
  ; INVOKE BasicBlit, offset asteroid_002, 200, 200
  ; INVOKE BasicBlit, offset fighter_000, 200, 400
  rdtsc
  invoke nseed, eax


  INVOKE SetNukePosition
  INVOKE RollAllStars
  INVOKE DrawAllSprites
  ;invoke PlaySound, offset sndPath, 0, SND_FILENAME


	ret         ;; Do not delete this line!!!
GameInit ENDP


GamePlay PROC

  INVOKE ClearScreen ;;clear the screen
  INVOKE CheckGameIsPaused
  cmp gamePaused, 1
  jne START_GAME
  INVOKE GamePausedScreen ;;draw the pause screen
  jmp RETURN

START_GAME:
  INVOKE RollAllStars
  INVOKE PKeyOn
  cmp eax, 0
  jl CHECK_POWERUP
  mov powerup, 1

CHECK_POWERUP:
  cmp powerup, 1
  jne CHECK_RIGHTKEY
  mov velocity, 10

CHECK_RIGHTKEY:
  INVOKE RightArrowOn
  cmp eax, 0
  jl CHECK_LEFTKEY
  INVOKE MoveRight, offset FIGHTER, velocity ;; move right when right key is pressed

CHECK_LEFTKEY:
  INVOKE LeftArrowOn
  cmp eax, 0
  jl CHECK_LEFTMOUSE
  INVOKE MoveLeft, offset FIGHTER, velocity ;; move fighter left

CHECK_LEFTMOUSE:
  cmp nukeShoot, 1
  INVOKE LeftMouseOn
  cmp eax, 0
  jl check_win
  mov nukeShoot, 1 ;; if left mouse is pressed, shoot the nuke

check_win:
  cmp asteroid1Collide, 1
  jne check_hit
  cmp asteroid2Collide, 1
  jne check_hit
  INVOKE WinGame
  jmp RETURN

check_hit:
    INVOKE CheckHitByEvil
    cmp hitByEvil, 1
    jne FINISH
    INVOKE GameOver
    jmp RETURN
FINISH:
    INVOKE CheckAsteroid1Hit ;; set nukehit variable
    INVOKE CheckAsteroid2Hit
    INVOKE DrawAllSprites
    INVOKE DrawAllStrings
    invoke nrandom, 600
    INVOKE moveEvil, eax
RETURN:
	ret         ;; Do not delete this line!!!
GamePlay ENDP

END
