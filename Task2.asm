; Names:
;   Renae Beckford
;   Enoch Omoregie
;   Kemar Knight
;   Winroy Jennings
;
; Date: 24, October 2024
; Tutor: Ms. Karlene M. Black
; Topic: Task 2

.model small
.data
      menu     db,    10, 13, "Addition of two single digit numbers.", "$"
      str1     db,    10, 13, "Please enter a number: ", "$"
      str2     db,    10, 13, "Please enter a second number: ", "$"
      operator db,    "+ ", "$"
      equal    db,    "= ", "$"
      new_line db,    10, 13, "$"
      
      invalid db, 10, 13, "Invalid input, try again!", "$", 10, 13
    
.code
    start:
        ; loads the data into the data segment
        mov ax, @data
        mov ds, ax
        
        ; Menu
        mov dx, offset menu
        mov ah, 09h
        int 21h
        
    first_prompt:
        ; Prompts the user to enter a number
        mov dx, offset str1
        mov ah, 09h
        int 21h
        
        ; Receive's the input from user
        mov ah, 01h
        int 21h
        
        ; Moves the value from al to bh
        mov bh, al
        
    second_prompt:
        ; Prompts the user to enter a number
        mov dx, offset str2
        mov ah, 09h
        int 21h
        
        ; Receive's the input from user
        mov ah, 01h
        int 21h
        
        ; Moves the value from al to bl
        mov bl, al
        
        CMP bh, '0' ; The decimal number is 48
        JB invalid_input ; This is saying that if number is less than 48 then it is not a single digit
        CMP bh, '9' ; The decimal number is 57
        JA invalid_input
        
        CMP bl, '0'
        JB invalid_input
        CMP bl, '9'
        JA invalid_input
        
        jmp skip_inval
        
    invalid_input:
        mov dx, offset invalid
        mov ah, 09h
        int 21h
        
        mov dx, offset new_line
        mov ah, 09h
        int 21h
        
        jmp first_prompt
        
    skip_inval:
        ; Adds the first digit to the second digit
        add al, bh
        
        ; Clears the AH registry
        mov ah, 0
        
        ; Adjust Accumulator After Addition
        ; Moves the carry bit to AH if AL exceeds 
        aaa
        
        ; 48 is the ASCII for 0
        ; This converts the hexidecimal number to ASCII character
        add ah, 48
        add al, 48
        
        ; Stores the value into bx registry
        mov ch, ah
        mov cl, al 
        
        ; Output a newline
        mov dx, offset new_line
        mov ah, 09h
        int 21h
        
        ; Output the first number
        mov dl, bh
        mov ah, 02h
        int 21h
        
        mov dx, offset operator
        mov ah, 09h
        int 21h
        
        ; Output the second number
        mov dl, bl
        mov ah, 02h
        int 21h
        
        mov dx, offset equal
        mov ah, 09h
        int 21h
        
        ; Output answer        
        mov dl, ch
        mov ah, 02h
        int 21h
        
        mov dl, cl
        mov ah, 02h
        int 21h
        
        ; Exit the program
        mov ah, 04ch
        int 21h
    end start