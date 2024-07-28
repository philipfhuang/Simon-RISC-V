.data
again:     .string "Winner! Do you wanna play again?\nPress UP for a new game! Press other buttons for exit"
level:     .string "Current difficulty - numbers of lights - "
newline:   .string "\n"
sequence:  .byte 0,0,0,0

.globl main
.text

main:
    # TODO: Before we deal with the LEDs, we need to generate a random
    # sequence of numbers that we will use to indicate the button/LED
    # to light up. For example, we can have 0 for UP, 1 for DOWN, 2 for
    # LEFT, and 3 for RIGHT. Store the sequence in memory. We provided 
    # a declaration above that you can use if you want.
    # HINT: Use the rand function provided to generate each number
    li a4, 4
    li a5, 5000
    START:
    la a0, newline
    li a7, 4
	ecall

    la a0, level
    li a7, 4
	ecall

    add a0, a4, x0
    li a7, 1
	ecall

    la a0, newline
    li a7, 4
	ecall

    la t3, sequence
    
    ForInit:
        li t4, 0
    ForLoop:
        bge t4, a4, loopInit
        li a0, 4
        call rand
        sb a0, 0(t3)
        li a0, 10
        addi t3, t3, 1
        addi t4, t4, 1
        call delay
        j ForLoop
   
    # TODO: Now read the sequence and replay it on the LEDs. You will
    # need to use the delay function to ensure that the LEDs light up 
    # slowly. In general, for each number in the sequence you should:
    # 1. Figure out the corresponding LED location and colour
    # 2. Light up the appropriate LED (with the colour)
    # 2. Wait for a short delay (e.g. 500 ms)
    # 3. Turn off the LED (i.e. set it to black)
    # 4. Wait for a short delay (e.g. 1000 ms) before repeating
    loopInit:
        add t4, x0, a4
        li t5, 0
        la t3, sequence
    WHILE:
        beq t4, x0, DONE
        lb t6, (0)t3
        beq t5, t6, LED1
        addi t5, t5, 1
        beq t5, t6, LED2
        addi t5, t5, 1
        beq t5, t6, LED3
        addi t5, t5, 1
        beq t5, t6, LED4
        
    LED1:
        li a0, 0xfcba03
        li a1, 0
        li a2, 0
        call setLED
        add a0, x0, a5
        call delay
        li a0, 0
        li a1, 0
        li a2, 0
        call setLED
        li a0, 500
        call delay
        li t5, 0
        j loopFoot
    LED2:
        li a0, 0xffffff
        li a1, 1
        li a2, 0
        call setLED
        add a0, x0, a5
        call delay
        li a0, 0
        li a1, 1
        li a2, 0
        call setLED
        li a0, 500
        call delay
        li t5, 0
        j loopFoot
    LED3:
        li a0, 0x00ff00
        li a1, 0
        li a2, 1
        call setLED
        add a0, x0, a5
        call delay
        li a0, 0
        li a1, 0
        li a2, 1
        call setLED
        li a0, 500
        call delay
        li t5, 0
        j loopFoot
    LED4:
        li a0, 0x0000ff
        li a1, 1
        li a2, 1
        call setLED
        add a0, x0, a5
        call delay
        li a0, 0
        li a1, 1
        li a2, 1
        call setLED
        li a0, 500
        call delay
        li t5, 0
        j loopFoot
    loopFoot:
        addi t4, t4, -1
        addi t3, t3, 1
        j WHILE
    DONE:
        
    
    
    # TODO: Read through the sequence again and check for user input
    # using pollDpad. For each number in the sequence, check the d-pad
    # input and compare it against the sequence. If the input does not
    # match, display some indication of error on the LEDs and exit. 
    # Otherwise, keep checking the rest of the sequence and display 
    # some indication of success once you reach the end.
    loopInit2:
        la t4, sequence
        add t5, x0, a4
    WHILE2:
        beq t5, x0, DONE2
        lb t6, (0)t4
        call pollDpad
        li t3, 0
        mv a3, a0
        beq t3, a0, LED11
        addi t3, t3, 1
        beq t3, a0, LED12
        addi t3, t3, 1
        beq t3, a0, LED13
        addi t3, t3, 1
        beq t3, a0, LED14
    COMPARE:
        bne a3, t6, end
        addi t5, t5, -1
        addi t4, t4, 1
        j WHILE2
        
    LED11:
        li a0, 0xfcba03
        li a1, 0
        li a2, 0
        call setLED
        j COMPARE
    LED12:
        li a0, 0xffffff
        li a1, 1
        li a2, 0
        call setLED
        j COMPARE
    LED13:
        li a0, 0x00ff00
        li a1, 0
        li a2, 1
        call setLED
        j COMPARE
    LED14:
        li a0, 0x0000ff
        li a1, 1
        li a2, 1
        call setLED
        j COMPARE
    
    # TODO: Ask if the user wishes to play again and either loop back to
    # start a new round or terminate, based on their input.
    DONE2:
        la a0, again
        li a7, 4
        ecall
        addi a4, a4, 1
        if:
            li t0, 600
            blt a5, t1, else
            addi a5, a5, -500
        else:
        
        li a0, 0x00ff00
        li a1, 0
        li a2, 0
        call setLED

        li a0, 0x00ff00
        li a1, 1
        li a2, 0
        call setLED

        li a0, 0x00ff00
        li a1, 0
        li a2, 1
        call setLED

        li a0, 0x00ff00
        li a1, 1
        li a2, 1
        call setLED
        
        li a0, 2000
        call delay
        
        li a0, 0
        li a1, 0
        li a2, 0
        call setLED

        li a0, 0
        li a1, 1
        li a2, 0
        call setLED

        li a0, 0
        li a1, 0
        li a2, 1
        call setLED

        li a0, 0
        li a1, 1
        li a2, 1
        call setLED
        
        call pollDpad
        beq a0, x0, START
        j exit
    end:
        li a0, 0xff0000
        li a1, 0
        li a2, 0
        call setLED
        li a0, 0xff0000
        li a1, 1
        li a2, 0
        call setLED
        li a0, 0xff0000
        li a1, 1
        li a2, 1
        call setLED
        li a0, 0xff0000
        li a1, 0
        li a2, 1
        call setLED
        
        li a0, 3000
        call delay
        
        li a0, 0
        li a1, 0
        li a2, 0
        call setLED

        li a0, 0
        li a1, 1
        li a2, 0
        call setLED

        li a0, 0
        li a1, 0
        li a2, 1
        call setLED

        li a0, 0
        li a1, 1
        li a2, 1
        call setLED
        j exit
exit:
    li a7, 10
    ecall
    
    
# --- HELPER FUNCTIONS ---
# Feel free to use (or modify) them however you see fit
     
# Takes in the number of milliseconds to wait (in a0) before returning
delay:
    mv t0, a0
    li a7, 30
    ecall
    mv t1, a0
delayLoop:
    ecall
    sub t2, a0, t1
    bgez t2, delayIfEnd
    addi t2, t2, -1
delayIfEnd:
    bltu t2, t0, delayLoop
    jr ra

# Takes in a number in a0, and returns a (sort of) random number from 0 to
# this number (exclusive)
rand:
    mv t0, a0
    li a7, 30
    ecall
    remu a0, a0, t0
    jr ra
    
# Takes in an RGB color in a0, an x-coordinate in a1, and a y-coordinate
# in a2. Then it sets the led at (x, y) to the given color.
setLED:
    li t1, LED_MATRIX_0_WIDTH
    mul t0, a2, t1
    add t0, t0, a1
    li t1, 4
    mul t0, t0, t1
    li t1, LED_MATRIX_0_BASE
    add t0, t1, t0
    sw a0, (0)t0
    jr ra
    
# Polls the d-pad input until a button is pressed, then returns a number
# representing the button that was pressed in a0.
# The possible return values are:
# 0: UP
# 1: DOWN
# 2: LEFT
# 3: RIGHT
pollDpad:
    mv a0, zero
    li t1, 4
pollLoop:
    bge a0, t1, pollLoopEnd
    li t2, D_PAD_0_BASE
    slli t3, a0, 2
    add t2, t2, t3
    lw t3, (0)t2
    bnez t3, pollRelease
    addi a0, a0, 1
    j pollLoop
pollLoopEnd:
    j pollDpad
pollRelease:
    lw t3, (0)t2
    bnez t3, pollRelease
pollExit:
    jr ra
