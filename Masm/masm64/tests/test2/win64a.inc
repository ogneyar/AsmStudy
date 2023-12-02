OPTION DOTNAME
OPTION PROLOGUE:rbpFramePrologue
OPTION EPILOGUE:none
;---------------------------
include win64.inc
include temphls.inc
include kernel32.inc
includelib kernel32.lib
include ntdll.inc
includelib ntdll.lib
include user32.inc
includelib user32.lib
;---------------------------
pushaddr macro x
db 68h
dd x
endm
IMAGE_BASE equ 100400000h
;---------------------------------
include gdi32.inc
includelib gdi32.lib
;---------------------------------
include comctl32.inc
includelib comctl32.lib
include comdlg32.inc
includelib comdlg32.lib
include shell32.inc
includelib shell32.lib
;--------------------------------
du macro string
local bslash
bslash = 0
irpc c,<string>
if bslash eq 0
if '&c' eq "/"
        bslash = 1
elseif '&c'gt 127
db ('&c'- 0B0h),4
else
dw '&c'
endif
else
           bslash = 0
           if '&c' eq "n"
           DW 0Dh,0Ah
           elseif '&c' eq "/"
           dw '/'
           elseif '&c' eq "r"
           dw 0Dh
           elseif '&c' eq "l"
           dw 0Ah
           elseif '&c' eq "s"
           dw 20h
           elseif '&c' eq "c"
           dw 3Bh
           elseif '&c' eq "t"
           dw 9
   endif
endif
endm
dw 0
endm