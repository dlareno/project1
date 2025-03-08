.globl main
.equ STDOUT, 1
.equ STDIN, 0
.equ SYS_WRITE, 64
.equ SYS_READ, 63
.equ SYS_EXIT, 93

.text
main:
    # Print prompt
    la a1, prompt
    call puts  # Call puts function

    # Read input
    la a1, buffer  # Address of buffer
    li a2, 100  # Max bytes to read
    call gets  # Call gets function

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

# Function: gets (Reads user input)
gets:
    li a7, SYS_READ  # System call for reading
    li a0, STDIN  # Read from standard input
    ecall  # Read input into a1 (buffer)
    ret

.data
prompt: .asciz "Enter a message: "
buffer: .space 100  # Allocate space for input (100 bytes)
