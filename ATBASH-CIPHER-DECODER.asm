TITLE ATBASH_CIPHER_DECODER
.MODEL SMALL
.STACK 100H

.DATA
    ; Encoded lines of text (ATBASH cipher)
    line1  DB ' DROW JFVHGRLM NZIPH ZMW WVERLFH HVNRPLORFNZI UZILLJ UZI UZI ZDZBNFSZNNZW SFAZRUZ$', 13, 10
    line2  DB ' GSV SVZWORMV LU ZOKSZYVG EROOZTV ZMW GSV HFYORMV LU SVI LDM ILZWAZRMZY JFIVHSR  HSV SZW Z OZHG ERVD YZXP LM GSV HPBORMV LU SVI SLNVGLDM YLLPNZIPHTILEVAZRMZY  ZMQFN$', 13, 10
    line3  DB ' Z OZITV OZMTFZTV LXVZM Z HNZOO IREVI MZNVW WFWVM UOLDH YB GSVRI KOZXV ZMW HFKKORVH RG DRGS GSV MVXVHHZIB IVTVORZORZ RG RH Z KZIZWRHVNZGRX XLFMGIBUZIRZ QZEZRW$', 13, 10
    line4  DB ' YVXZFHV GSVIV DVIV GSLFHZMWH LU YZW XLNNZHUZIDZS SZNRW LMV WZB SLDVEVI Z HNZOO ORMV LU YORMW GVCG YB GSV MZNV LU OLIVN RKHFN WVXRWVW GL OVZEV ULI NFSZNNZW HZZWFOOZS$', 13, 10
    line5  DB 'GSV YRT LCNLC ZWERHVW SVI MLG GL WL HLNFSZNNZW AFYZRI  KFG SVI RMRGRZO RMGL GSV YVOG ZMW NZWV SVIHVOU LM GSV DZB. DSVM HSV IVZXSVW GSV URIHG SROOH LU GSV RGZORX NLFMGZRMHRIFN RNGRZA$', 13, 10
    line6  DB ' GSV SVZWORMV LU ZOKSZYVG EROOZTV ZMW GSV HFYORMV LU SVI LDM ILZWQZDZW ZYYZHR  DROW JFVHGRLM NZIPH ZMW WVERLFH HVNRPLORSZNAZ HSZFPZG$', 13, 10
    line7  DB ' GSVIV OREV GSV YORMW GVCGH  HVKZIZGVW GSVB OREV RM YLLPNZIPHTILEV IRTSG ZG GSV XLZHG LU GSV HVNZMGRXHNFSZNNZW HZNVVO$', 13, 10
    line8  DB ' Z OZITV OZMTFZTV LXVZM Z HNZOO IREVI MZNVW WFWVM UOLDH YB GSVRI KOZXV ZMW HFKKORVH RG DRGS GSV MVXVHHZIB IVTVORZORZ. RG RH Z KZIZWRHVNZGRX XLFMGIBNFMZAAZ ZSNVW$', 13, 10
    line9  DB ' RM DSRXS ILZHGVW KZIGH LU HVMGVMXVH UOB RMGL BLFI NLFGS. VEVM GSV ZOO-KLDVIUFO KLRMGRMT SZH ML XLMGILO ZYLFG GSV YORMW GVCGH RG RH ZM ZONLHG FMLIGSLTIZKSRX ORUV GSVHSZSZY RHSZJ$', 13, 10
    line10 DB " YVXZFHV GSVIV DVIV GSLFHZMWH LU YZW XLNNZHHBVWZ HFNRBZ  YFG GSV ORGGOV YORMW GVCG WRWM'G ORHGVM  HSV KZXPVW SVI HVEVM EVIHZORZFHNZM ZHRU$", 13, 10
    line11 DB ' KFG SVI RMRGRZO RMGL GSV YVOG ZMW NZWV SVIHVOU LM GSV DZB  DSVM HSV IVZXSVW GSV URIHG SROOH LU GSV RGZORX NLFMGZRMHAZRMZY ZHRN$', 13, 10
    line12 DB ' GSV ORMV OZMV  KRGBUFO Z IVGSLIRX JFVHGRLM IZM LEVI SVI XSVVPNZMZSRO PSZM  YVSRMW GSV DLIW NLFMGZRMHZYWFO SZHVVY$', 13, 10
    line13 DB ' UZI UILN GSV XLFMGIRVH ELPZORZ ZMW XLMHLMZMGRZZYWFOOZS WUH  GSV ORMV OZMV  KRGBUFO Z IVGSLIRX JFVHGRLM IZM LEVI SVI XSVVPVHSZ HSZNIZRA$', 13, 10
    line14 DB " YFG GSV ORGGOV YORMW GVCG WRWM'G ORHGVM  HSV KZXPVW SVI HVEVM EVIHZORZRIUZM IRZA  YVSRMW GSV DLIW NLFMGZRMHNFSZNNZW HZONZM$", 13, 10
    line15 DB 'LMV WZB SLDVEVI Z HNZOO ORMV LU YORMW GVCG YB GSV MZNV LU OLIVN RKHFN WVXRWVW GL OVZEV ULI ZOR ZYYZH UZI UZI ZDZBNLSZNVW ZSHZM$', 13, 10

    ; Array of pointers to each line
    lines DW offset line1, offset line2, offset line3, offset line4
         DW offset line5, offset line6, offset line7, offset line8
         DW offset line9, offset line10, offset line11, offset line12
         DW offset line13, offset line14, offset line15

    ; Buffer for decoded text
    decoded    DB 200 DUP('$')
    ; Target name to search for
    targetName DB 'ZAINAB QURESHI$'
    ; Flags and counters
    foundFlag  DB 0
    line_num   DB 0

    ; Messages for output
    msg_found     DB 13, 10, 'Name found on line: $'
    msg_not_found DB 13, 10, 'Name not found$'
    newline       DB 13, 10, '$'

.CODE
MAIN PROC
    ; Initialize data segment
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX

    ; Set up loop counter and line pointer
    MOV CX, 15           ; Total lines to process
    MOV SI, OFFSET lines ; Pointer to line addresses
    MOV line_num, 1      ; Current line number

NEXT_LINE:
    ; Get next line address
    LODSW               ; Load offset into AX
    PUSH CX            ; Save loop counter
    PUSH SI            ; Save line pointer

    ; Decode the current line
    MOV DX, AX         ; Pass line offset in DX
    CALL DECODE_LINE

    ; Search for target name in decoded text
    LEA SI, decoded    ; Source = decoded text
    LEA DI, targetName ; Target = "ZAINAB QURESHI"
    CALL SEARCH_NAME

    ; Check if name was found
    CMP AL, 1          ; AL=1 if found
    JE FOUND_LINE

    ; Not found - restore and continue
    POP SI
    POP CX
    INC line_num       ; Increment line counter
    LOOP NEXT_LINE     ; Process next line

    ; Name not found in any line
    LEA DX, msg_not_found
    MOV AH, 09H        ; Print "not found" message
    INT 21H
    JMP EXIT

FOUND_LINE:
    ; Name found - print results
    MOV foundFlag, 1   ; Set found flag
    LEA DX, msg_found
    MOV AH, 09H        ; Print "found" message
    INT 21H

    ; Print line number
    MOV DL, line_num
    ADD DL, '0'        ; Convert to ASCII
    MOV AH, 02H
    INT 21H

    ; Print newline
    LEA DX, newline     
    MOV AH, 09H
    INT 21H

    ; Print decoded line
    LEA DX, decoded     
    MOV AH, 09H
    INT 21H

    ; Clean up stack
    POP SI              
    POP CX

EXIT:
    ; Terminate program
    MOV AH, 4CH         
    INT 21H
MAIN ENDP

; ===== PROCEDURES =====

; Decodes a line of ATBASH-encoded text
; Input: DX = offset of encoded string
; Output: decoded buffer filled with result
DECODE_LINE PROC
    PUSH SI
    PUSH DI
    MOV SI, DX          ; Source = encoded line
    LEA DI, decoded     ; Destination = decoded buffer

DEC_LOOP:
    ; Get next character
    LODSB               ; AL = [SI], SI++
    CMP AL, '$'         ; Check for end marker
    JE END_DEC

    ; Check if uppercase letter (A-Z)
    CMP AL, 'A'
    JB STORE_CHAR       ; Skip if below 'A'
    CMP AL, 'Z'
    JA STORE_CHAR       ; Skip if above 'Z'

    ; ATBASH transformation: map A<->Z, B<->Y, etc.
    MOV BL, AL          ; Save original char
    SUB BL, 'A'         ; Convert to 0-25 (A=0, Z=25)
    MOV BH, 25          ; Max index
    SUB BH, BL          ; Reverse position (25 - index)
    ADD BH, 'A'         ; Convert back to ASCII
    MOV AL, BH          ; Store transformed char

STORE_CHAR:
    ; Store character (either original or transformed)
    STOSB               ; [DI] = AL, DI++
    JMP DEC_LOOP

END_DEC:
    ; Null-terminate the decoded string
    MOV AL, '$'         
    STOSB
    POP DI
    POP SI
    RET
DECODE_LINE ENDP

; Searches for target name in decoded text
; Input: SI = decoded text, DI = target name
; Output: AL = 1 if found, 0 otherwise
SEARCH_NAME PROC
    PUSH CX
    PUSH SI
    PUSH DI

SEARCH_LOOP:
    ; Check first part of name ("ZAINAB")
    MOV CX, 6           ; Length of "ZAINAB"
    PUSH SI
    PUSH DI
    REPE CMPSB          ; Compare strings
    POP DI
    POP SI
    JNZ NEXT_CHAR       ; Jump if no match

    ; Verify space after first name
    CMP BYTE PTR [SI+6], ' '
    JNE NEXT_CHAR

    ; Check second part of name (" QURESHI")
    LEA DI, targetName+7 ; Point to last name
    MOV CX, 7            ; Length of " QURESHI"
    PUSH SI
    ADD SI, 7            ; Skip past first name
    REPE CMPSB           ; Compare strings
    POP SI
    JNZ NEXT_CHAR

    ; Full name found
    MOV AL, 1
    JMP END_SEARCH

NEXT_CHAR:
    ; Move to next character in decoded text
    INC SI
    CMP BYTE PTR [SI], '$' ; Check for end
    JE NOT_FOUND
    JMP SEARCH_LOOP

NOT_FOUND:
    ; Name not found
    MOV AL, 0

END_SEARCH:
    POP DI
    POP SI
    POP CX
    RET
SEARCH_NAME ENDP

END MAIN