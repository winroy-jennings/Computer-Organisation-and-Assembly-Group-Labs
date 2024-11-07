; Names:
;   Renae Beckford
;   Enoch Omoregie
;   Kemar Knight
;   Winroy Jennings
;
; Date: 29, October 2024
; Tutor: Ms. Karlene M. Black
; Topic: Task 2

.model small

.data
      menu          db 10, 13, "Single Digit Calculator", 10, 13, "1. Addition", 10, 13, "2. Multiplication", 10, 13, "3. Subtraction", 10, 13, "4. Exit", "$"
      prompt_op     db 10, 13, "Please select an option (1-4): $"
      str1          db 10, 13, "Please enter the first digit (0-9): $"
      str2          db 10, 13, "Please enter the second digit (0-9): $"
      equal         db " = ", "$"
      invalid_str   db 10, 13, "Invalid input, try again!", "$"
      operator      db " ", "$" ; placeholder for operation symbol
      new_line      db 10, 13, "$"
      
      result db 0

.code
    start:
        ; Load data segment
        mov ax, @data
        mov ds, ax

    main_menu:
        ; Display menu
        mov dx, offset menu
        mov ah, 09h
        int 21h

        ; Prompt for operation choice
        mov dx, offset prompt_op
        mov ah, 09h
        int 21h

        ; Get user input for operation
        mov ah, 01h
        int 21h
        
        cmp al, '1'
        jb invalid_input ; Invalid if less than 1
        cmp al, '4'
        ja invalid_input ; Invalid if greater than 4
        
        mov cl, al        ; Store operation choice in CL

        cmp cl, '4'
        jne get_first_digit   ; Exit if choice is 4
        
        mov ah, 04ch
        int 21h
        
    invalid_input:
        ; Display invalid choice message
        mov dx, offset invalid_str
        mov ah, 09h
        int 21h
        jmp main_menu

        ; Prompt for first number
    get_first_digit:
        mov dx, offset str1
        mov ah, 09h
        int 21h

        ; Get first digit input
        mov ah, 01h
        int 21h
        
        cmp al, '0'
        jb invalid_input
        
        cmp al, '9'
        ja invalid_input
        
        mov bh, al        ; Store first digit in BH

    ; Prompt for second number
    get_second_digit:
        mov dx, offset str2
        mov ah, 09h
        int 21h

        ; Get second digit input
        mov ah, 01h
        int 21h
        
        cmp al, '0'
        jb invalid_input
        
        cmp al, '9'
        ja invalid_input
        
        mov bl, al        ; Store second digit in BL

        ; Perform chosen operation
        mov al, bh        ; Move first digit to AL
        
        cmp cl, '1'
        je addition
        
        cmp cl, '2'
        je multiplication
        
        cmp cl, '3'
        je subtraction

    addition:
        add al, bl
        mov ah, 0
        
        aaa
        
        mov ch, ah
        mov cl, al
        
        mov operator, '+'
        jmp display_result

    multiplication:
        ; Convert ASCII to numeric value
        sub bh, '0'         ; Convert first ASCII digit to numeric value (0-9)
        sub bl, '0'         ; Convert second ASCII digit to numeric value (0-9)

        ; Multiply digits
        mov al, bh          ; Move first numeric digit to AL
        mul bl              ; Multiply AL by BL (result in AX)

        ; Check if the result is a two-digit number
        cmp ax, 10
        jb single_digit_result_multiplication

        ; If two-digit result, split into tens and units digits
        ; Get the tens digit
        mov cx, 10          ; Set divisor to 10
        xor dx, dx          ; Clear DX for division
        div cx              ; Divide AX by 10 (quotient in AL, remainder in AH)

        ; Convert and display tens digit
        mov dl, al          ; Move the quotient (tens digit) to DL
        add dl, '0'         ; Convert to ASCII
        mov ah, 02h
        int 21h             ; Display the tens digit

        ; Convert and display units digit
        mov dl, ah          ; Move the remainder (units digit) to DL
        add dl, '0'         ; Convert to ASCII
        mov ah, 02h
        int 21h             ; Display the units digit

        jmp output_result

    single_digit_result_multiplication:

        ; Single-digit result
        add al, '0'         ; Convert result to ASCII
        mov dl, al
        mov ah, 02h
        int 21h             ; Display the single-digit result

    output_result:
        ; Output newline after result
        mov dx, offset new_line
        mov ah, 09h
        int 21h

        jmp main_menu

    subtraction:
        sub al, bl
        
        mov ch, 0
        mov cl, al
        
        mov operator, '-'
        
        js neg_substraction
        jmp display_result
        
    neg_substraction:
        ; Convert result to ASCII
        neg cl 
        add cl, '0'
        

        ; Output newline
        mov dx, offset new_line
        mov ah, 09h
        int 21h

        ; Output first digit
        mov dl, bh
        mov ah, 02h
        int 21h

        ; Output operator
        mov dx, offset operator
        mov ah, 09h
        int 21h

        ; Output second digit
        mov dl, bl
        mov ah, 02h
        int 21h

   
        ; Output equal sign and result
        mov dx, offset equal
        mov ah, 09h
        int 21h
        
        mov dx, offset operator
        mov ah, 09h
        int 21h
        
        mov ch, '0'
        
        mov dl, ch
        mov ah, 02h
        int 21h

        mov dl, cl        ; Output result
        mov ah, 02h
        int 21h

        ; Newline after result
        mov dx, offset new_line
        mov ah, 09h
        int 21h
        
        jmp main_menu

    display_result:
        ; Convert result to ASCII
        add ch, '0'
        add cl, '0'

        ; Output newline
        mov dx, offset new_line
        mov ah, 09h
        int 21h

        ; Output first digit
        mov dl, bh
        mov ah, 02h
        int 21h

        ; Output operator
        mov dx, offset operator
        mov ah, 09h
        int 21h

        ; Output second digit
        mov dl, bl
        mov ah, 02h
        int 21h
   
        ; Output equal sign and result
        mov dx, offset equal
        mov ah, 09h
        int 21h
        
        mov dl, ch
        mov ah, 02h
        int 21h

        mov dl, cl        ; Output result
        mov ah, 02h
        int 21h

        ; Newline after result
        mov dx, offset new_line
        mov ah, 09h
        int 21h

        ; Go back to main menu
        jmp main_menu

    exit_program:
        ; Exit program
        mov ah, 4Ch
        int 21h
end start
