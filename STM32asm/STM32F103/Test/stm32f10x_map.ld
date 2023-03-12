/* STM32F10x, flash 64 kb, sram 20 kb, bkpsram hz */

MEMORY
{
	/* FLASH - Программная flash память */
	FLASH      (RX)  : ORIGIN = 0x08000000, LENGTH = 64K

}
SECTIONS
{
	.text : { /* Секция прошивки */
		*(.text);   /* Секция исходников */
	} > FLASH
}