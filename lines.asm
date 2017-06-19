; #########################################################################
;
;   lines.asm - Assembly file for EECS205 Assignment 2
;
;   Name: Danqi Liao
; #########################################################################

      .586
      .MODEL FLAT,STDCALL
      .STACK 4096
      option casemap :none  ; case sensitive

include stars.inc
include lines.inc

.DATA

	;; If you need to, you can place global variables here

.CODE


;; Don't forget to add the USES the directive here
;;   Place any registers that you modify (either explicitly or implicitly)
;;   into the USES list so that caller's values can be preserved

;;   For example, if your procedure uses only the eax and ebx registers
DrawLine PROC USES eax ebx edx ecx x0:DWORD, y0:DWORD, x1:DWORD, y1:DWORD, color:DWORD
	;; Feel free to use local variables...declare them here
	;; For example:
	;; 	LOCAL foo:DWORD, bar:DWORD

	;; Place your code here
  LOCAL delta_x:DWORD, delta_y:DWORD, inc_x:DWORD, inc_y:DWORD, curr_x:DWORD, curr_y:DWORD, error:DWORD, prev_error:DWORD
       mov eax, x1
       sub eax, x0
       cmp eax, 0 ;;if negative, do ~delta_x+1 to get the abs value
       jge positive_x
       not eax
       add eax, 1
  positive_x:
       mov delta_x, eax     ;;delta_x = abs(x1-x0)

       mov eax, y1
       sub eax, y0
       cmp eax, 0
       jge positive_y
       not eax
       add eax, 1
  positive_y:
       mov delta_y, eax     ;;delta_y = abs(y1-y0)

       mov inc_x, 1     ;;assign inc_x and inc_y
       mov eax, x0
       cmp eax, x1
       jb positive_inc_x
       mov inc_x, -1
  positive_inc_x:
       mov inc_y, 1
       mov eax, y0
       cmp eax, y1
       jb positive_inc_y
       mov inc_y, -1

  positive_inc_y:
       mov edx, 0       ;; compute error
       mov eax, delta_x
       mov ecx, 2
       div ecx
       mov error, eax

       mov eax, delta_x
       cmp eax, delta_y
       ja positive_error
       mov edx, 0
       mov eax, delta_y
       div ecx
       not eax
       add eax, 1
       mov error, eax

  positive_error:
       mov eax, x0
       mov edx, y0
       mov curr_x, eax
       mov curr_y, edx
       INVOKE DrawPixel, curr_x, curr_y, color

       mov eax, x1
       mov edx, y1
       jmp eval ;;test condition  ;; eax = x1, edx = y1, ecx = error
  do:
       INVOKE DrawPixel, curr_x, curr_y, color
       mov ecx, error   ;; ecx = error
       mov prev_error, ecx

       mov ebx, delta_x
       not ebx
       add ebx, 1
       cmp prev_error, ebx
       jle no_update_x
       mov ebx, delta_y    ;; only update if prev_error > -delta_x
       sub error, ebx
       mov ebx, inc_x
       add curr_x, ebx
  no_update_x:
       mov ebx, delta_y
       cmp prev_error, ebx
       jge eval
       mov ebx, delta_x
       add error, ebx
       mov ebx, inc_y
       add curr_y, ebx
  eval:
       cmp curr_x, eax
       jne do
       cmp curr_y, edx
       jne do

	ret        	;;  Don't delete this line...you need it
DrawLine ENDP




END
