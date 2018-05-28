// Program 1 - encoder

/*
s0: LFSR
s1: write head after spaces
s2: space char
s3: msg length
*/
program1:

		// Initialize special registers

		set s2, 0x20		// s2 <- space char (0x20)
		set s3, 41			// s3 <- msg length (41)

		// Set up taps for the LFSR

		mov r0, s3 			// r0 <- msg length (41)
		inc r0
		ld	r1, r0			// r1 <- LFSR pattern (42)
		lfsrs		r1		

		inc r0
		ld  r1, r0			// r1 <- LFSR start state (43)
		mov s0, r1

		// Pad with spaces

		mov r0, s3			// r0 <- msg length (41)
		ld  r0, r0			// r0 <- how many spaces to pad

		set r2, 64			// r2 <- encrypted message destination

		add r1, r2			// r1 <- 64 (r2) + how many spaces to pad (r0)
		mov s1, r1			// s1 <- first position after spaces

		mov r0, s3			// r0 <- space char

while1:
		lfsrn 	s0
		xor r3, s0			// r3 <- LFSR (s0) ^ space char (r0)
		st	r2, r3 			// [dest itr] <- r3
		inc r2					// increment dest itr

		cmp r2, s1			// dest itr ?= first position after spaces
		bne while1

		// Encrypt message
		mov r2, s1			// r2 <- first position after spaces, itr
		clr r1					// r1 <- reset message iterator to 0 (0->41)

while2:
		ld  r0, r1			// r0 <- message char
		lfsrn  s0			  
		xor r0, s0			// r0 <- message char (r0) ^ LFSRN (s0)
		st  r2, r0			// [itr] <- r0
		
		inc r1					// increment itr
		cmp r1, s3			// itr ?= message length
		bne while2
