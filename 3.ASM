.286
DATAS SEGMENT
   SUM DW 1H,'#','$',1000 DUP(?)
   ;SUM DW 24H,8F9H,0E40BH,0FA6H,346CH,7FDBH,8082H,0F81AH,0BEE3H,6DA6H,0B2BDH,8919H,3EE0H,66CDH,45AAH,0EF58H,5833H,0EA40H,0H,0H, 0H,0H,'$','$',10 DUP(?)
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
	CBW;�ֽ�ת��Ϊ��
	MOV AX,1D
	JMP CACU;��ʼ����

CACU:
	PUSH AX;N��ջ
	LEA SI,SUM
	MOV BP,SI
	LOP_INDEX:
		MOV AX,[SI]
		ADD SI,2
		CMP AX,'#'
		JNE LOP_INDEX
		MOV AX,[SI]
		ADD SI,2
		CMP AX,'$'
		JNE LOP_INDEX
	SUB SI,4;SI���˵�'$'
	POP BX;����N
	MOV CX,0;��ʼ��0
	ADD CX,0;��λ����
	MOV AX,'$';#��ջ����Ϊ��־2
	PUSH AX
	MOV AX,'#'
	PUSH AX;$��ջ����Ϊ��־1
	LOP_MUL:
		SUB SI,2
		MOV AX,[SI]
		
		MUL BX
		ADD AX,CX;ǰһ����λ���ϱ��θ�λ
		PUSH AX;�ͽ�ջ
		ADC DX,0;��λ�ӵ���λ
		MOV CX,DX
		CMP BP,SI
		JNE LOP_MUL;���ѭ��
		LEA SI,SUM;��������SUM��
		CMP CX,0
		JE SAVE
		PUSH CX;�����λ
		JMP SAVE
	SAVE:;����������
		POP AX
		MOV [SI],AX
		ADD SI,2
		CMP AX,'#';�Ƿ�Ϊ��־λ1
		JNE SAVE;ѭ����������
		MOV [SI],AX
		POP AX
		MOV [SI],AX
		ADD SI,2
		CMP AX,'$';�Ƿ�Ϊ��־λ2
		JNE SAVE;ѭ����������
		MOV [SI],AX

	MOV AX,BX;
	INC AX
	CMP AX,1001D;�Ƿ�1000
	JNE CACU;�������
	JMP SHOW;������
	
	
;����������ʮ����������
SHOW:
	LEA SI,SUM;��ô��ĵ�ַ
	MOV DX,0
	MOV BX,10H
	MOV CX,'$'
	PUSH CX;��־��ջ
	MOV AX,[SI]
	ADD SI,2
	JMP LOP_TRAN1;ѭ�������е�����ȡ��������Ϊ��λ��
	LOP_TRAN1:
		MOV DX,0
		DIV BX;��ȡ������һ���ֵ����ݣ���ȡ��
		PUSH DX;������ջ
		CMP AX,0;�Ƿ���Ϊ0
		JNE LOP_TRAN1;��Ϊ�������ȡ�ಢ��ջ
		JMP POP_OUT;������׼��������ջ����
		
	POP_OUT:
		POP AX;������ջ
		MOV AH,0
		CMP AX,'$';�Ƿ񵯳��˱�־λ
		JE LOP_SHOW;������һ���ֵļ������
		CMP AX,0AH;�������������ֻ�����ĸ
		JB OUT_NUM;�����������
		JMP OUT_ALF;������ĸ���
		
	LOP_SHOW:
		MOV DL,20H;����ո�
		MOV AH,06H
		INT 21H
		MOV CX,'$';��־��ջ
		PUSH CX
		MOV AX,[SI];��ȡһ���ֵ�����
		ADD SI,2;SI��ַ���������ֽ�
		MOV CX,4;����
		CMP AX,'#';�Ƿ����ַ����ĵ����ڶ�����
		JNE LOP_TRAN2;����ȡ��ѭ��
		
		MOV AX,[SI];��ȡһ���ֵ�����
		ADD SI,2;SI��ַ���������ֽ�
		MOV CX,4;����
		CMP AX,'$';�Ƿ����ַ��������һ����
		JNE LOP_TRAN2;����ȡ��ѭ��
		
		JMP FIN;����
	LOP_TRAN2:;����ȡ��
		DEC CX;������һ
		MOV DX,0
		MOV BX,10H
		DIV BX;��10Hȡ��
		PUSH DX;������ջ
		CMP CX,0;��λ�Ƿ�ȡ��ת�����
		JNE LOP_TRAN2;ѭ��ȡ��
		JMP POP_OUT;�������
		
	OUT_NUM:;�������
		MOV DL,AL
		ADD DL,30H
		MOV AH,06H
		INT 21H
		JMP POP_OUT;����ѭ�����
	OUT_ALF:;�����Ļ
		MOV DL,AL
		ADD DL,37H
		MOV AH,06H
		INT 21H
		JMP POP_OUT;����ѭ�����
FIN:
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START







































