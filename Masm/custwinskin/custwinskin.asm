.386
.model flat, stdcall
option casemap :none

include windows.inc

incboth macro incl
	include incl.inc
	includelib incl.lib
endm

m2m	macro	m1, m2
	push m2
	pop m1
ENDM

incboth kernel32
incboth user32
incboth gdi32

.const
	CAPTIONHEIGHT			=					16
	SIZEBORDER				=					4

	MINIMUMWIDTH			=					64
	MINIMUMHEIGHT			=					CAPTIONHEIGHT

	INNERBORDER				EQU					FALSE

.data
	szApplicationName		db					"Custom Window & Skins Example",0
	szBackMain				db					"images\back_01.bmp",0
	szBackCapt				db					"images\capt_01.bmp",0
	
	szSkinsMain				db					"skins\",0
	szSkinsMainFind			db					"skins\*.*",0
	szSkinsDefault			db					"default",0
	
	szSk_Title_Left			db					"\title_l.bmp",0
	szSk_Title_Right		db					"\title_r.bmp",0
	szSk_Title_Middle		db					"\title_m.bmp",0
	szSk_Title_Rollup		db					"\title_u.bmp",0
	szSk_Title_Minimize		db					"\title_n.bmp",0
	szSk_Title_Close		db					"\title_c.bmp",0
	szSk_Title_RollupS		db					"\title_us.bmp",0
	szSk_Title_RollupP		db					"\title_up.bmp",0
	szSk_Title_MinimizeS	db					"\title_ns.bmp",0
	szSk_Title_MinimizeP	db					"\title_np.bmp",0
	szSk_Title_CloseS		db					"\title_cs.bmp",0
	szSk_Title_CloseP		db					"\title_cp.bmp",0
	szSk_Title_Title		db					"\title_t.bmp",0
	szSk_Main_Back			db					"\main_b.bmp",0

.data?
	hInstance				HINSTANCE				?

	hSkinTitle_Left			HANDLE					?
	hSkinTitle_Right		HANDLE					?
	hSkinTitle_Middle		HANDLE					?
	hSkinTitle_Rollup		HANDLE					?
	hSkinTitle_Minimize		HANDLE					?
	hSkinTitle_Close		HANDLE					?
	hSkinTitle_RollupS		HANDLE					?
	hSkinTitle_RollupP		HANDLE					?
	hSkinTitle_MinimizeS	HANDLE					?
	hSkinTitle_MinimizeP	HANDLE					?
	hSkinTitle_CloseS		HANDLE					?
	hSkinTitle_CloseP		HANDLE					?
	hSkinTitle_Title		HANDLE					?
	hSkinMain_Back			HANDLE					?

	hbSkinTitle_Middle		HANDLE					?
	hbSkinMain_Back			HANDLE					?
	
	bCloseSelected			DWORD					?
	bClosePressed			DWORD					?
	bRollupSelected			DWORD					?
	bRollupPressed			DWORD					?
	bMinimizeSelected		DWORD					?
	bMinimizePressed		DWORD					?

	hCursNorm				HANDLE					?
	hCursMove				HANDLE					?
	hCursSH					HANDLE					?
	hCursSV					HANDLE					?
	hCursSTR				HANDLE					?
	hCursSTL				HANDLE					?

	dInitialHeight			DWORD					?

	WindowMoving			DWORD					?
	MovingStart				POINT					<?>
	CursorChange			DWORD					?

	SizeType				DWORD					?
	
.code

LoadSkinPart	PROC	lpszSkinsDir:DWORD, lpszPart:DWORD
	local szFullPath[MAX_PATH]:BYTE
	
	invoke lstrcpy, addr szFullPath, lpszSkinsDir
	invoke lstrcat, addr szFullPath, lpszPart 
	invoke LoadImage ,hInstance, addr szFullPath, IMAGE_BITMAP, 0, 0, LR_LOADFROMFILE
	ret
LoadSkinPart	ENDP

LoadSingle	MACRO	PieceOfVarible, bBrush
	invoke LoadSkinPart, addr szFullSkin, addr szSk_&PieceOfVarible
	mov hSkin&PieceOfVarible , eax
	IF bBrush
		invoke CreatePatternBrush	, eax
		mov hbSkin&PieceOfVarible, eax
	ENDIF
ENDM

UnLoadSingle	MACRO	PieceOfVarible, bBrush
	invoke DeleteObject	, hSkin&PieceOfVarible
	IF bBrush
		invoke DeleteObject	, hbSkin&PieceOfVarible
	ENDIF
ENDM

LoadSkin	PROC	lpszSkinName:DWORD
	local szFullSkin[MAX_PATH]:BYTE
	
	invoke lstrcpy, addr szFullSkin, addr szSkinsMain
	invoke lstrcat, addr szFullSkin, lpszSkinName 
	
	LoadSingle Title_Left, FALSE
	LoadSingle Title_Right, FALSE
	LoadSingle Title_Middle, TRUE
	LoadSingle Title_Rollup, FALSE
	LoadSingle Title_Minimize, FALSE
	LoadSingle Title_Close, FALSE
	LoadSingle Title_RollupS, FALSE
	LoadSingle Title_RollupP, FALSE
	LoadSingle Title_MinimizeS, FALSE
	LoadSingle Title_MinimizeP, FALSE
	LoadSingle Title_CloseS, FALSE
	LoadSingle Title_CloseP, FALSE
	LoadSingle Title_Title, FALSE
	LoadSingle Main_Back, TRUE
	
	ret
LoadSkin	ENDP

KillSkin	PROC

	UnLoadSingle Title_Left, FALSE
	UnLoadSingle Title_Right, FALSE
	UnLoadSingle Title_Middle, TRUE
	UnLoadSingle Title_Rollup, FALSE
	UnLoadSingle Title_Minimize, FALSE
	UnLoadSingle Title_Close, FALSE
	UnLoadSingle Title_RollupS, FALSE
	UnLoadSingle Title_RollupP, FALSE
	UnLoadSingle Title_MinimizeS, FALSE
	UnLoadSingle Title_MinimizeP, FALSE
	UnLoadSingle Title_CloseS, FALSE
	UnLoadSingle Title_CloseP, FALSE
	UnLoadSingle Title_Title, FALSE
	UnLoadSingle Main_Back, TRUE

	ret
KillSkin	ENDP

PointInRect	PROC	p:POINT, r:RECT
	mov eax, p.x
	.IF eax < r.left
		jmp @PointInRect_exit_bad
	.ENDIF
	.IF eax > r.right
		jmp @PointInRect_exit_bad
	.ENDIF
	mov eax, p.y
	.IF eax < r.top
		jmp @PointInRect_exit_bad
	.ENDIF
	.IF eax > r.bottom
		jmp @PointInRect_exit_bad
	.ENDIF
	mov eax, TRUE
	ret
@PointInRect_exit_bad:
	xor eax, eax
	ret
PointInRect	ENDP

LoadSkinNames	PROC	hList:DWORD
	local ffSkins		:WIN32_FIND_DATA
	local hff			:DWORD

	invoke SendMessage, hList, CB_ADDSTRING, 0, addr szSkinsDefault

	invoke FindFirstFile , addr szSkinsMainFind	, addr ffSkins
	.IF eax == INVALID_HANDLE_VALUE
		ret
	.ENDIF
	mov hff, eax
	.WHILE eax
		mov eax, ffSkins.dwFileAttributes
		and eax, FILE_ATTRIBUTE_DIRECTORY
		.IF eax
			.IF ffSkins.cFileName != '.'
				invoke lstrcmpi, addr szSkinsDefault, addr ffSkins.cFileName
				.IF eax 
					invoke SendMessage, hList, CB_ADDSTRING, 0, addr ffSkins.cFileName
				.ENDIF	
			.ENDIF
		.ENDIF 
		invoke FindNextFile, hff, addr ffSkins
	.ENDW
	
	invoke SendMessage	,hList, CB_SETCURSEL, 0, 0
	invoke SendMessage	,hList, CB_SHOWDROPDOWN, 0, 0
	invoke SetWindowPos	,hList, HWND_BOTTOM, 0, 0, 120, 90, SWP_NOMOVE

	ret
LoadSkinNames	ENDP

DlgProc	PROC	USES edi esi ebx	hDlg:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD
	local	r		:RECT
	local	p		:POINT

	local	hdc_db	:DWORD
	local	hdc_bmp	:DWORD
	local	hm_bmp	:DWORD
	
	local	nSkinNum			:DWORD
	local	szNewSkin[MAX_PATH]	:BYTE
	
	.IF uMsg == WM_INITDIALOG
		invoke SetWindowText	,hDlg, addr szApplicationName
	
		invoke LoadSkin, addr szSkinsDefault

		invoke LoadCursor ,NULL, IDC_ARROW
		mov hCursNorm, eax
		invoke LoadCursor ,NULL, IDC_SIZEALL
		mov hCursMove, eax
		invoke LoadCursor ,NULL, IDC_SIZENS
		mov hCursSV, eax
		invoke LoadCursor ,NULL, IDC_SIZEWE
		mov hCursSH, eax
		invoke LoadCursor ,NULL, IDC_SIZENWSE
		mov hCursSTR, eax
		invoke LoadCursor ,NULL, IDC_SIZENESW
		mov hCursSTL, eax
		
		invoke GetClientRect, hDlg, addr r
		m2m dInitialHeight, r.bottom
		
		invoke GetDlgItem	,hDlg, 3000
		invoke LoadSkinNames, eax
		
	.ELSEIF uMsg == WM_ERASEBKGND
		invoke GetClientRect	,hDlg, addr r

		invoke CreateCompatibleDC ,wParam
		mov hdc_db, eax
		invoke CreateCompatibleBitmap	,wParam, r.right, r.bottom
		mov hm_bmp, eax
		invoke SelectObject, hdc_db, hm_bmp
		push eax

		invoke CreateCompatibleDC ,wParam
		mov hdc_bmp, eax
		
		invoke SelectObject	,hdc_bmp, hSkinTitle_Left
		invoke BitBlt	,hdc_db, 0, 0, 8, 16, hdc_bmp, 0, 0, SRCCOPY

		invoke SelectObject	,hdc_bmp, hSkinTitle_Title
		invoke BitBlt	,hdc_db, 8, 0, 186, 16, hdc_bmp, 0, 0, SRCCOPY

		mov eax, r.right
		sub eax, 4
		mov r.left, eax
		invoke SelectObject	,hdc_bmp, hSkinTitle_Right
		invoke BitBlt	,hdc_db, r.left, 0, 4, 16, hdc_bmp, 0, 0, SRCCOPY
		
		sub r.left, 11
		.IF bCloseSelected
			.IF bClosePressed
				invoke SelectObject	,hdc_bmp, hSkinTitle_CloseP
			.ELSE
				invoke SelectObject	,hdc_bmp, hSkinTitle_CloseS
			.ENDIF	
		.ELSE
			invoke SelectObject	,hdc_bmp, hSkinTitle_Close
		.ENDIF
		invoke BitBlt	,hdc_db, r.left, 0, 11, 16, hdc_bmp, 0, 0, SRCCOPY

		sub r.left, 11
		.IF bRollupSelected
			.IF bRollupPressed
				invoke SelectObject	,hdc_bmp, hSkinTitle_RollupP
			.ELSE
				invoke SelectObject	,hdc_bmp, hSkinTitle_RollupS
			.ENDIF				
		.ELSE
			invoke SelectObject	,hdc_bmp, hSkinTitle_Rollup
		.ENDIF
		invoke BitBlt	,hdc_db, r.left, 0, 11, 16, hdc_bmp, 0, 0, SRCCOPY
		
		sub r.left, 11
		.IF bMinimizeSelected
			.IF bMinimizePressed
				invoke SelectObject	,hdc_bmp, hSkinTitle_MinimizeP
			.ELSE	
				invoke SelectObject	,hdc_bmp, hSkinTitle_MinimizeS
			.ENDIF
		.ELSE
			invoke SelectObject	,hdc_bmp, hSkinTitle_Minimize
		.ENDIF

		invoke BitBlt	,hdc_db, r.left, 0, 11, 16, hdc_bmp, 0, 0, SRCCOPY
		
		.IF r.left > 186+8
			m2m r.right, r.left
			mov r.left, 186+8
			push r.bottom
			mov r.bottom, 16
			invoke FillRect	,hdc_db, addr r, hbSkinTitle_Middle
			pop r.bottom
		.ENDIF

		invoke GetClientRect ,hDlg, addr r
		add r.top, 16
		invoke DrawEdge	,hdc_db, addr r, BDR_RAISEDOUTER, BF_RECT
		inc r.top
		inc r.left
		dec r.right
		dec r.bottom
		invoke DrawEdge	,hdc_db, addr r, BDR_SUNKENINNER, BF_RECT
		inc r.top
		inc r.left
		dec r.right
		dec r.bottom
		invoke FillRect	,hdc_db, addr r, hbSkinMain_Back

		invoke GetClientRect ,hDlg, addr r
		invoke BitBlt	,wParam, 0, 0, r.right, r.bottom, hdc_db, 0, 0, SRCCOPY

		invoke DeleteObject	,hdc_bmp
		pop eax
		invoke SelectObject, hdc_db, eax 
		invoke DeleteObject, hm_bmp
		invoke DeleteObject	,hdc_db
		

	.ELSEIF uMsg == WM_MOUSEMOVE
		invoke GetWindowRect	,hDlg, addr r
		invoke GetCursorPos	,addr p
		.IF WindowMoving
			mov eax, r.top
			sub r.bottom, eax
			mov eax, r.left
			sub r.right, eax

			.IF ! SizeType
 				mov eax, p.x
				sub eax, MovingStart.x
				add r.left, eax
				mov eax, p.y
				sub eax, MovingStart.y
				add r.top, eax
			.ELSE	
				.IF SizeType & 1				
					mov eax, p.y
					sub eax, MovingStart.y
					add r.top, eax
					sub r.bottom, eax
					.IF (r.bottom < MINIMUMHEIGHT) || (r.bottom > 80000000h)
						mov eax, MINIMUMHEIGHT
						sub eax, r.bottom
						sub p.y, eax
						sub r.top, eax
						invoke SetCursorPos	,p.x,p.y
						mov r.bottom, MINIMUMHEIGHT
					.ENDIF
				.ENDIF	
				.IF SizeType & 2
					mov eax, p.y
					sub eax, MovingStart.y
					add r.bottom, eax
					.IF (r.bottom < MINIMUMHEIGHT) || (r.bottom > 80000000h)
						mov eax, MINIMUMHEIGHT
						sub eax, r.bottom
						add p.y, eax
						invoke SetCursorPos	,p.x,p.y
						mov r.bottom, MINIMUMHEIGHT
					.ENDIF
				.ENDIF	
				.IF SizeType & 4
					mov eax, p.x
					sub eax, MovingStart.x
					add r.left, eax
					sub r.right, eax
					.IF (r.right < MINIMUMWIDTH) || (r.right > 80000000h)
						mov eax, MINIMUMWIDTH
						sub eax, r.right
						sub p.x, eax
						sub r.left, eax
						invoke SetCursorPos	,p.x,p.y
						mov r.right, MINIMUMWIDTH
					.ENDIF
				.ENDIF	
				.IF SizeType & 8				
					mov eax, p.x
					sub eax, MovingStart.x
					add r.right, eax
					.IF (r.right < MINIMUMWIDTH) || (r.bottom > 80000000h)
						mov eax, MINIMUMWIDTH
						sub eax, r.right
						add p.x, eax
						invoke SetCursorPos	,p.x,p.y
						mov r.right, MINIMUMWIDTH
					.ENDIF
				.ENDIF	
			.ENDIF	
			invoke MoveWindow ,hDlg, r.left, r.top, r.right, r.bottom, TRUE

			m2m MovingStart.x, p.x
			m2m MovingStart.y, p.y
		.ELSE
			sub r.right, 4
			m2m r.left, r.right
			sub r.left, 11
			m2m r.bottom, r.top
			add r.bottom, 16
			invoke PointInRect, p, r
			.IF eax && (! bRollupSelected) && (! bMinimizeSelected)
				.IF ! bCloseSelected
					mov bCloseSelected, TRUE
					invoke SetCapture	,hDlg
					invoke GetClientRect	,hDlg, addr r
					mov r.bottom, 16
					invoke InvalidateRect	,hDlg, addr r, TRUE
				.ENDIF
				mov eax, TRUE
				ret
			.ELSE
				.IF bCloseSelected 
					.IF ! bClosePressed
						invoke ReleaseCapture
					.ENDIF	
					mov bCloseSelected, FALSE
					invoke GetClientRect	,hDlg, addr r
					mov r.bottom, 16
					invoke InvalidateRect	,hDlg, addr r, TRUE
				.ENDIF
			.ENDIF
			
			sub r.right, 11
			sub r.left, 11
			invoke PointInRect, p, r
			.IF eax && (! bCloseSelected) && (! bMinimizeSelected)
				.IF ! bRollupSelected
					mov bRollupSelected, TRUE
					invoke SetCapture	,hDlg
					invoke GetClientRect	,hDlg, addr r
					mov r.bottom, 16
					invoke InvalidateRect	,hDlg, addr r, TRUE
				.ENDIF
				mov eax, TRUE
				ret
			.ELSE
				.IF bRollupSelected
					.IF ! bRollupPressed
						invoke ReleaseCapture	
					.ENDIF	
					mov bRollupSelected, FALSE
					invoke GetClientRect	,hDlg, addr r
					mov r.bottom, 16
					invoke InvalidateRect	,hDlg, addr r, TRUE
				.ENDIF
			.ENDIF	
					
			sub r.right, 11
			sub r.left, 11
			invoke PointInRect, p, r
			.IF eax && (! bRollupSelected) && (! bCloseSelected)
				.IF ! bMinimizeSelected
					mov bMinimizeSelected, TRUE
					invoke SetCapture	,hDlg
					invoke GetClientRect	,hDlg, addr r
					mov r.bottom, 16
					invoke InvalidateRect	,hDlg, addr r, TRUE
				.ENDIF
				mov eax, TRUE
				ret
			.ELSE
				.IF bMinimizeSelected
					.IF ! bMinimizePressed
						invoke ReleaseCapture	
					.ENDIF
					mov bMinimizeSelected, FALSE
					invoke GetClientRect	,hDlg, addr r
					mov r.bottom, 16
					invoke InvalidateRect	,hDlg, addr r, TRUE
				.ENDIF
			.ENDIF	
					
			.IF bClosePressed || bRollupPressed || bMinimizePressed
				mov eax, TRUE
				ret
			.ENDIF	
					
			invoke GetWindowRect	,hDlg, addr r
			invoke GetCursorPos	,addr p
			dec r.bottom
			dec r.right

			add r.left, SIZEBORDER-1 
			add r.top, SIZEBORDER-1 
			sub r.right, SIZEBORDER-1
			sub r.bottom, SIZEBORDER-1

			mov eax, p.y
			mov SizeType, 0
			.IF (r.top > eax) && (r.top < 80000000h)
				mov CursorChange, TRUE
				or SizeType, 1
			.ENDIF	
			mov eax, p.y
			.IF (r.bottom < eax) && (r.bottom < 80000000h)
				mov CursorChange, TRUE
				or SizeType, 2
			.ENDIF	
			mov eax, p.x
			.IF (r.left > eax) && (r.left < 80000000h)
				mov CursorChange, TRUE
				or SizeType, 4
			.ENDIF	
			mov eax, p.x
			.IF (r.right < eax) && (r.right < 80000000h)
				mov CursorChange, TRUE
				or SizeType, 8
			.ENDIF	
			.IF CursorChange && ( ! SizeType )
				mov SizeType, 0
				mov CursorChange, FALSE
				invoke SetCursor, hCursNorm
			.ELSE	
				.IF (SizeType == 1) || (SizeType == 2)
					invoke SetCursor, hCursSV
				.ELSEIF (SizeType == 4) || (SizeType == 8)
					invoke SetCursor, hCursSH
				.ELSEIF (SizeType == 10) || (SizeType == 5)
					invoke SetCursor, hCursSTR
				.ELSEIF (SizeType == 9) || (SizeType == 6)
					invoke SetCursor, hCursSTL
				.ENDIF	
			.ENDIF
		.ENDIF 
	.ELSEIF uMsg == WM_LBUTTONDOWN
		.IF bCloseSelected || bRollupSelected || bMinimizeSelected
			.IF bCloseSelected
				mov bClosePressed, TRUE
				invoke GetClientRect	,hDlg, addr r
				mov r.bottom, 16
				invoke InvalidateRect	,hDlg, addr r, TRUE
			.ENDIF
			.IF bRollupSelected
				mov bRollupPressed, TRUE
				invoke GetClientRect	,hDlg, addr r
				mov r.bottom, 16
				invoke InvalidateRect	,hDlg, addr r, TRUE
			.ENDIF
			.IF bMinimizeSelected
				mov bMinimizePressed, TRUE
				invoke GetClientRect	,hDlg, addr r
				mov r.bottom, 16
				invoke InvalidateRect	,hDlg, addr r, TRUE
			.ENDIF
			mov eax, TRUE
			ret
		.ENDIF
		invoke SetCapture	,hDlg
		invoke GetCursorPos	,addr MovingStart
		.IF ! SizeType
			invoke GetWindowRect	,hDlg, addr r
			mov eax, MovingStart.y
			sub eax, r.top
			.IF eax < CAPTIONHEIGHT
				invoke SetCursor, hCursMove
				mov CursorChange, TRUE
				mov WindowMoving, TRUE
			.ENDIF
		.ELSEIF (SizeType == 1) || (SizeType == 2)
			invoke SetCursor, hCursSV
			mov CursorChange, TRUE
			mov WindowMoving, TRUE
		.ELSEIF (SizeType == 4) || (SizeType == 8)
			invoke SetCursor, hCursSH
			mov CursorChange, TRUE
			mov WindowMoving, TRUE
		.ELSEIF (SizeType == 10) || (SizeType == 5)
			invoke SetCursor, hCursSTR
			mov CursorChange, TRUE
			mov WindowMoving, TRUE
		.ELSEIF (SizeType == 9) || (SizeType == 6)
			invoke SetCursor, hCursSTL
			mov CursorChange, TRUE
			mov WindowMoving, TRUE
		.ENDIF	
	.ELSEIF uMsg == WM_LBUTTONUP
		.IF bCloseSelected || bRollupSelected || bMinimizeSelected
			.IF bCloseSelected && bClosePressed
				invoke SendMessage, hDlg, WM_CLOSE, NULL, NULL
			.ENDIF	
			.IF bRollupSelected && bRollupPressed	
				invoke GetClientRect	,hDlg, addr r
				.IF r.bottom == 16
					mov eax, dInitialHeight
				.ELSE
					mov eax, 16
				.ENDIF
				push eax	
				invoke GetWindowRect	,hDlg, addr r
				mov bRollupPressed, FALSE
				mov eax, r.left
				sub r.right, eax
				pop eax
				invoke MoveWindow	,hDlg, r.left, r.top, r.right, eax, TRUE
				invoke GetClientRect	,hDlg, addr r
				mov r.bottom, 16
				invoke InvalidateRect	,hDlg, addr r, TRUE
			.ENDIF
			.IF bMinimizeSelected && bMinimizePressed
				invoke GetClientRect	,hDlg, addr r
				mov bMinimizePressed, FALSE
				mov r.bottom, 16
				invoke InvalidateRect	,hDlg, addr r, TRUE
				invoke ShowWindow	,hDlg, SW_MINIMIZE	
			.ENDIF
			mov bClosePressed, FALSE
			mov bRollupPressed, FALSE
			mov bMinimizePressed, FALSE
			mov eax, TRUE
			ret
		.ENDIF
		mov bClosePressed, FALSE
		mov bRollupPressed, FALSE
		mov bMinimizePressed, FALSE
		invoke ReleaseCapture	
		mov WindowMoving, FALSE
	.ELSEIF uMsg == WM_SIZE
		invoke GetClientRect	,hDlg, addr r
		invoke InvalidateRect	,hDlg, addr r, TRUE
	.ELSEIF uMsg == WM_COMMAND
		mov eax, wParam
		shr eax, 16
		.IF eax == CBN_SELCHANGE
			invoke SendMessage	,lParam, CB_GETCURSEL, NULL, NULL
			mov nSkinNum, eax
			invoke SendMessage	,lParam, CB_GETLBTEXT, nSkinNum, addr szNewSkin
			invoke KillSkin
			invoke LoadSkin, addr szNewSkin  
			invoke GetClientRect	,hDlg, addr r
			invoke InvalidateRect	,hDlg, addr r, TRUE
		.ENDIF
	.ELSEIF uMsg == WM_CLOSE
		invoke EndDialog	,hDlg, NULL
	.ELSE
		xor eax, eax
		ret
	.ENDIF
	mov eax, TRUE
	ret
DlgProc	ENDP
  
start:
	invoke GetModuleHandle	,NULL
	mov hInstance, eax
	
	invoke DialogBoxParam, hInstance, 101, NULL, addr DlgProc, NULL

	invoke ExitProcess	,NULL
end start