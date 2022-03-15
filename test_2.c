#include "3140_concur.h"
#include "utils.h"

// We will be stealing this blinking function, thank you very much!
void p1 (void) {
	int i;
	for (i=0; i < 13; i++) {
		delay ();
    	LEDRed_Toggle();
	}
}

// This process includes an infinite loop; this should be no problem
// for our glorious scheduler
void p2 (void) {
	LEDGreen_On();
	LEDRed_Off();

	while (1);
}

void p3 (void) {
	LEDRed_On();
	LEDGreen_Off();
}

int main (void) {
	LED_Initialize();

	if (process_create (p1,32) < 0) {
		return -1;
	}

	if (process_create (p2,32) < 0) {
		return -1;
	}

	if (process_create (p3,32) < 0) {
		return -1;
	}

	process_start ();

	/*
	This is our original test. We are initializing three processes,
	one of which contains an infinite loop. Of course, this will be
	no match for our Round Robin scheduler, which can temporarily
	halt the process mid-infinite loop to give the other processes
	a chance to shine! So, we should see some toggling of the red
	LED, followed by the green LED turning on, and then off when
	the red LED turns on, and then some more toggling of the red
	LED before turning off for good.
	 */

	while (1) ;

	return 0;
}
