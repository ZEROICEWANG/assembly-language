.286
DATAS SEGMENT
    ;�˴��������ݶδ���  
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    MOV AX,0D
    MOV DX,0
    MOV CX,0
    JMP LOP
LOP:;ѭ���ۼ�
	ADD AX,CX;ʵ�ִ���λ��˫���ȼӷ�
	ADC DX,0;�����λ
	
	PUSH AX
	PUSH DX
	CALL OUT1;���ÿ���ۼӵĽ��
	MOV DL,20H;����ո�
	MOV AH,6H
	INT 21H
	POP DX
	POP AX
	INC CX
    CMP CX,1001D;�ж��Ƿ�ӵ�1000,
    JNE LOP;����ѭ��
    JE FIN;�˳�
    
OUT1:;����ۼӽ��
	MOV BP,0AH
	PUSH BP;��־λ��ջ
	MOV BP,0
	JMP MOD1
MOD1:;�����ʮ�����ƣ�������ת��ʮ��������
	MOV BX,10D
	DIV BX
	PUSH DX;������ջ
	MOV DX,0
	CMP AX,0
	JE PRD;������������
	JMP MOD1;ѭ��

PRD:;�����ջ���
	POP BX
	CMP BX,0AH;�Ƿ�Ϊ��־λ
	JE FIN;������־λ���������
	MOV DL,BL;�������������
	ADD DL,30H
	MOV AH,6H
	INT 21H
	JMP PRD
	
FIN:
	RET
	
CODES ENDS
    END START







