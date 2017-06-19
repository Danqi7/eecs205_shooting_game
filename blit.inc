; #########################################################################
;
;   blit.inc - Includes for EECS205 Assignment 3
;
;
; #########################################################################


_EECS205BITMAP STRUCT
 dwWidth      DWORD  ?
 dwHeight     DWORD  ?
 bTransparent BYTE   ?
              BYTE   3 DUP(?)
 lpBytes      DWORD  ?
_EECS205BITMAP ENDS

EECS205BITMAP TYPEDEF _EECS205BITMAP
BITMAPPTR TYPEDEF PTR EECS205BITMAP

;; Sprite Struct : Keeps track of x,y coordinates and rotation of a sprite
_SPRITE STRUCT
 obj        BITMAPPTR ?  			; pointer to the bitmap data
 x          DWORD ? 		; the x-coordinate location
 y          DWORD ?		; the y-coordinate location
 rotation   FXPT ?		; rotation in fxpt angle
_SPRITE ENDS

SPRITE TYPEDEF _SPRITE

EXTERNDEF ScreenBitsPtr:DWORD

BasicBlit PROTO STDCALL ptrBitmap:PTR EECS205BITMAP, xcenter:DWORD, ycenter:DWORD

RotateBlit PROTO STDCALL ptrBitmap:PTR EECS205BITMAP, xcenter:DWORD, ycenter:DWORD, angle:FXPT


;; game helper Functions
LeftArrowOn PROTO
RightArrowOn PROTO
LeftMouseOn PROTO
SpaceOn PROTO
PKeyOn PROTO
MoveLeft PROTO sprite:DWORD, velocity:DWORD
MoveRight PROTO sprite:DWORD, velocity:DWORD
