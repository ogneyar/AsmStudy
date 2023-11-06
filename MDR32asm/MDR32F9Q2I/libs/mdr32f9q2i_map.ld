/* MDR32F92QI, flash 128 kb, sram 32 kb */

MEMORY
{
	/* FLASH - Программная flash память */
	FLASH      (RX)  : ORIGIN = 0x08000000, LENGTH = 128K

}
SECTIONS
{
	.text : { /* Секция прошивки */
		*(.text);   /* Секция исходников */
	} > FLASH
}