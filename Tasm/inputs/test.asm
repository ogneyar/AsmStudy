; .model large

data segment
    questionOne db 'Whats your name? $'
    questionTwo db 'How old are you? $'
    sayHello db 'Hello, $'
    exclamationMark db '!$'
    lineBreak db 0Dh, 0Ah, '$'	
    min db 49, '$'; 49 -> 1 + 48 (18year + 48 = 64 not working)
    mid db 53, '$'; 53 -> 5 + 48 (30year + 48 = 78 not working)
    max db 56, '$'; 56 -> 8 + 48 (65year + 48 = 113 not working)
    youAreYoung db 'You are young!$'
    areYouMature db 'Are you mature!$'
    youAreAgrown db 'You are a grown!$'
    areYouOld db 'Are you old!$'

    nameInput label byte
    maxlength db 10
    actlength db 7
    nameField db 10 dup ('$')

    yearInput label byte
    yearMaxlength db 8
    yearActlength db 6
    yearField db 8 dup ('$')
data ends

stk segment stack
    db 256 dup ('')
stk ends

code segment
    assume cs:code, ds:data, ss:stk
    ;start:
    start proc far
        mov ax, data
        mov ds, ax

        ; ----------------
        mov ah, 09h; 09h (or 09) - output
		; ----------------
        lea dx, lineBreak; \r\n
        int 21h; interrupt
		; print question one
        ; lea dx, questionOne ; mov dx, offset questionOne ; (mojno tak ili edak)
        mov dx, offset questionOne; 'Whats your name? '
        int 21h; interrupt

		; ----------------
        mov ah, 0ah; 0ah - input
        ; ----------------
        lea dx, nameInput; name
        int 21h; interrupt

        ; ----------------
        mov ah, 09; output
		; ----------------
        lea dx, lineBreak; \r\n
        int 21h; interrupt
        lea dx, lineBreak; \r\n
        int 21h; interrupt
        lea dx, sayHello; 'Hello, '
        int 21h; interrupt
        lea dx, nameField; 'name'
        int 21h; interrupt
        ; lea dx, exclamationMark; '!'
        ; int 21h        
        lea dx, lineBreak; \r\n
        int 21h; interrupt
        lea dx, lineBreak; \r\n
        int 21h; interrupt
		; ----------------
		; print question two
		lea dx, questionTwo; 'How old are you? '
		int 21h; interrupt

        ; ----------------
        mov ah, 0ah; input
        ; ----------------
        lea dx, yearInput ; year
        int 21h; interrupt

        ; ----------------
        mov ah, 09; output
		; ----------------t
        lea dx, lineBreak; \r\n
        int 21h; interrupt
        lea dx, lineBreak; \r\n
        int 21h; interrupt
                
		; ----------------
        mov ah, yearField; client input year
		; sub ah, 0
        mov al, min; minimal (example: 18 year)
        ; ----------------
        cmp ah, al; compare
		jl young; if (ah < al) jump for label 'young' // client < 18 ?
        je young; equal ; client = 18 ? 
        ; jg mature; ah > al ; client > 18 ?

		; --- else ---

		; ---------------- 
		; client > 18
		; ---------------- 
        ; mov ah, yearField; client input year
        mov al, mid; middle (example: 30 year)
        ; ----------------
		cmp ah, al; compare
		jl mature; ah < al ; client < 30
        je mature; equal ; client = 30
        ; jg grown; ah > al ; client > 30

		; --- else ---

		; ---------------- 
		; client > 30
		; ----------------
        ; mov ah, yearField; client input year
        mov al, max; maximum (example: 65 year)
        ; ----------------
        cmp ah, al; compare
		jl grown; ah < al ; client < 65
        je grown; equal ; client = 65

		; --- else ---

		; ---------------- 
		; client > 65
		; ----------------
		mov ah, 09h; output
        lea dx, areYouOld; 'Are you old!'
        int 21h; interrupt
		jmp exit; jump on label 'exit'

      young:
        mov ah, 09h; output
        lea dx, youAreYoung; 'You are young!'
        int 21h; interrupt
        jmp exit; jump on label 'exit'
            
      mature:
        mov ah, 09h; output
        lea dx, areYouMature; 'Are you mature!'
        int 21h; interrupt
        jmp exit; jump on label 'exit'
            
      grown:
        mov ah, 09h; output
        lea dx, youAreAgrown; 'You are a grown!'
        int 21h; interrupt
        ; jmp exit; jump on label 'exit'
                    
      exit:
	  	mov ah, 09h; output
	  	lea dx, lineBreak; \r\n
        int 21h; interrupt
		; -------------
        mov ah, 4ch; exit
        int 21h; interrupt

        ret; return
        
    start endp; end procedure
    
code ends; end code segment

end start; end program

