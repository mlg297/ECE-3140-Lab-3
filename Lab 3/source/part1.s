.section .text
.global main


//Set up constants for port. Don't Change!
.equ 	PCRD5, 		0x4004C014 //PORTD_PCR5   (GREEN), the manual has these backward
.equ 	SCGC5, 		0x40048038 //SIM_SCGC5    address
.equ 	PDDRD,  	0x400FF0D4 //GPIOB_PDDR   address
.equ 	PCORD,  	0x400FF0C8 //GPIOB_PCOR   address
.equ 	PSORD,  	0x400FF0C4 //GPIOB_PSOR   address


.equ 	twelve, 	0x00001000  // 1 << 12, for turning on port clock
.equ 	eight, 		0x00000100  // 1 << 8,  for setting MUX to GPIO
.equ	five, 		0x00000020  // 1 << 5,  for manipulating PIN


/*
---  Write your code below this line ---
Feel free to include additional label as needed.
*/


main:

       //Feel free to remove any unnecesary commands
	MOV   R0, #7
	BL    LEDSETUP
	ca1:
		CMP	  R0, #1
		BNE	  ca2
		BL	  M1
	ca2:
		CMP	  R0, #2
		BNE	  ca3
		BL	  M2
	ca3:
		CMP	  R0, #3
		BNE	  ca4
		BL	  M3
	ca4:
		CMP	  R0, #4
		BNE	  ca5
		BL	  M4
	ca5:
		CMP	  R0, #5
		BNE	  ca6
		BL	  M5
	ca6:
		CMP	  R0, #6
		BNE	  ca7
		BL	  M6
	ca7:
		CMP	  R0, #7
		BNE	  ca8
		BL	  M7
	ca8:
		CMP	  R0, #8
		BNE	  ca9
		BL	  M8
	ca9:
		CMP	  R0, #9
		BNE	  ca0
		BL	  M9
	ca0:
		CMP	  R0, #0
		BNE	  ca42
		BL	  M0
	ca42:				// The answer to Life, the Universe, and Everything: 42
	B     forever // after you program runs, it should enter this infinite loop

MorseDigit:
	// R1 is n
	PUSH  {LR}

	POP	  {PC}

fib:
 	// Your code goes here!
	// R1 is n, R0 is result

DOTCL:			// dot cycle
	PUSH  {LR}
	BL	  LEDON
	BL	  DOT
	BL	  LEDOFF
	BL	  DOT
	POP	  {PC}

DASHCL:			// dash cycle
	PUSH  {LR}
	BL	  LEDON
	BL	  DASH
	BL	  LEDOFF
	BL	  DOT
	POP	  {PC}

M1:
	PUSH  {LR}
	BL	  LEDON
	BL	  DOTCL
	BL	  DASHCL
	BL	  DASHCL
	BL	  DASHCL
	BL	  DASHCL
	POP	  {PC}
	BX	  LR

M2:
	PUSH  {LR}
	BL	  LEDON
	BL	  DOTCL
	BL	  DOTCL
	BL	  DASHCL
	BL	  DASHCL
	BL	  DASHCL
	POP	  {PC}
	BX	  LR

M3:
	PUSH  {LR}
	BL	  LEDON
	BL	  DOTCL
	BL	  DOTCL
	BL	  DOTCL
	BL	  DASHCL
	BL	  DASHCL
	POP	  {PC}
	BX	  LR

M4:
	PUSH  {LR}
	BL	  LEDON
	BL	  DOTCL
	BL	  DOTCL
	BL	  DOTCL
	BL	  DOTCL
	BL	  DASHCL
	POP	  {PC}
	BX	  LR

M5:
	PUSH  {LR}
	BL	  LEDON
	BL	  DOTCL
	BL	  DOTCL
	BL	  DOTCL
	BL	  DOTCL
	BL	  DOTCL
	POP	  {PC}
	BX	  LR

M6:
	PUSH  {LR}
	BL	  LEDON
	BL	  DASHCL
	BL	  DOTCL
	BL	  DOTCL
	BL	  DOTCL
	BL	  DOTCL
	POP	  {PC}
	BX	  LR

M7:
	PUSH  {LR}
	BL	  LEDON
	BL	  DASHCL
	BL	  DASHCL
	BL	  DOTCL
	BL	  DOTCL
	BL	  DOTCL
	POP	  {PC}
	BX	  LR

M8:
	PUSH  {LR}
	BL	  LEDON
	BL	  DASHCL
	BL	  DASHCL
	BL	  DASHCL
	BL	  DOTCL
	BL	  DOTCL
	POP	  {PC}
	BX	  LR

M9:
	PUSH  {LR}
	BL	  LEDON
	BL	  DASHCL
	BL	  DASHCL
	BL	  DASHCL
	BL	  DASHCL
	BL	  DOTCL
	POP	  {PC}
	BX	  LR

M0:
	PUSH  {LR}
	BL	  LEDON
	BL	  DASHCL
	BL	  DASHCL
	BL	  DASHCL
	BL	  DASHCL
	BL	  DASHCL
	POP	  {PC}
	BX	  LR

DOT:
	PUSH  {R2, R3, R4, R5, R6, R7}
	for0:
		MOVS  R2, #127
	next0:
		BLT	  end0
		for1:
			MOVS  R6, #127
		next1:
			BLT   end1
			for2:
				MOVS  R4, #127
			next2:
				BLT   end2
				ADD   R5, R5, R4
				SUB   R4, #1
				B	  next2
			end2:
			ADD   R7, R7, R6
			SUB	  R6, #1
			B	  next1
		end1:
		ADD	  R3, R3, R2
		SUB	  R2, #1
		B next0
	end0:
	POP	  {R2, R3, R4, R5, R6, R7}
	BX LR

DASH:
	PUSH  {LR}
	BL	  DOT
	BL	  DOT
	BL	  DOT
	POP   {PC}
	BX LR

/*
---  And above this one ---
*/

// Call this function first to set up the LED
// You only need to call this once
LEDSETUP:
	PUSH  {R4, R5}    //To preserve R4 and R5
	LDR   R4, =twelve // Load the value 1 << 12
	LDR   R5, =SCGC5
	STR   R4, [R5]

	LDR   R4, =eight  //MUX Port to be GPIO
	LDR   R5, =PCRD5
	STR   R4, [R5]

	LDR   R4, =five
	LDR   R5, =PDDRD
	STR   R4, [R5]
	POP   {R4, R5}
	BX    LR

// The functions below are for you to use freely
LEDON:
	PUSH  {R4, R5}
	LDR   R4, =five
	LDR   R5, =PCORD
	STR   R4, [R5]
	POP   {R4, R5}
	BX    LR

LEDOFF:
	PUSH  {R4, R5}
	LDR   R4, =five
	LDR   R5, =PSORD
	STR   R4, [R5]
	POP   {R4, R5}
	BX    LR

//wait forever
forever:
	B		forever
	.end

