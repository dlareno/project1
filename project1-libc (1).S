.globl main
.equ STDOUT, 1
.equ SYS_WRITE, 64
.equ SYS_EXIT, 93

.text
main:
    # Print prompt
    la a1, prompt
    call puts  # Call puts function

    # Exit program
    li a7, SYS_EXIT
    ecall

# Function: puts (Prints a string)
puts:
    mv t0, a1  # Load address of string
puts_loop:
    lb a0, 0(t0)  # Load character
    beqz a0, puts_done  # Stop at null terminator
    li a7, SYS_WRITE
    li a0, STDOUT
    addi a2, zero, 1  # Write one character
    ecall
    addi t0, t0, 1  # Move to next character
    j puts_loop

puts_done:
    ret

.data
prompt: .asciz "Enter a message: "
