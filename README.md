## Compiler, Interpreter & Processor
Whole pipeline from compilation of simple C-code to execution on FPGA implemented. Compiler compiles c to assembly code in the file "asm_code" and the same code in hexadecimal in the file "rom.hex". The assembly code is used by the interpreter to simulate the execution, and the hexadesimal file by the FPGA to execute the code.

## Compilator:
* Variable definitions, assigment
* arithmetic expressions
* if/else
* while

![compiler](Compiler.png?raw=true "Title")

## Interpreter
* For testing the assembly code with simple c-structures as registers/memory

## Processor
* AFC
* ADD, SOU, MUL
* STORE, LOAD
* EQU
* Treatment of register read/write hazards between consequent instructions

![processor](Processor.png?raw=true "Title")
