stm8/
	;------------------------------------------------------
	; SEGMENT MAPPING FILE AUTOMATICALLY GENERATED BY STVD
	; SHOULD NOT BE MANUALLY MODIFIED.
	; CHANGES WILL BE LOST WHEN FILE IS REGENERATED.
	;------------------------------------------------------
	#include "mapping.inc"

	BYTES			; The following addresses are 8 bits long
	segment byte at ram0_segment_start-ram0_segment_end 'ram0'

	WORDS			; The following addresses are 16 bits long
	segment byte at ram1_segment_start-ram1_segment_end 'ram1'

	WORDS			; The following addresses are 16 bits long
	segment byte at stack_segment_start-stack_segment_end 'stack'

	WORDS			; The following addresses are 16 bits long
	segment byte at 4000-427F 'eeprom'

	WORDS			; The following addresses are 16 bits long
	segment byte at 8080-9FFF 'rom'

	WORDS			; The following addresses are 16 bits long
	segment byte at 8000-807F 'vectit'

		END
