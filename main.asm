start:
		MOV DPTR, #TABLE; | Move Array to to DPTR
		MOV R3, #00H; | Set Display 3 Value
		MOV R2, #02H; | Set Display 2 Value
		MOV R1, #00H; | Set Display 1 Value
		MOV R0, #00H; | Set Display 0 Value
		CALL timer; | Main function
       
timer:
		CALL ds3; | Show Display 3
		CALL check0; | Check if values meet conditions
		JMP timer; | Jump back to start of function
       
ds3:
		CALL display3; | Set to display3
		MOV A, R3; | Use display value as array position
		MOVC A, @A+DPTR; | Set A to current value + 1 in array
		MOV P1,A; | Send A to current display
		ACALL delay;
		CALL ds2; | Show Display 2
		RET;
       
ds2:
		CALL display2; | Set to display2
		MOV A, R2;
		MOVC A, @A+DPTR;
		SUBB A, #80H; | Light Decimal Point
		MOV P1, A;
		ACALL delay;
		CALL ds1; | Show Display 1
		RET;
       
ds1:
		CALL display1; | Set to display1
		MOV A, R1;
		MOVC A, @A+DPTR;
		MOV P1, A;
		ACALL delay;
		CALL ds0; | Show Display 0
		RET;
       
ds0:
		CALL display0; | Set to display0
		MOV A, R0;
		MOVC A, @A+DPTR;
		MOV P1, A;
		ACALL delay;
		RET;

check2: 
		MOV R1, #05H; | Reset R1 to 5
		MOV ACC, R2; 
		JZ loop; | Program finished if R2 is zero
		DEC R2;
		RET;
       
check1:
		MOV R0, #09H; | Reset R0 to 9
		MOV ACC, R1;
		JZ check2;
		DEC R1;
		RET;
       
check0:
		MOV ACC, R0;
		JZ check1;
		DEC R0;
		RET;
       
delay:
		MOV R4, #0AH; 
		DJNZ R4, $; | loop until 0
		RET;
       
display3:
		SETB P3.3;
		SETB P3.4;
		RET;
       
display2:
		CLR P3.3;
		RET;
       
display1:
		CLR P3.4;
		SETB P3.3;
		RET;
      
display0:
		CLR P3.3;
		RET;

loop:
		CALL display3;
		MOV P1, #86H; | Flash LEDs
		ACALL delay;
		CALL display2;
		MOV P1, #0C8H; | Error if 0 is removed
		ACALL delay;
		CALL display1;
		MOV P1, #40H;
		ACALL delay;
		SJMP loop; | Endless loop
       
TABLE: 
      	DB C0H, F9H, A4H, B0H, 99H, 92H, 82H, F8H, 80H, 98H; | Lookup table filled with numbers
