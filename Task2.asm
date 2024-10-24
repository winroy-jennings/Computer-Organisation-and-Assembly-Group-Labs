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
      menu     db,    10, 13,"Simple Digit Calculator",10,13, "1. Addition",10,13,"2. Multiplication",10,13,"3.Subtraction",10,13,"4.Exit", "$"
      menu_prompt db, 10, 13,"Please enter a number for the menu: ", "$"
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
        
    menu_prompts:
        
        ; Menu
        mov dx, offset menu
        mov ah, 09h
        int 21h
        
        mov dx, offset menu_prompt
        mov ah, 09h
        int 21h
        
        mov ah, 01h
        int 21h
        
        mov bh, al
        
        jmp operation_prompt
        
    operation_prompt:
        ; Prompts the user to enter a number
        mov dx, offset str1
        mov ah, 09h
        int 21h
        
        ; Receive's the input from user
        mov ah, 01h
        int 21h
        
        ; Moves the value from al to bh
        mov bl, al
        
        ; Prompts the user to enter a number
        mov dx, offset str2
        mov ah, 09h
        int 21h
        
        ; Receive's the input from user
        mov ah, 01h
        int 21h
        
        CMP bl, '0' ; The decimal number is 48
        JB invalid_input ; This is saying that if number is less than 48 then it is not a single digit
        CMP bl, '9' ; The decimal number is 57
        JA invalid_input
        
        CMP al, '0'
        JB invalid_input
        CMP al, '9'
        JA invalid_input
        
        jmp menu_check
        
    menu_check:
        cmp bh, '1'
        mov bh, al
        je addition
        cmp bh, '2'
        je invalid_input
        
        
    invalid_input:
        mov dx, offset invalid
        mov ah, 09h
        int 21h
        
        mov dx, offset new_line
        mov ah, 09h
        int 21h
        
        jmp menu_prompts
        
    addition:
        sub bl, 48
        sub bh, 30h
        ; Adds the first digit to the second digit
        add bl, bh
        
        ; Clears the AH registry
        mov ah, 0
        
        ; Adjust Accumulator After Addition
        ; Moves the carry bit to AH if AL exceeds 
        aaa
        
        ; 48 is the ASCII for 0
        ; This converts the hexidecimal number to ASCII character
        add ah, 48
        add bl, 48
        
        ; Stores the value into bx registry
        mov ch, ah
        mov cl, bl 
        
        ; Output a newline
        mov dx, offset new_line
        mov ah, 09h
        int 21h
        
        ; Output the first number
        mov dl, bl
        mov ah, 02h
        int 21h
        
        mov dx, offset operator
        mov ah, 09h
        int 21h
        
        ; Output the second number
        mov dl, bh
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
        
        jmp menu_prompts
        
    exit:
        ; Exit the program
        mov ah, 04ch
        int 21h
    end start