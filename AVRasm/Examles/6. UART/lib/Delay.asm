;// 				Author:  Skyer                            			   //
;// 				Website: www.smartep.ru                  			   //
;////////////////////////////////////////////////////////////////////////////
; ���������� �������� (8 ���)
;	Delay1us	�������� ���������� �������� � 1 ��� c ������ ������������ RCALL � RET
;	Delay5us	�������� ���������� �������� � 5 ��� c ������ ������������ RCALL � RET
;	Delay10us	�������� ���������� �������� � 10 ��� c ������ ������������ RCALL � RET
;	Delayus		�������� ������� �������� � ��������� �������� �����������
;	Delayms		�������� ������� �������� � ��������� �����������

;=================================================
; �������� ���������� �������� � 1 ��� c ������ ������������ RCALL � RET
; RCALL ���� 3 + 1 NOP + 4 RET = 8 - 1 ������������ ��� 8���
Delay1us:							
	NOP			
RET
;=================================================	
; �������� ���������� �������� � 5 ��� c ������ ������������ RCALL � RET
Delay5us:	
	PUSH	Temp1	
	LDI		Temp1, 9	
Delay5us_loop:					
	DEC		Temp1	
	BRNE	Delay5us_loop	
	POP		Temp1
	NOP
	NOP				
RET
;=================================================			
; �������� ���������� �������� � 10 ��� c ������ ������������ RCALL � RET
Delay10us:	
	PUSH	Temp1	
	LDI		Temp1, 23	
Delay10us_loop:					
	DEC		Temp1	
	BRNE	Delay10us_loop	
	POP		Temp1				
RET
;=================================================		
; �������� ������� �������� � ��������� �������� �����������
;	���� Temp1 ���������� ����������� �������� �����������
Delayus:
	PUSH	Temp2
Delayus_loop1:
	LDI		Temp2, 25
Delayus_loop2:
	DEC		Temp2	
	BRNE	Delayus_loop2
	NOP
	NOP
	DEC		Temp1
	BRNE	Delayus_loop1
	POP		Temp2
RET	
;=================================================
; �������� ������� �������� � ��������� �����������
;	���� Temp1 ���������� ����������� �����������
Delayms:
	PUSH	Temp2
	MOV		Temp2,Temp1
Delayms_loop:	
	LDI		Temp1,100
	RCALL	Delayus
	DEC		Temp2
	BRNE	Delayms_loop
	POP		Temp2
RET
