// CodeVisionAVR C Compiler
// (C) 1998-2004 Pavel Haiduc, HP InfoTech S.R.L.
// I/O registers definitions for the ATmega48(V)
#pragma used+
sfrb PINB=3;
sfrb DDRB=4;
sfrb PORTB=5;
sfrb PINC=6;
sfrb DDRC=7;
sfrb PORTC=8;
sfrb PIND=9;
sfrb DDRD=0xa;
sfrb PORTD=0xb;
sfrb TIFR0=0x15;
sfrb TIFR1=0x16;
sfrb TIFR2=0x17;
sfrb PCIFR=0x1b;
sfrb EIFR=0x1c;
sfrb EIMSK=0x1d;
sfrb GPIOR0=0x1e;
sfrb EECR=0x1f;
sfrb EEDR=0x20;
sfrb EEARL=0x21;
sfrb EEARH=0x22;
sfrw EEAR=0x21;   // 16 bit access
sfrb GTCCR=0x23;
sfrb TCCR0A=0x24;
sfrb TCCR0B=0x25;
sfrb TCNT0=0x26;
sfrb OCR0A=0x27;
sfrb OCR0B=0x28;
sfrb GPIOR1=0x2a;
sfrb GPIOR2=0x2b;
sfrb SPCR=0x2c;
sfrb SPSR=0x2d;
sfrb SPDR=0x2e;
sfrb ACSR=0x30;
sfrb MONDR=0x31;
sfrb SMCR=0x33;
sfrb MCUSR=0x34;
sfrb MCUCR=0x35;
sfrb SPMCSR=0x37;
sfrb SPL=0x3d;
sfrb SPH=0x3e;
sfrb SREG=0x3f;
#pragma used-
// Interrupt vectors definitions
void lcd_init(void);
void lcd_init(void);
   void lcd_puts(unsigned char *str);
   void lcdLoadCustomChar(void);
    void lcd_data(unsigned char data1,unsigned char type);
    void clear_lcd(void);
          void cmd(unsigned char inst);
 void data_lcd(unsigned char data1);
// void string_lcd(unsigned char *str);
// void lcd_goto(unsigned char  colm, unsigned char line);
 void lcd_goto(unsigned char line , unsigned char colm);
 void lcd_cmd(unsigned char inst);      
 void cal_ascii(unsigned int value);
//#include <lcd16x1.h> 

// CodeVisionAVR C Compiler
// (C) 1998-2000 Pavel Haiduc, HP InfoTech S.R.L.
#pragma used+
void delay_us(unsigned int n);
void delay_ms(unsigned int n);
#pragma used-
/* CodeVisionAVR C Compiler
   Prototypes for standard library functions

   (C) 1998-2003 Pavel Haiduc, HP InfoTech S.R.L.
*/
#pragma used+
int atoi(char *str);
long int atol(char *str);
float atof(char *str);
void itoa(int n,char *str);
void ltoa(long int n,char *str);
void ftoa(float n,unsigned char decimals,char *str);
void ftoe(float n,unsigned char decimals,char *str);
void srand(int seed);
int rand(void);
void *malloc(unsigned int size);
void *calloc(unsigned int num, unsigned int size);
void *realloc(void *ptr, unsigned int size); 
void free(void *ptr);
#pragma used-
#pragma library stdlib.lib
// CodeVisionAVR C Compiler
// (C) 1998-2005 Pavel Haiduc, HP InfoTech S.R.L.
// Prototypes for string functions
#pragma used+
char *strcat(char *str1,char *str2);
char *strcatf(char *str1,char flash *str2);
char *strchr(char *str,char c);
signed char strcmp(char *str1,char *str2);
signed char strcmpf(char *str1,char flash *str2);
char *strcpy(char *dest,char *src);
char *strcpyf(char *dest,char flash *src);
unsigned char strcspn(char *str,char *set);
unsigned char strcspnf(char *str,char flash *set);
unsigned int strlenf(char flash *str);
char *strncat(char *str1,char *str2,unsigned char n);
char *strncatf(char *str1,char flash *str2,unsigned char n);
signed char strncmp(char *str1,char *str2,unsigned char n);
signed char strncmpf(char *str1,char flash *str2,unsigned char n);
char *strncpy(char *dest,char *src,unsigned char n);
char *strncpyf(char *dest,char flash *src,unsigned char n);
char *strpbrk(char *str,char *set);
char *strpbrkf(char *str,char flash *set);
signed char strpos(char *str,char c);
char *strrchr(char *str,char c);
char *strrpbrk(char *str,char *set);
char *strrpbrkf(char *str,char flash *set);
signed char strrpos(char *str,char c);
char *strstr(char *str1,char *str2);
char *strstrf(char *str1,char flash *str2);
unsigned char strspn(char *str,char *set);
unsigned char strspnf(char *str,char flash *set);
char *strtok(char *str1,char flash *str2);
 unsigned int strlen(char *str);
void *memccpy(void *dest,void *src,char c,unsigned n);
void *memchr(void *buf,unsigned char c,unsigned n);
signed char memcmp(void *buf1,void *buf2,unsigned n);
signed char memcmpf(void *buf1,void flash *buf2,unsigned n);
void *memcpy(void *dest,void *src,unsigned n);
void *memcpyf(void *dest,void flash *src,unsigned n);
void *memmove(void *dest,void *src,unsigned n);
void *memset(void *buf,unsigned char c,unsigned n);
#pragma used-
#pragma library string.lib
unsigned int i;
unsigned char st[]="PAGE TURNER",maths,science,start,st0[]="  AUTOMATIC ",st2[]="PROCESS STARTED";
// USART Receiver buffer
char rx_buffer0[8];
unsigned char rx_wr_index0,rx_rd_index0,rx_counter0;
// This flag is set on USART Receiver buffer overflow
bit rx_buffer_overflow0;
// USART Receiver interrupt service routine
interrupt [19] void usart_rx_isr(void)
{
char status,data;
status=(*(unsigned char *) 0xc0);
data=(*(unsigned char *) 0xc6);
if ((status & ((1<<4) | (1<<2) | (1<<3)))==0)
   {
   rx_buffer0[rx_wr_index0]=data;
   if (++rx_wr_index0 == 8) rx_wr_index0=0;
   if (++rx_counter0 == 8)
      {
      rx_counter0=0;
      rx_buffer_overflow0=1;
      };
   };
}
// Get a character from the USART Receiver buffer
#pragma used+
char getchar(void)
{
char data;
while (rx_counter0==0);
data=rx_buffer0[rx_rd_index0];
if (++rx_rd_index0 == 8) rx_rd_index0=0;
#asm("cli")
--rx_counter0;
#asm("sei")
return data;
}
#pragma used-
// USART Transmitter buffer
char tx_buffer0[8];
unsigned char tx_wr_index0,tx_rd_index0,tx_counter0;
// USART Transmitter interrupt service routine
interrupt [21] void usart_tx_isr(void)
{
if (tx_counter0)
   {
   --tx_counter0;
   (*(unsigned char *) 0xc6)=tx_buffer0[tx_rd_index0];
   if (++tx_rd_index0 == 8) tx_rd_index0=0;
   };
}
// Write a character to the USART Transmitter buffer
#pragma used+
void putchar(char c)
{
while (tx_counter0 == 8);
#asm("cli")
if (tx_counter0 || (((*(unsigned char *) 0xc0) & (1<<5))==0))
   {
   tx_buffer0[tx_wr_index0]=c;
   if (++tx_wr_index0 == 8) tx_wr_index0=0;
   ++tx_counter0;
   }
else
   (*(unsigned char *) 0xc6)=c;
#asm("sei")
}
#pragma used-
// Standard Input/Output functions
// CodeVisionAVR C Compiler
// (C) 1998-2003 Pavel Haiduc, HP InfoTech S.R.L.
// Prototypes for standard I/O functions
// CodeVisionAVR C Compiler
// (C) 1998-2002 Pavel Haiduc, HP InfoTech S.R.L.
// Variable length argument list macros
typedef char *va_list;
#pragma used+
char getchar(void);
void putchar(char c);
void puts(char *str);
void putsf(char flash *str);
char *gets(char *str,unsigned int len);
void printf(char flash *fmtstr,...);
void sprintf(char *str, char flash *fmtstr,...);
void vprintf (char flash * fmtstr, va_list argptr);
void vsprintf (char *str, char flash * fmtstr, va_list argptr);
signed char scanf(char flash *fmtstr,...);
signed char sscanf(char *str, char flash *fmtstr,...);
                                               #pragma used-
#pragma library stdio.lib
// Declare your global variables here
void main(void)
{
// Declare your local variables here
// Crystal Oscillator division factor: 1
#pragma optsize-
(*(unsigned char *) 0x61)=0x80;
(*(unsigned char *) 0x61)=0x00;
#pragma optsize+
// Input/Output Ports initialization
// Port B initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTB=0x00;
DDRB=0x07;
// Port C initialization
// Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTC=0x00;
DDRC=0x0f;
// Port D initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTD=0x0c;
DDRD=0xf0;
// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: Timer 0 Stopped
// Mode: Normal top=FFh
// OC0A output: Disconnected
// OC0B output: Disconnected
TCCR0A=0x00;
TCCR0B=0x00;
TCNT0=0x00;
OCR0A=0x00;
OCR0B=0x00;
// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: Timer 1 Stopped
// Mode: Normal top=FFFFh
// OC1A output: Discon.
// OC1B output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer 1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
(*(unsigned char *) 0x80)=0x00;
(*(unsigned char *) 0x81)=0x00;
(*(unsigned char *) 0x85)=0x00;
(*(unsigned char *) 0x84)=0x00;
(*(unsigned char *) 0x87)=0x00;
(*(unsigned char *) 0x86)=0x00;
(*(unsigned char *) 0x89)=0x00;
(*(unsigned char *) 0x88)=0x00;
(*(unsigned char *) 0x8b)=0x00;
(*(unsigned char *) 0x8a)=0x00;
// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: Timer 2 Stopped
// Mode: Normal top=FFh
// OC2A output: Disconnected
// OC2B output: Disconnected
(*(unsigned char *) 0xb6)=0x00;
(*(unsigned char *) 0xb0)=0x00;
(*(unsigned char *) 0xb1)=0x00;
(*(unsigned char *) 0xb2)=0x00;
(*(unsigned char *) 0xb3)=0x00;
(*(unsigned char *) 0xb4)=0x00;
// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// Interrupt on any change on pins PCINT0-7: Off
// Interrupt on any change on pins PCINT8-14: Off
// Interrupt on any change on pins PCINT16-23: Off
(*(unsigned char *) 0x69)=0x00;
EIMSK=0x00;
(*(unsigned char *) 0x68)=0x00;
// Timer/Counter 0 Interrupt(s) initialization
(*(unsigned char *) 0x6e)=0x00;
// Timer/Counter 1 Interrupt(s) initialization
(*(unsigned char *) 0x6f)=0x00;
// Timer/Counter 2 Interrupt(s) initialization
(*(unsigned char *) 0x70)=0x00;
// USART initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART Receiver: On
// USART Transmitter: On
// USART0 Mode: Asynchronous
// USART Baud rate: 9600
(*(unsigned char *) 0xc0)=0x00;
(*(unsigned char *) 0xc1)=0xD8;
(*(unsigned char *) 0xc2)=0x06;
(*(unsigned char *) 0xc5)=0x00;
(*(unsigned char *) 0xc4)=0x19;
// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
(*(unsigned char *) 0x7b)=0x00;
// Global enable interrupts
#asm("sei")  
lcd_init();
clear_lcd();
lcd_cmd(0x80);
 lcd_puts(st0); 
 lcd_cmd(0xC0);
 lcd_puts(st); 
delay_ms(2000); 
if(PIND.2==0)
{
// putchar('A');  
maths=1;
science=0;
}  
else
{
 maths=0;
science=1;
} 
// PORTC.1=0;  
//  PORTC.2=1;
//  delay_ms(1000);
//  PORTC.1=0;  
//  PORTC.2=0;
while (1)
      {
      // Place your code here
      if(start==1)
      {
//       if(maths==1)
//       putchar('A'); 
//       if(science==1)
//       putchar('B'); 
      for(i=0;i<15;i++) 
            { 
       if(maths==1)
      putchar('A'); 
      if(science==1)
      putchar('B'); 
 PORTC.0=1;
 delay_ms(2000);
 PORTC.1=1;  
 PORTC.2=0;
 delay_ms(650);
 PORTC.1=0;  
 PORTC.2=0; 
 PORTC.0=0; 
 delay_ms(1000);
 PORTC.1=0;  
 PORTC.2=1;
 delay_ms(650);
 PORTC.1=0;  
 PORTC.2=0;
 delay_ms(10000);
 }
   #asm
   rjmp 0x0000
   #endasm
      } 
      if(PIND.3==0)
{ 
delay_ms(200);
if(PIND.3==0)
{
start=1;
clear_lcd();
lcd_cmd(0x80);
 lcd_puts(st2); 
} 
}
      };
}
