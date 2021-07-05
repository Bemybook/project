
;CodeVisionAVR C Compiler V1.24.8d Professional
;(C) Copyright 1998-2006 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type              : ATmega48
;Clock frequency        : 4.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External SRAM size     : 0
;Data Stack size        : 128 byte(s)
;Heap size              : 0 byte(s)
;Promote char to int    : No
;char is unsigned       : Yes
;8 bit enums            : No
;Word align FLASH struct: No
;Enhanced core instructions    : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega48
	#pragma AVRPART MEMORY PROG_FLASH 4096
	#pragma AVRPART MEMORY EEPROM 256
	#pragma AVRPART MEMORY INT_SRAM SIZE 512
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU WDTCSR=0x60
	.EQU UCSR0A=0xC0
	.EQU UDR0=0xC6
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU GPIOR0=0x1E
	.EQU GPIOR1=0x2A
	.EQU GPIOR2=0x2B

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_adc_noise_red=0x02
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM
	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM
	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM
	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM
	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM
	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM
	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+@1
	ANDI R30,LOW(@2)
	STS  @0+@1,R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+@1
	ANDI R30,LOW(@2)
	STS  @0+@1,R30
	LDS  R30,@0+@1+1
	ANDI R30,HIGH(@2)
	STS  @0+@1+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+@1
	ORI  R30,LOW(@2)
	STS  @0+@1,R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+@1
	ORI  R30,LOW(@2)
	STS  @0+@1,R30
	LDS  R30,@0+@1+1
	ORI  R30,HIGH(@2)
	STS  @0+@1+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __CLRD1S
	LDI  R30,0
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+@1)
	LDI  R31,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	LDI  R22,BYTE3(2*@0+@1)
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+@2)
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+@3)
	LDI  R@1,HIGH(@2+@3)
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+@3)
	LDI  R@1,HIGH(@2*2+@3)
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+@1
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+@1
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	LDS  R22,@0+@1+2
	LDS  R23,@0+@1+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+@2
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+@3
	LDS  R@1,@2+@3+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+@1
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	LDS  R24,@0+@1+2
	LDS  R25,@0+@1+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+@1,R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	STS  @0+@1+2,R22
	STS  @0+@1+3,R23
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+@1,R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+@1,R@2
	STS  @0+@1+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	RCALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	RCALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	RCALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __CLRD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R@1
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

	.CSEG
	.ORG 0

	.INCLUDE "page.vec"
	.INCLUDE "page.inc"

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	WDR
	IN   R26,MCUSR
	CBR  R26,8
	OUT  MCUSR,R26
	STS  WDTCSR,R31
	STS  WDTCSR,R30

;CLEAR R2-R14
	LDI  R24,13
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(0x200)
	LDI  R25,HIGH(0x200)
	LDI  R26,LOW(0x100)
	LDI  R27,HIGH(0x100)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;GPIOR0-GPIOR2 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30
	LDI  R30,__GPIOR1_INIT
	OUT  GPIOR1,R30
	LDI  R30,__GPIOR2_INIT
	OUT  GPIOR2,R30

;STACK POINTER INITIALIZATION
	LDI  R30,LOW(0x2FF)
	OUT  SPL,R30
	LDI  R30,HIGH(0x2FF)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0x180)
	LDI  R29,HIGH(0x180)

	RJMP _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x180
;       1 #include <mega48.h> 
;       2 #include <lcd16x1.h> 
;       3 #include<delay.h>
;       4 #include<stdlib.h>
;       5 #include<string.h>
;       6 
;       7 #define RXB8 1
;       8 #define TXB8 0
;       9 #define UPE 2
;      10 #define OVR 3
;      11 #define FE 4
;      12 #define UDRE 5
;      13 #define RXC 7
;      14 
;      15 #define FRAMING_ERROR (1<<FE)
;      16 #define PARITY_ERROR (1<<UPE)
;      17 #define DATA_OVERRUN (1<<OVR)
;      18 #define DATA_REGISTER_EMPTY (1<<UDRE)
;      19 #define RX_COMPLETE (1<<RXC) 
;      20 
;      21 unsigned int i;
;      22 unsigned char st[]="PAGE TURNER",maths,science,start,st0[]="  AUTOMATIC ",st2[]="PROCESS STARTED";
_st:
	.BYTE 0xC
_st0:
	.BYTE 0xD
_st2:
	.BYTE 0x10
;      23 
;      24 // USART Receiver buffer
;      25 #define RX_BUFFER_SIZE0 8
;      26 char rx_buffer0[RX_BUFFER_SIZE0];
_rx_buffer0:
	.BYTE 0x8
;      27 
;      28 #if RX_BUFFER_SIZE0<256
;      29 unsigned char rx_wr_index0,rx_rd_index0,rx_counter0;
;      30 #else
;      31 unsigned int rx_wr_index0,rx_rd_index0,rx_counter0;
;      32 #endif
;      33 
;      34 // This flag is set on USART Receiver buffer overflow
;      35 bit rx_buffer_overflow0;
;      36 
;      37 // USART Receiver interrupt service routine
;      38 interrupt [USART_RXC] void usart_rx_isr(void)
;      39 {

	.CSEG
_usart_rx_isr:
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	IN   R30,SREG
	ST   -Y,R30
;      40 char status,data;
;      41 status=UCSR0A;
	RCALL __SAVELOCR2
;	status -> R16
;	data -> R17
	LDS  R16,192
;      42 data=UDR0;
	LDS  R17,198
;      43 if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R16
	ANDI R30,LOW(0x1C)
	BREQ PC+2
	RJMP _0x3
;      44    {
;      45    rx_buffer0[rx_wr_index0]=data;
	MOV  R26,R7
	LDI  R27,0
	SUBI R26,LOW(-_rx_buffer0)
	SBCI R27,HIGH(-_rx_buffer0)
	ST   X,R17
;      46    if (++rx_wr_index0 == RX_BUFFER_SIZE0) rx_wr_index0=0;
	INC  R7
	LDI  R30,LOW(8)
	CP   R30,R7
	BREQ PC+2
	RJMP _0x4
	CLR  R7
;      47    if (++rx_counter0 == RX_BUFFER_SIZE0)
_0x4:
	INC  R9
	LDI  R30,LOW(8)
	CP   R30,R9
	BREQ PC+2
	RJMP _0x5
;      48       {
;      49       rx_counter0=0;
	CLR  R9
;      50       rx_buffer_overflow0=1;
	SBI  0x1E,0
;      51       };
_0x5:
;      52    };
_0x3:
;      53 }
	RCALL __LOADLOCR2P
	LD   R30,Y+
	OUT  SREG,R30
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
;      54 
;      55 #ifndef _DEBUG_TERMINAL_IO_
;      56 // Get a character from the USART Receiver buffer
;      57 #define _ALTERNATE_GETCHAR_
;      58 #pragma used+
;      59 char getchar(void)
;      60 {
;      61 char data;
;      62 while (rx_counter0==0);
;	data -> R16
;      63 data=rx_buffer0[rx_rd_index0];
;      64 if (++rx_rd_index0 == RX_BUFFER_SIZE0) rx_rd_index0=0;
;      65 #asm("cli")
;      66 --rx_counter0;
;      67 #asm("sei")
;      68 return data;
;      69 }
;      70 #pragma used-
;      71 #endif
;      72 
;      73 // USART Transmitter buffer
;      74 #define TX_BUFFER_SIZE0 8
;      75 char tx_buffer0[TX_BUFFER_SIZE0];

	.DSEG
_tx_buffer0:
	.BYTE 0x8
;      76 
;      77 #if TX_BUFFER_SIZE0<256
;      78 unsigned char tx_wr_index0,tx_rd_index0,tx_counter0;
;      79 #else
;      80 unsigned int tx_wr_index0,tx_rd_index0,tx_counter0;
;      81 #endif
;      82 
;      83 // USART Transmitter interrupt service routine
;      84 interrupt [USART_TXC] void usart_tx_isr(void)
;      85 {

	.CSEG
_usart_tx_isr:
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;      86 if (tx_counter0)
	TST  R12
	BRNE PC+2
	RJMP _0xA
;      87    {
;      88    --tx_counter0;
	DEC  R12
;      89    UDR0=tx_buffer0[tx_rd_index0];
	MOV  R30,R11
	RCALL SUBOPT_0x0
	LD   R30,Z
	STS  198,R30
;      90    if (++tx_rd_index0 == TX_BUFFER_SIZE0) tx_rd_index0=0;
	INC  R11
	LDI  R30,LOW(8)
	CP   R30,R11
	BREQ PC+2
	RJMP _0xB
	CLR  R11
;      91    };
_0xB:
_0xA:
;      92 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
;      93 
;      94 #ifndef _DEBUG_TERMINAL_IO_
;      95 // Write a character to the USART Transmitter buffer
;      96 #define _ALTERNATE_PUTCHAR_
;      97 #pragma used+
;      98 void putchar(char c)
;      99 {
_putchar:
;     100 while (tx_counter0 == TX_BUFFER_SIZE0);
;	c -> Y+0
_0xC:
	LDI  R30,LOW(8)
	CP   R30,R12
	BREQ PC+2
	RJMP _0xE
	RJMP _0xC
_0xE:
;     101 #asm("cli")
	cli
;     102 if (tx_counter0 || ((UCSR0A & DATA_REGISTER_EMPTY)==0))
	TST  R12
	BREQ PC+2
	RJMP _0x10
	LDS  R30,192
	ANDI R30,LOW(0x20)
	BRNE PC+2
	RJMP _0x10
	RJMP _0xF
_0x10:
;     103    {
;     104    tx_buffer0[tx_wr_index0]=c;
	MOV  R30,R10
	RCALL SUBOPT_0x0
	LD   R26,Y
	STD  Z+0,R26
;     105    if (++tx_wr_index0 == TX_BUFFER_SIZE0) tx_wr_index0=0;
	INC  R10
	LDI  R30,LOW(8)
	CP   R30,R10
	BREQ PC+2
	RJMP _0x12
	CLR  R10
;     106    ++tx_counter0;
_0x12:
	INC  R12
;     107    }
;     108 else
	RJMP _0x13
_0xF:
;     109    UDR0=c;
	LD   R30,Y
	STS  198,R30
;     110 #asm("sei")
_0x13:
	sei
;     111 }
	ADIW R28,1
	RET
;     112 #pragma used-
;     113 #endif
;     114 
;     115 // Standard Input/Output functions
;     116 #include <stdio.h>
;     117 
;     118 // Declare your global variables here
;     119 
;     120 void main(void)
;     121 {
_main:
;     122 // Declare your local variables here
;     123 
;     124 // Crystal Oscillator division factor: 1
;     125 #pragma optsize-
;     126 CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
;     127 CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  97,R30
;     128 #ifdef _OPTIMIZE_SIZE_
;     129 #pragma optsize+
;     130 #endif
;     131 
;     132 // Input/Output Ports initialization
;     133 // Port B initialization
;     134 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
;     135 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
;     136 PORTB=0x00;
	OUT  0x5,R30
;     137 DDRB=0x07;
	LDI  R30,LOW(7)
	OUT  0x4,R30
;     138 
;     139 // Port C initialization
;     140 // Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
;     141 // State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
;     142 PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x8,R30
;     143 DDRC=0x0f;
	LDI  R30,LOW(15)
	OUT  0x7,R30
;     144 
;     145 // Port D initialization
;     146 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
;     147 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
;     148 PORTD=0x0c;
	LDI  R30,LOW(12)
	OUT  0xB,R30
;     149 DDRD=0xf0;
	LDI  R30,LOW(240)
	OUT  0xA,R30
;     150 
;     151 // Timer/Counter 0 initialization
;     152 // Clock source: System Clock
;     153 // Clock value: Timer 0 Stopped
;     154 // Mode: Normal top=FFh
;     155 // OC0A output: Disconnected
;     156 // OC0B output: Disconnected
;     157 TCCR0A=0x00;
	LDI  R30,LOW(0)
	OUT  0x24,R30
;     158 TCCR0B=0x00;
	OUT  0x25,R30
;     159 TCNT0=0x00;
	OUT  0x26,R30
;     160 OCR0A=0x00;
	OUT  0x27,R30
;     161 OCR0B=0x00;
	OUT  0x28,R30
;     162 
;     163 // Timer/Counter 1 initialization
;     164 // Clock source: System Clock
;     165 // Clock value: Timer 1 Stopped
;     166 // Mode: Normal top=FFFFh
;     167 // OC1A output: Discon.
;     168 // OC1B output: Discon.
;     169 // Noise Canceler: Off
;     170 // Input Capture on Falling Edge
;     171 // Timer 1 Overflow Interrupt: Off
;     172 // Input Capture Interrupt: Off
;     173 // Compare A Match Interrupt: Off
;     174 // Compare B Match Interrupt: Off
;     175 TCCR1A=0x00;
	STS  128,R30
;     176 TCCR1B=0x00;
	STS  129,R30
;     177 TCNT1H=0x00;
	STS  133,R30
;     178 TCNT1L=0x00;
	STS  132,R30
;     179 ICR1H=0x00;
	STS  135,R30
;     180 ICR1L=0x00;
	STS  134,R30
;     181 OCR1AH=0x00;
	STS  137,R30
;     182 OCR1AL=0x00;
	STS  136,R30
;     183 OCR1BH=0x00;
	STS  139,R30
;     184 OCR1BL=0x00;
	STS  138,R30
;     185 
;     186 // Timer/Counter 2 initialization
;     187 // Clock source: System Clock
;     188 // Clock value: Timer 2 Stopped
;     189 // Mode: Normal top=FFh
;     190 // OC2A output: Disconnected
;     191 // OC2B output: Disconnected
;     192 ASSR=0x00;
	STS  182,R30
;     193 TCCR2A=0x00;
	STS  176,R30
;     194 TCCR2B=0x00;
	STS  177,R30
;     195 TCNT2=0x00;
	STS  178,R30
;     196 OCR2A=0x00;
	STS  179,R30
;     197 OCR2B=0x00;
	STS  180,R30
;     198 
;     199 // External Interrupt(s) initialization
;     200 // INT0: Off
;     201 // INT1: Off
;     202 // Interrupt on any change on pins PCINT0-7: Off
;     203 // Interrupt on any change on pins PCINT8-14: Off
;     204 // Interrupt on any change on pins PCINT16-23: Off
;     205 EICRA=0x00;
	STS  105,R30
;     206 EIMSK=0x00;
	OUT  0x1D,R30
;     207 PCICR=0x00;
	STS  104,R30
;     208 
;     209 // Timer/Counter 0 Interrupt(s) initialization
;     210 TIMSK0=0x00;
	STS  110,R30
;     211 // Timer/Counter 1 Interrupt(s) initialization
;     212 TIMSK1=0x00;
	STS  111,R30
;     213 // Timer/Counter 2 Interrupt(s) initialization
;     214 TIMSK2=0x00;
	STS  112,R30
;     215 
;     216 // USART initialization
;     217 // Communication Parameters: 8 Data, 1 Stop, No Parity
;     218 // USART Receiver: On
;     219 // USART Transmitter: On
;     220 // USART0 Mode: Asynchronous
;     221 // USART Baud rate: 9600
;     222 UCSR0A=0x00;
	STS  192,R30
;     223 UCSR0B=0xD8;
	LDI  R30,LOW(216)
	STS  193,R30
;     224 UCSR0C=0x06;
	LDI  R30,LOW(6)
	STS  194,R30
;     225 UBRR0H=0x00;
	LDI  R30,LOW(0)
	STS  197,R30
;     226 UBRR0L=0x19;
	LDI  R30,LOW(25)
	STS  196,R30
;     227 
;     228 // Analog Comparator initialization
;     229 // Analog Comparator: Off
;     230 // Analog Comparator Input Capture by Timer/Counter 1: Off
;     231 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x30,R30
;     232 ADCSRB=0x00;
	LDI  R30,LOW(0)
	STS  123,R30
;     233 
;     234 // Global enable interrupts
;     235 #asm("sei")  
	sei
;     236 lcd_init();
	RCALL _lcd_init
;     237 clear_lcd();
	RCALL SUBOPT_0x1
;     238 lcd_cmd(0x80);
;     239  lcd_puts(st0); 
	LDI  R30,LOW(_st0)
	LDI  R31,HIGH(_st0)
	RCALL SUBOPT_0x2
;     240  lcd_cmd(0xC0);
	LDI  R30,LOW(192)
	RCALL SUBOPT_0x3
;     241  lcd_puts(st); 
	LDI  R30,LOW(_st)
	LDI  R31,HIGH(_st)
	RCALL SUBOPT_0x2
;     242 delay_ms(2000); 
	RCALL SUBOPT_0x4
;     243 if(PIND.2==0)
	SBIC 0x9,2
	RJMP _0x14
;     244 {
;     245 // putchar('A');  
;     246 maths=1;
	LDI  R30,LOW(1)
	MOV  R4,R30
;     247 science=0;
	CLR  R5
;     248 }  
;     249 else
	RJMP _0x15
_0x14:
;     250 {
;     251  maths=0;
	CLR  R4
;     252 science=1;
	LDI  R30,LOW(1)
	MOV  R5,R30
;     253 } 
_0x15:
;     254 
;     255 // PORTC.1=0;  
;     256 //  PORTC.2=1;
;     257 //  delay_ms(1000);
;     258 //  PORTC.1=0;  
;     259 //  PORTC.2=0;
;     260 
;     261 while (1)
_0x16:
;     262       {
;     263       // Place your code here
;     264       if(start==1)
	LDI  R30,LOW(1)
	CP   R30,R6
	BREQ PC+2
	RJMP _0x19
;     265       {
;     266 //       if(maths==1)
;     267 //       putchar('A'); 
;     268 //       if(science==1)
;     269 //       putchar('B'); 
;     270       for(i=0;i<15;i++) 
	CLR  R2
	CLR  R3
_0x1B:
	LDI  R30,LOW(15)
	LDI  R31,HIGH(15)
	CP   R2,R30
	CPC  R3,R31
	BRLO PC+2
	RJMP _0x1C
;     271       
;     272       { 
;     273        if(maths==1)
	LDI  R30,LOW(1)
	CP   R30,R4
	BREQ PC+2
	RJMP _0x1D
;     274       putchar('A'); 
	LDI  R30,LOW(65)
	ST   -Y,R30
	RCALL _putchar
;     275       if(science==1)
_0x1D:
	LDI  R30,LOW(1)
	CP   R30,R5
	BREQ PC+2
	RJMP _0x1E
;     276       putchar('B'); 
	LDI  R30,LOW(66)
	ST   -Y,R30
	RCALL _putchar
;     277  PORTC.0=1;
_0x1E:
	SBI  0x8,0
;     278  delay_ms(2000);
	RCALL SUBOPT_0x4
;     279  PORTC.1=1;  
	SBI  0x8,1
;     280  PORTC.2=0;
	CBI  0x8,2
;     281  delay_ms(650);
	RCALL SUBOPT_0x5
;     282  PORTC.1=0;  
;     283  PORTC.2=0; 
;     284  PORTC.0=0; 
	CBI  0x8,0
;     285  delay_ms(1000);
	LDI  R30,LOW(1000)
	LDI  R31,HIGH(1000)
	RCALL SUBOPT_0x6
;     286  PORTC.1=0;  
	CBI  0x8,1
;     287  PORTC.2=1;
	SBI  0x8,2
;     288  delay_ms(650);
	RCALL SUBOPT_0x5
;     289  PORTC.1=0;  
;     290  PORTC.2=0;
;     291  delay_ms(10000);
	LDI  R30,LOW(10000)
	LDI  R31,HIGH(10000)
	RCALL SUBOPT_0x6
;     292  }
_0x1A:
	MOVW R30,R2
	ADIW R30,1
	MOVW R2,R30
	RJMP _0x1B
_0x1C:
;     293    #asm
;     294    rjmp 0x0000
   rjmp 0x0000
;     295    #endasm
;     296       } 
;     297       
;     298 if(PIND.3==0)
_0x19:
	SBIC 0x9,3
	RJMP _0x1F
;     299 { 
;     300 delay_ms(200);
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	RCALL SUBOPT_0x6
;     301 if(PIND.3==0)
	SBIC 0x9,3
	RJMP _0x20
;     302 {
;     303 start=1;
	LDI  R30,LOW(1)
	MOV  R6,R30
;     304 clear_lcd();
	RCALL SUBOPT_0x1
;     305 lcd_cmd(0x80);
;     306  lcd_puts(st2); 
	LDI  R30,LOW(_st2)
	LDI  R31,HIGH(_st2)
	RCALL SUBOPT_0x2
;     307 } 
;     308 }
_0x20:
;     309       };
_0x1F:
	RJMP _0x16
_0x18:
;     310 }
_0x21:
	RJMP _0x21
;     311  #include <mega48.h> 
;     312   #include <delay.h>         
;     313 //#include <prototype.h> 
;     314 #include <lcd16x1.h> 
;     315 #include <stdlib.h>
;     316 #include <stdio.h>  
;     317 //#include<prototype.h>     
;     318 //#define INT0_PIN PIND.2         //int0 pin PD.2
;     319 //#define INT1_PIN PIND.3         //int1 pin PD.3
;     320 
;     321 #define RS PORTB.0
;     322 #define RW PORTB.1    //lcd defines
;     323 #define EN PORTB.2  
;     324                         
;     325          
;     326 
;     327 //function to clear the lcd & start from first row first column onwards       
;     328 void clear_lcd(void)
;     329 {
_clear_lcd:
;     330        lcd_cmd(0x01);
	LDI  R30,LOW(1)
	RCALL SUBOPT_0x3
;     331        //lcd_cmd(0x80);   //clear screen n start from fist line first column
;     332        lcd_cmd(0x06);     //incremental cursor
	LDI  R30,LOW(6)
	RCALL SUBOPT_0x3
;     333 }
	RET
;     334 
;     335 //lcd initialization function for 4 datalines    
;     336  void lcd_init(void)
;     337  {
_lcd_init:
;     338         delay_ms(15);               //startup delay
	LDI  R30,LOW(15)
	LDI  R31,HIGH(15)
	RCALL SUBOPT_0x6
;     339                   lcd_cmd(0x03);
	LDI  R30,LOW(3)
	RCALL SUBOPT_0x3
;     340         delay_ms(5);     
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	RCALL SUBOPT_0x6
;     341                   lcd_cmd(0x03);
	LDI  R30,LOW(3)
	RCALL SUBOPT_0x3
;     342         delay_us(160);     
	RCALL SUBOPT_0x7
;     343                   lcd_cmd(0x03);
	LDI  R30,LOW(3)
	RCALL SUBOPT_0x3
;     344         delay_us(160);            
	RCALL SUBOPT_0x7
;     345                   lcd_cmd(0x02);
	LDI  R30,LOW(2)
	RCALL SUBOPT_0x3
;     346        delay_us(160);  
	RCALL SUBOPT_0x7
;     347                   lcd_cmd(0x28);         //4 bit data , 5*7, 2 line..   //the abouve cmds are necessary
	LDI  R30,LOW(40)
	RCALL SUBOPT_0x3
;     348        delay_ms(100);                    
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	RCALL SUBOPT_0x6
;     349                   lcd_cmd(0x60);         // set CGRAM addr
	LDI  R30,LOW(96)
	RCALL SUBOPT_0x3
;     350        delay_ms(100);           
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	RCALL SUBOPT_0x6
;     351          lcd_cmd(0x0C); 
	LDI  R30,LOW(12)
	RCALL SUBOPT_0x3
;     352        delay_ms(1);                          
	RCALL SUBOPT_0x8
;     353                   lcd_cmd(0x06);       //increment cursor no shift
	LDI  R30,LOW(6)
	RCALL SUBOPT_0x3
;     354        delay_ms(1);           
	RCALL SUBOPT_0x8
;     355                   lcd_cmd(0x90);       // 1st column 1st char
	LDI  R30,LOW(144)
	RCALL SUBOPT_0x3
;     356         delay_ms(1);                                        
	RCALL SUBOPT_0x8
;     357                   lcd_cmd(0x01);       //clear lcd
	LDI  R30,LOW(1)
	RCALL SUBOPT_0x3
;     358         delay_ms(2);                              
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	RCALL SUBOPT_0x6
;     359   }
	RET
;     360   //to send lcd commands
;     361 void lcd_cmd(unsigned char inst)
;     362 {
_lcd_cmd:
;     363 
;     364        unsigned char lsb=0,msb=0;
;     365         lsb=inst&0x0F;        //split msb n lsb nibbles
	RCALL __SAVELOCR2
;	inst -> Y+2
;	lsb -> R16
;	msb -> R17
	LDI  R16,0
	LDI  R17,0
	LDD  R30,Y+2
	ANDI R30,LOW(0xF)
	MOV  R16,R30
;     366         msb=inst>>4; 
	LDD  R30,Y+2
	SWAP R30
	ANDI R30,0xF
	MOV  R17,R30
;     367         msb&=0x0F;   
	ANDI R17,LOW(15)
;     368         lsb=lsb&0X0F;
	ANDI R16,LOW(15)
;     369         msb=msb<<4;
	SWAP R17
	ANDI R17,0xF0
;     370         lsb=lsb<<4;
	SWAP R16
	ANDI R16,0xF0
;     371         delay_us(500);            //busy check duration       500
	__DELAY_USW 500
;     372         RS=0;
	CBI  0x5,0
;     373         RW=0;    
	RCALL SUBOPT_0x9
;     374         EN=1;     
;     375         PORTD&=0x0F; 
;     376         PORTD|=msb; 
;     377         delay_us(5);         //6 nops       changed from 10u to 5u
;     378         EN=0;
;     379         delay_us(5);         //6 nops
;     380         EN=1;
;     381         PORTD&=0x0F;        //sending lsb now       
;     382         PORTD|=lsb; 
;     383         delay_us(5);         //6 nops
;     384         EN=0;
;     385      }   
	RCALL __LOADLOCR2
	ADIW R28,3
	RET
;     386                
;     387 //function to send data to lcd
;     388  void lcd_data(unsigned char data1,unsigned char type)
;     389  {      
_lcd_data:
;     390       unsigned char lsbc,msbc,temp,a; 
;     391       type=a;
	RCALL __SAVELOCR4
;	data1 -> Y+5
;	type -> Y+4
;	lsbc -> R16
;	msbc -> R17
;	temp -> R18
;	a -> R19
	STD  Y+4,R19
;     392       temp=0;lsbc=0;msbc=0;
	LDI  R18,LOW(0)
	LDI  R16,LOW(0)
	LDI  R17,LOW(0)
;     393       msbc=data1&0xF0;      //msb n lsb split
	LDD  R30,Y+5
	ANDI R30,LOW(0xF0)
	MOV  R17,R30
;     394       lsbc=data1<<4;
	LDD  R30,Y+5
	SWAP R30
	ANDI R30,0xF0
	MOV  R16,R30
;     395       delay_us(600);            //busy check duration       prev 600
	__DELAY_USW 600
;     396       RS=1;
	SBI  0x5,0
;     397       RW=0;     
	RCALL SUBOPT_0x9
;     398       EN=1;
;     399       PORTD&=0x0F; 
;     400       PORTD|=msbc;         // this being moved to the lsbbits of port instead of msb...
;     401       delay_us(5);        
;     402       EN=0 ;                   
;     403       delay_us(5);        
;     404       EN=1;
;     405       PORTD&=0x0F;
;     406       PORTD|=lsbc;        
;     407       delay_us(5);        
;     408       EN=0;     
;     409 } 
	RCALL __LOADLOCR4
	ADIW R28,6
	RET
;     410             
;     411  
;     412 //function to put string onto lcd     
;     413 void lcd_puts(unsigned char *str)
;     414 {
_lcd_puts:
;     415   while(*str !='\0') 
;	*str -> Y+0
_0x22:
	LD   R26,Y
	LDD  R27,Y+1
	LD   R30,X
	CPI  R30,0
	BRNE PC+2
	RJMP _0x24
;     416          {
;     417            lcd_data(*str,1);
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	RCALL _lcd_data
;     418              *str++;
	LD   R26,Y
	LDD  R27,Y+1
	LD   R30,X+
	ST   Y,R26
	STD  Y+1,R27
;     419           }
	RJMP _0x22
_0x24:
;     420 }
	ADIW R28,2
	RET
;     421 
;     422 
;     423 
;     424 
;     425 //function to convert int to ascii for dispaly on lcd / serial port          
;     426 //  //calculate the ascii values to be displayed on lcd  3 digit int to 3 digit ascii
;     427 // void cal_ascii(unsigned int value)   
;     428 // { 
;     429 //        unsigned char lb,mb,mmlb;
;     430 //        mmlb=(((unsigned char)(value/100))|0x30);
;     431 //        mb=(unsigned char)(value/10);  
;     432 //        mb=(((unsigned char)(mb%10))|0x30);
;     433 //        lb=(((unsigned char)(value%10))|0x30);
;     434 //       
;     435 //       if(value>99){ lcd_data(mmlb,1);lcd_data(mb,1);lcd_data(lb,1); }
;     436 //       else if (value >9){lcd_data(mb,1);lcd_data(lb,1); }
;     437 //       else 
;     438 //       {   
;     439 //       lcd_data(0x30,1);
;     440 //       lcd_data(lb,1); 
;     441 //       }
;     442 // }                       
;     443 
;     444 


;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x0:
	LDI  R31,0
	SUBI R30,LOW(-_tx_buffer0)
	SBCI R31,HIGH(-_tx_buffer0)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1:
	RCALL _clear_lcd
	LDI  R30,LOW(128)
	ST   -Y,R30
	RJMP _lcd_cmd

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2:
	ST   -Y,R31
	ST   -Y,R30
	RJMP _lcd_puts

;OPTIMIZER ADDED SUBROUTINE, CALLED 13 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x3:
	ST   -Y,R30
	RJMP _lcd_cmd

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x4:
	LDI  R30,LOW(2000)
	LDI  R31,HIGH(2000)
	ST   -Y,R31
	ST   -Y,R30
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x5:
	LDI  R30,LOW(650)
	LDI  R31,HIGH(650)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
	CBI  0x8,1
	CBI  0x8,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x6:
	ST   -Y,R31
	ST   -Y,R30
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x7:
	__DELAY_USB 213
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x8:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RJMP SUBOPT_0x6

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:23 WORDS
SUBOPT_0x9:
	CBI  0x5,1
	SBI  0x5,2
	IN   R30,0xB
	ANDI R30,LOW(0xF)
	OUT  0xB,R30
	IN   R30,0xB
	OR   R30,R17
	OUT  0xB,R30
	__DELAY_USB 7
	CBI  0x5,2
	__DELAY_USB 7
	SBI  0x5,2
	IN   R30,0xB
	ANDI R30,LOW(0xF)
	OUT  0xB,R30
	IN   R30,0xB
	OR   R30,R16
	OUT  0xB,R30
	__DELAY_USB 7
	CBI  0x5,2
	RET

_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x3E8
	wdr
	sbiw r30,1
	brne __delay_ms0
__delay_ms1:
	ret

__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__LOADLOCR2P:
	LD   R16,Y+
	LD   R17,Y+
	RET

;END OF CODE MARKER
__END_OF_CODE:
