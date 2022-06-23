
	format MS COFF
	

	include '%FASMINC%/win32a.inc'
	
extrn CreateWindowExA
extrn DefWindowProcA
extrn DispatchMessageA
extrn ExitProcess
extrn GetMessageA
extrn GetModuleHandleA
extrn LoadIconA
extrn LoadCursorA
extrn MessageBoxA
extrn PostQuitMessage
extrn RegisterClassExA
extrn SendMessageA
extrn ShowWindow	
extrn TranslateMessage

	section '.code' code readable executable
	public start
start:
wcx = sizeof.WNDCLASSEX
msg = sizeof.MSG + wcx
_ = msg
	enter _,0
	
	lea ebx, [ebp-wcx]
	mov dword [ebx+WNDCLASSEX.cbSize], sizeof.WNDCLASSEX
	mov dword [ebx+WNDCLASSEX.style], CS_HREDRAW+CS_VREDRAW
	mov dword [ebx+WNDCLASSEX.lpfnWndProc], wnd_proc
	and dword [ebx+WNDCLASSEX.cbClsExtra], 0
	and dword [ebx+WNDCLASSEX.cbWndExtra], 0
	
	push 0
	call GetModuleHandleA
	mov [ebx+WNDCLASSEX.hInstance], eax
	
	push IDI_APPLICATION
	push 0
	call LoadIconA
	mov [ebx+WNDCLASSEX.hIcon], eax
	mov [ebx+WNDCLASSEX.hIconSm], eax
	
	push IDC_ARROW
	push 0
	call LoadCursorA
	mov [ebx+WNDCLASSEX.hCursor], eax
	
	mov dword [ebx+WNDCLASSEX.hbrBackground], COLOR_WINDOW
	
	mov dword [ebx+WNDCLASSEX.lpszMenuName], _menu_name
	mov dword [ebx+WNDCLASSEX.lpszClassName], _class_name
	
	push ebx
	call RegisterClassExA
	
	push 0
	push dword [ebx+WNDCLASSEX.hInstance]
	push 0
	push 0
	push CW_USEDEFAULT
	push CW_USEDEFAULT
	push CW_USEDEFAULT
	push CW_USEDEFAULT
	push WS_OVERLAPPEDWINDOW
	push _title_text
	push _class_name
	push WS_EX_WINDOWEDGE
	call CreateWindowExA
	
	push SW_NORMAL
	push eax
	call ShowWindow
	
	lea ebx, [ebp-msg]
	jmp .get_msg
	
.msg_loop:
	push ebx
	call TranslateMessage
	
	push ebx
	call DispatchMessageA
	
.get_msg:
	push 0
	push 0
	push 0
	push ebx
	call GetMessageA
	
	test eax, eax
	jnz .msg_loop
	
	push 0
	call ExitProcess
	
wnd_proc:
hwnd = 8
umsg = hwnd+4
wpar = umsg+4
lpar = wpar+4
__   = lpar-4
	enter 0, 0
	
	mov eax, [ebp+umsg]
	
	cmp eax, WM_DESTROY
	je .wm_destroy
	cmp eax, WM_COMMAND
	je .wm_command
	
.default:
	push dword [ebp+lpar]
	push dword [ebp+wpar]
	push dword [ebp+umsg]
	push dword [ebp+hwnd]
	call DefWindowProcA
	jmp .def_handled
	
.wm_destroy:
	push 0
	call PostQuitMessage
	jmp .handled
	
.wm_command:
	mov eax, [ebp+wpar]

	cmp ax, 101
	je .joke
	cmp ax, 102
	je .quote

	push 0
	push 0
	push WM_DESTROY
	push dword [ebp+hwnd]
	call SendMessageA

	jmp .handled
.joke:
	push MB_OK
	push _title_text
	push _joke
	push dword [ebp+hwnd]
	call MessageBoxA
	jmp .handled
	
.quote:
	push MB_OK
	push _title_text
	push _quote
	push dword [ebp+hwnd]
	call MessageBoxA
	jmp .handled
		
.handled:
	xor eax, eax
.def_handled:
	leave
	ret __
	


	section '.data' data readable writable
_menu_name db 'MyMenu',0
_class_name db 'MyMenuClass',0
_title_text db 'Menu Example',0
NL equ 13,10
_joke db 'Bill Gates died and, much to everyone''s surprise, went to Heaven. When he got there, he had to wait in the reception area.'
      db 'Heaven''s reception area was the size of Massachusetts. There were literally millions of people milling about, living in tents'
      db 'with nothing to do all day. Food and water were being distributed from the backs of trucks, while staffers with clipboards slowly'
      db 'worked their way through the crowd. Booze and drugs were being passed around. Fights were commonplace. Sanitation conditions were appalling.'
      db 'All in all, the scene looked like Woodstock gone metastatic.'
      db 'Bill lived in a tent for three weeks until, finally, one of the staffers approached him. The staffer was a young man in his late teens, face scarred with acne.'
      db 'He was wearing a blue T-shirt with the words TEAM PETER emblazoned on it in large yellow lettering.'
      db '"Hello," said the staffer in a bored voice that could have been the voice of any clerk in any overgrown bureaucracy. "My name is Gabriel and I''ll be your induction coordinator."'
      db 'Bill started to ask a question, but Gabriel interrupted him. "No, I''m not the Archangel Gabriel. I''m just a guy from Philadelphia named Gabriel who died in a car'
      db 'wreck at the age of 17. Now give me your name, last name first, unless you were Chinese in which case it''s first name first."'
      db '"Gates, Bill." Gabriel started searching though the sheaf of papers on his clipboard, looking for Bill''s Record of Earthly Works. "What''s going on here?" asked Bill.'
      db '"Why are all these people here? Where''s Saint Peter? Where are the Pearly Gates?"'
      db 'Gabriel ignored the questions until he located Bill''s records. Then Gabriel looked up in surprise. "It says here that you were the president of a large software company. Is that right?"'
      db '"Yes." "Well then, do the math chip-head! When this Saint Peter business started, it was an easy gig. Only a hundred or so people died every day, and Peter could handle it all by himself, no problem. But now there are over five billion people on earth. Jesus, when God said to ''go forth and multiply,'' he didn''t say ''like rabbits!'' With that large a population, ten thousand people die every hour. Over a quarter-million people a day. Do you think Peter can meet them all personally?"'
      db '"I guess not." "You guess right. So Peter had to franchise the operation. Now, Peter is the CEO of Team Peter Enterprises, Inc. He just sits in the corporate headquarters and sets policy. Franchisees like me handle the actual inductions." Gabriel looked though his paperwork some more, and then continued. "Your paperwork seems to be in order. And with a background like yours, you''ll be getting a plum job assignment."'
      db '"Job assignment?" "Of course. Did you expect to spend the rest of eternity sitting on your ass and drinking ambrosia? Heaven is a big operation. You have to pull your weight around here!" Gabriel took out a triplicate form, had Bill sign at the bottom, and then tore out the middle copy and handed it to Bill. "Take this down to induction center #23 and meet up with your occupational orientator. His name is Abraham." Bill started to ask a question, but Gabriel interrupted him. "No, he''s not that Abraham."'
      db 'Bill walked down a muddy trail for ten miles until he came to induction center #23. He met with Abraham after a mere six-hour wait.'
      db '"Heaven is centuries behind in building its data processing infrastructure," explained Abraham. "As you''ve seen, we''re still doing everything on paper. It takes us a week just to process new entries."'
      db '"I had to wait three weeks," said Bill. Abraham stared at Bill angrily, and Bill realized that he''d made a mistake. Even in Heaven, it''s best not to contradict a bureaucrat. "Well," Bill offered, "maybe that Bosnia thing has you guys backed up."'
      db 'Abraham''s look of anger faded to mere annoyance. "Your job will be to supervise Heaven''s new data processing center. We''re building the largest computing facility in creation. Half a million computers connected by a multi-segment fiber optic network, all running into a back-end server network with a thousand CPUs on a gigabit channel. Fully fault tolerant. Fully distributed processing. The works."'
      db 'Bill could barely contain his excitement. "Wow! What a great job! This is really Heaven!"'
      db '"We''re just finishing construction, and we''ll be starting operations soon. Would you like to go see the center now?"'
      db '"You bet!" Abraham and Bill caught the shuttle bus and went to Heaven''s new data processing center. It was a truly huge facility, a hundred times bigger than the Astrodome. Workmen were crawling all over the place, getting the miles of fiber optic cables properly installed. But the center was dominated by the computers. Half a million computers, arranged neatly row-by-row, half a million ....'
      db '.... Macintoshes ........ all running Claris software! Not a PC in sight! Not a single byte of Microsoft code!'
      db 'The thought of spending the rest of eternity using products that he had spent his whole life working to destroy was too much for Bill. "What about PCs???" he exclaimed. "What about Windows??? What about Excel??? What about Word???"'
      db '"You''re forgetting something," said Abraham. "What''s that?" asked Bill plaintively. "This is Heaven," explained Abraham. "We need a computer system that''s heavenly to use. If you want to build a data processing center based on PCs running Windows, then ....'
      db '.... GO TO HELL!" NOTE: This CERTAINLY does not represent the views of Steven Willoughby who, although he does not terribly care for Bill Gates, likes Macs even less.'
      db 0

_quote db 'Users /nm./: collective term for those who use computers. Users are divided into three types: novice, intermediate and expert.',NL,NL
       db 'Novice Users: people who are afraid that simply pressing a key might break their computer.',NL
       db 'Intermediate Users: people who don''t know how to fix their computer after they''ve just pressed a key that broke it.',NL
       db 'Expert Users: people who break other people''s computers.',NL
       db '-- From the Jargon File. ',NL,0
