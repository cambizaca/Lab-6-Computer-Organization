 #---------------------------------
# Lab 6: Pixel Conversion
#
# Name: Christian Cambizaca
#
# --------------------------------
# Below is the expected output.
# 
# Converting pixels to grayscale:
# 0
# 1
# 2
# 34
# 5
# 67
# 89
# Finished.
# -- program is finished running --
#---------------------------------

.data 0x0
  startString:  .asciiz "Converting pixels to grayscale:\n"
  finishString: .asciiz "Finished.\n"
  newline:      .asciiz "\n"
  pixels:       .word   0x00010000, 0x010101, 0x6,      0x3333,
                        0x030c,     0x700853, 0x294999, -1

  
.text 0x3000

main:
  addi $v0, $0, 4       	# system call code 4 for printing a string
  la   $a0, startString      	# put address of startString in $a0
  syscall               	# print the string
  
#------- INSERT YOUR CODE HERE -------
#
#
# Write a loop that reads the array pixels using "lw",
#   one word at a time, until a -1 is encountered, which
#   indicates the end of the array.
  add $t0, $0, $0 # i=0
loop:
  lw $t1, pixels($t0)
  # add $t1, $0, $t1
  beq $t1, -1, exit
  andi $a2, $t1, 0xFF #blue value     
  srl $t1, $t1, 8
  andi $a1, $t1, 0xFF #green value
  srl $t1, $t1, 8
  andi $a0, $t1, 0xFF  #red value
  srl $t1, $t1, 8

  jal rgb_to_gray #at end, jr
  # $a0 = return val
  # v0 = 1
  # syscall
  
  add $t7, $0, $v0
  
  addi $v0, $0, 1  
  add  $a0, $0, $t7 
  syscall  
  
  addi 	$v0, $0, 4  			# system call 4 is for printing a string
  la 	$a0, newline 			# address of areaIs string is in $a0
  syscall 
  
  addi $t0, $t0, 4 #i++
  
  
  j loop
  
  
     #shifting the array we tryna access; converting "i" to word offset 

			# system call 4 is for printing a string
 		        # address of heightPrompt is in $a0
    


  
# Each pixel value is a word, of the form 0x00RRGGBB,
#   so your program here should take the rightmost 2 hexits (8 bits)
#   and use that as the blue value, 
#   the next 2 hexits as green, 
#   the next 2 hexits as red.  

#   The leftmost 2 hexits are not needed,
#   and will be zero.


  
 
  
  

#
# After extracting the R, G and B values into $a0, $a1 and $a2,
#   you must then call the procedure rgb_to_gray below using
#   "jal rgb_to_gray", which will compute and return the gray
#   value.
#
# Your code should then print this gray value on the terminal,
#   before moving on to the next pixel value.  For printing,
#   you will need to use a MIPS system call available in MARS.
#   Specifically, it is syscall 1.  The code to print an integer,
#   say the value in $8, is like this:
#
#     addi $v0, $0, 1  // put 1 in $v0 to indicate which syscall
#     add  $a0, $0, $8 // put value to be printed in $a0
#     syscall          // and then execute "syscall"
#
# Continue looping through the array "pixels", until a -1 is
#   encountered, at which point you should exit your loop.
#
# There is already code below that prints the final message "Finished.",
#   and terminate the program.
#
 
  
 
  
  j loop
#------------ END CODE ---------------


exit:

  addi $v0, $0, 4            	# system call code 4 for printing a string
  la   $a0, finishString   	# put address of finishString in $a0
  syscall               	# print the string

  addi $v0, $0, 10      	# system call code 10 for exit
  syscall               	# exit the program



#----------------------------------------------------------#



#---- Procedure rgb_to_gray ----#
#
#
#-------------------------------#

rgb_to_gray:            # procedure to calculate gray = (red + green + blue) / 3
                        # red is in $a0, green is in $a1, blue is in $a2
                        # gray should be computed in $v0 (return value)
                        # there is no need to use a stack
#------- INSERT YOUR CODE HERE -------
#
# Simply add instructions here to calculate
#   gray = (red + green + blue) / 3
#
#   i.e., $v0 = ($a0 + $a1 + $a2) / 3
#
#  That's it!
  add $a0, $a0, $a1
  add $a0, $a0, $a2
  div $v0, $a0, 3         #grey
  
#------------ END CODE ---------------

  jr $ra                # return to main
