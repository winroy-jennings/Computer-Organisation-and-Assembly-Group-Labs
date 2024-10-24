; Names:
;   Renae Beckford
;   Enoch Omoregie
;   Kemar Knight
;   Winroy Jennings

.model small
.data
      str1     db,    10, 13, "Please enter a number: ", "$"
      str2     db,    10, 13, "Please enter a second number: ", "$"
      operator db,    10, 13, "+", "$"
      equal    db,    10, 13, "=", "$"
    
.code
    start:
        ; loads the data into the data segment
        mov ax, @data
        mov ds, ax
        
        ; Prompts the user to enter a number
        mov dx, offset str1
        mov ah, 09h
        int 21h
        
        ; Receive's the input from user
        mov ah, 01h
        int 21h
        
        ; Moves the value from al to bh
        mov bh, al
        
        ; Prompts the user to enter a number
        mov dx, offset str2
        mov ah, 09h
        int 21h
        
        ; Receive's the input from user
        mov ah, 01h
        int 21h
        
        ; Moves the value from al to bl
        mov bl, al
        
        ; Exit the program
        mov ah, 04ch
        int 21h
    end start