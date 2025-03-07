.globl main 
.equ STDOUT, 1
.equ STDIN, 0
.equ __NR_READ, 63
.equ __NR_WRITE, 64
.equ __NR_EXIT, 93

.text
main:
    # main() prolog
    addi sp, sp, -112      # Allocate extra space
    sw ra, 108(sp)         # Save return address

    # main() body

    # Call write_string function (Print prompt)
    la a1, prompt
    addi a2, zero, prompt_end - prompt
    jal write_string

    # Save `ra` before calling read_string
    sw ra, 104(sp)         

    # Call read_string function
    mv a1, sp              # Pass buffer (stack pointer) as argument
    addi a2, zero, 100     # Maximum bytes to read
    jal read_string        # Jump to function

    # Restore `ra` after calling read_string
    lw ra, 104(sp)

    # Call write_string to echo user input
    mv a1, sp      # Pass buffer (user input) as argument
    mv a2, a0      # Number of bytes read (stored in a0 from read_string)
    jal write_string

    # main() epilog
    lw ra, 108(sp)         # Restore return address
    addi sp, sp, 112       # Restore stack pointer
    li a7, __NR_EXIT
    ecall  # Properly exit the program

# Function: write_string
# Arguments:
#   a1 - Address of string
#   a2 - Length of string
# Returns:
#   None
write_string:
    li a7, __NR_WRITE   # Load syscall for write
    li a0, STDOUT       # STDOUT file descriptor
    ecall               # Perform system call
    ret                 # Return to caller

# Function: read_string
# Arguments:
#   a1 - Buffer address (where input should be stored)
#   a2 - Maximum bytes to read
# Returns:
#   a0 - Number of bytes read
read_string:
    li a7, __NR_READ  # Load syscall for read
    li a0, STDIN      # STDIN file descriptor (0)
    ecall             # Perform system call
    ret               # Return to caller

.data
prompt:   .ascii  "Enter a message: "
prompt_end:
