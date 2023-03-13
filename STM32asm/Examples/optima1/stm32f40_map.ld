/* STM32F40x, flash 1 mb, sram 192 kb, bkpsram 4 kb */

MEMORY
{
	/* FLASH - Программная flash память */
	FLASH      (RX)  : ORIGIN = 0x08000000, LENGTH = 1024K

}
SECTIONS
{
	.text : { 
		*(.text);   /* Текст программы */
	} > FLASH
}